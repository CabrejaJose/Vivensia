-- Hogares: creación atómica, validaciones y privilegios.
begin;

select tests.create_user('alice@example.test', 'Alice') as alice \gset
select tests.create_user('bob@example.test', 'Bob') as bob \gset

set local role anon;
select tests.throws($$select public.create_household('Casa', 'EUR', 'Europe/Madrid')$$,
  '42501', 'anon no puede crear hogares');
select tests.throws('select * from public.households', '42501', 'anon no puede leer hogares');
reset role;

select set_config('request.jwt.claim.sub', :'alice', true);
set local role authenticated;

select (public.create_household('  Casa Alice  ', 'dop', 'America/Santo_Domingo')).id as h1 \gset

select tests.is((select name from public.households where id = :'h1'), 'Casa Alice',
  'create_household recorta el nombre');
select tests.is((select currency_code::text from public.households where id = :'h1'), 'DOP',
  'la moneda se normaliza a mayúsculas (ISO 4217)');
select tests.is((select role::text from public.household_members
                 where household_id = :'h1' and user_id = :'alice'), 'owner',
  'quien crea el hogar es owner');
select tests.is((select count(*)::int from public.household_members where household_id = :'h1'), 1,
  'el hogar nuevo tiene un único integrante');

select tests.throws($$select public.create_household('X', 'US', 'UTC')$$, '23514',
  'moneda con formato inválido rechazada');
select tests.throws($$select public.create_household('X', 'USD', 'Marte/Olympus')$$, '22023',
  'zona horaria inválida rechazada');
select tests.throws($$select public.create_household('   ', 'USD', 'UTC')$$, '23514',
  'nombre vacío rechazado');
select tests.throws($$insert into public.households (name, currency_code, time_zone) values ('X', 'USD', 'UTC')$$,
  '42501', 'no se pueden insertar hogares directamente');
select tests.throws(format(
  'insert into public.household_members (household_id, user_id, role) values (%L, %L, %L)',
  :'h1', :'bob', 'owner'), '42501', 'no se pueden insertar integrantes directamente');
select tests.throws(format('update public.households set created_by = %L where id = %L', :'bob', :'h1'),
  '42501', 'no se puede cambiar created_by');
select tests.throws(format('update public.households set time_zone = %L where id = %L', 'Nada/Nada', :'h1'),
  '22023', 'actualizar a zona horaria inválida rechazado');

-- Límite anti-abuso: 20 hogares propios.
select tests.ok((select count(*) from (
  select public.create_household('Extra ' || g, 'EUR', 'UTC') from generate_series(1, 19) g) s) = 19,
  'se pueden crear hasta 20 hogares propios');
select tests.throws($$select public.create_household('Uno más', 'EUR', 'UTC')$$, 'P0001',
  'el hogar número 21 se rechaza');

reset role;

-- ── Bob no ve ni modifica el hogar de Alice ──
select set_config('request.jwt.claim.sub', :'bob', true);
set local role authenticated;
select tests.is((select count(*)::int from public.households), 0, 'Bob no ve hogares ajenos');
select tests.is(tests.affected(format('update public.households set name = %L where id = %L', 'Mío', :'h1')), 0,
  'Bob no puede renombrar el hogar de Alice');
select tests.is(tests.affected(format('delete from public.households where id = %L', :'h1')), 0,
  'Bob no puede eliminar el hogar de Alice');
reset role;

-- Sin sesión (auth.uid() nulo) create_household falla aunque el rol lo permita.
select set_config('request.jwt.claim.sub', '', true);
set local role authenticated;
select tests.throws($$select public.create_household('X', 'EUR', 'UTC')$$, '28000',
  'create_household exige usuario autenticado');
reset role;

rollback;

-- Perfiles: creación automática, privacidad y privilegios.
begin;

select tests.create_user('alice@example.test', 'Alice') as alice \gset
select tests.create_user('bob@example.test') as bob \gset
insert into auth.users (email, raw_user_meta_data)
values ('eve@example.test', '{"display_name": "   ", "locale": "fr"}') returning id as eve \gset

-- Como superusuario (equivale a service_role).
select tests.is((select display_name from public.profiles where id = :'alice'), 'Alice',
  'el registro crea el perfil con el nombre de los metadatos');
select tests.ok((select display_name is null from public.profiles where id = :'bob'),
  'sin nombre en metadatos el perfil queda sin nombre (no se usa el email)');
select tests.is((select locale from public.profiles where id = :'eve'), 'es',
  'idioma no soportado en metadatos cae a es');
select tests.ok((select display_name is null from public.profiles where id = :'eve'),
  'nombre en blanco se guarda como null');
select tests.ok(not exists (
  select 1 from information_schema.columns
  where table_schema = 'public' and table_name = 'profiles' and column_name = 'email'),
  'profiles no duplica el email');

-- ── anon ──
set local role anon;
select tests.throws('select * from public.profiles', '42501', 'anon no puede leer perfiles');
reset role;

-- ── Alice autenticada ──
select set_config('request.jwt.claim.sub', :'alice', true);
set local role authenticated;

select tests.is((select count(*)::int from public.profiles), 1,
  'sin hogares compartidos Alice solo ve su propio perfil');
select tests.is(tests.affected(format(
  'update public.profiles set display_name = %L where id = %L', 'Alicia', :'alice')), 1,
  'Alice puede editar su perfil');
select tests.is(tests.affected(format(
  'update public.profiles set display_name = %L where id = %L', 'Hack', :'bob')), 0,
  'Alice no puede editar el perfil de Bob');
select tests.throws(format('update public.profiles set id = gen_random_uuid() where id = %L', :'alice'),
  '42501', 'no se puede cambiar el id del perfil');
select tests.throws(format('update public.profiles set created_at = now() where id = %L', :'alice'),
  '42501', 'no se puede cambiar created_at');
select tests.throws('insert into public.profiles (id) values (gen_random_uuid())',
  '42501', 'no se pueden insertar perfiles directamente');
select tests.throws(format('delete from public.profiles where id = %L', :'alice'),
  '42501', 'no se pueden borrar perfiles directamente');
select tests.throws(format('update public.profiles set display_name = %L where id = %L', '', :'alice'),
  '23514', 'nombre vacío rechazado');
select tests.throws(format('update public.profiles set locale = %L where id = %L', 'fr', :'alice'),
  '23514', 'idioma no soportado rechazado');

reset role;
rollback;

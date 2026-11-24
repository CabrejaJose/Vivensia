-- Aislamiento entre hogares, roles y protección del último owner.
begin;

select tests.create_user('alice@example.test', 'Alice') as alice \gset
select tests.create_user('bob@example.test', 'Bob') as bob \gset
select tests.create_user('carol@example.test', 'Carol') as carol \gset
select tests.create_user('dave@example.test', 'Dave') as dave \gset

-- Preparación como servicio: H1 (Alice owner, Bob admin, Carol member); H2 (Dave owner).
insert into public.households (id, name, currency_code, time_zone, created_by) values
  ('00000000-0000-0000-0000-0000000000a1', 'Casa 1', 'EUR', 'Europe/Madrid', :'alice'),
  ('00000000-0000-0000-0000-0000000000b2', 'Casa 2', 'USD', 'America/New_York', :'dave');
insert into public.household_members (household_id, user_id, role, joined_at) values
  ('00000000-0000-0000-0000-0000000000a1', :'alice', 'owner', now() - interval '3 days'),
  ('00000000-0000-0000-0000-0000000000a1', :'bob', 'admin', now() - interval '2 days'),
  ('00000000-0000-0000-0000-0000000000a1', :'carol', 'member', now() - interval '1 day'),
  ('00000000-0000-0000-0000-0000000000b2', :'dave', 'owner', now());
\set h1 '00000000-0000-0000-0000-0000000000a1'
\set h2 '00000000-0000-0000-0000-0000000000b2'

-- ── Carol (member de H1) ──
select set_config('request.jwt.claim.sub', :'carol', true);
set local role authenticated;
select tests.is((select array_agg(name order by name) from public.households), array['Casa 1'],
  'Carol solo ve su hogar');
select tests.is((select count(*)::int from public.household_members), 3,
  'Carol ve los 3 integrantes de su hogar y ninguno ajeno');
select tests.is((select count(*)::int from public.profiles), 3,
  'Carol ve los perfiles de su hogar (no el de Dave)');
select tests.is((select count(*)::int from public.profiles where id = :'dave'), 0,
  'Carol no ve el perfil de Dave');
select tests.is(tests.affected(format('update public.households set name = %L where id = %L', 'X', :'h1')), 0,
  'un member no puede editar el hogar');
select tests.is(tests.affected(format(
  'update public.household_members set role = %L where household_id = %L and user_id = %L', 'owner', :'h1', :'carol')), 0,
  'un member no puede ascenderse a owner');
select tests.is(tests.affected(format('delete from public.household_members where household_id = %L and user_id = %L', :'h1', :'bob')), 0,
  'un member no puede expulsar a otros');
select tests.throws(format(
  'update public.household_members set household_id = %L where household_id = %L and user_id = %L', :'h2', :'h1', :'carol'),
  '42501', 'no se puede mover una membresía a otro hogar');
reset role;

-- ── Dave (otro hogar) no ve nada de H1 ──
select set_config('request.jwt.claim.sub', :'dave', true);
set local role authenticated;
select tests.is((select count(*)::int from public.households where id = :'h1'), 0, 'Dave no ve H1');
select tests.is((select count(*)::int from public.household_members where household_id = :'h1'), 0,
  'Dave no ve integrantes de H1');
select tests.is((select count(*)::int from public.profiles where id in (:'alice', :'bob', :'carol')), 0,
  'Dave no ve perfiles de H1');
select tests.is(tests.affected(format('delete from public.households where id = %L', :'h1')), 0,
  'Dave no puede eliminar H1');
select tests.is(tests.affected(format('delete from public.household_members where household_id = %L', :'h1')), 0,
  'Dave no puede vaciar H1');
reset role;

-- ── Bob (admin de H1) ──
select set_config('request.jwt.claim.sub', :'bob', true);
set local role authenticated;
select tests.is(tests.affected(format('update public.households set name = %L where id = %L', 'Casa Uno', :'h1')), 1,
  'un admin puede editar el hogar');
select tests.is(tests.affected(format(
  'update public.household_members set role = %L where household_id = %L and user_id = %L', 'owner', :'h1', :'bob')), 0,
  'un admin no puede ascenderse a owner');
select tests.is(tests.affected(format(
  'update public.household_members set role = %L where household_id = %L and user_id = %L', 'member', :'h1', :'alice')), 0,
  'un admin no puede degradar al owner');
select tests.is(tests.affected(format('delete from public.household_members where household_id = %L and user_id = %L', :'h1', :'alice')), 0,
  'un admin no puede expulsar al owner');
select tests.is(tests.affected(format('delete from public.households where id = %L', :'h1')), 0,
  'un admin no puede eliminar el hogar');
select tests.is(tests.affected(format('delete from public.household_members where household_id = %L and user_id = %L', :'h1', :'carol')), 1,
  'un admin puede expulsar a un member');
reset role;

-- Carol ya no comparte hogar: deja de ver y de ser vista.
select set_config('request.jwt.claim.sub', :'alice', true);
set local role authenticated;
select tests.is((select count(*)::int from public.profiles where id = :'carol'), 0,
  'tras salir, Alice ya no ve el perfil de Carol');

-- ── Alice (owner) y protección del último owner ──
select tests.throws(format('delete from public.household_members where household_id = %L and user_id = %L', :'h1', :'alice'),
  'P0001', 'el último owner no puede salir');
select tests.throws(format(
  'update public.household_members set role = %L where household_id = %L and user_id = %L', 'admin', :'h1', :'alice'),
  'P0001', 'el último owner no puede degradarse');
select tests.is(tests.affected(format(
  'update public.household_members set role = %L where household_id = %L and user_id = %L', 'owner', :'h1', :'bob')), 1,
  'un owner puede nombrar a otro owner');
select tests.is(tests.affected(format('delete from public.household_members where household_id = %L and user_id = %L', :'h1', :'alice')), 1,
  'con otro owner presente, Alice puede salir');
select tests.is((select count(*)::int from public.households where id = :'h1'), 0,
  'tras salir, Alice ya no ve H1');
reset role;

-- ── Bob es ahora el único owner y elimina el hogar (cascada) ──
select set_config('request.jwt.claim.sub', :'bob', true);
set local role authenticated;
select tests.is(tests.affected(format('delete from public.households where id = %L', :'h1')), 1,
  'el owner puede eliminar el hogar aunque sea el último owner');
reset role;
select tests.is((select count(*)::int from public.household_members where household_id = :'h1'), 0,
  'eliminar el hogar elimina sus membresías');

rollback;

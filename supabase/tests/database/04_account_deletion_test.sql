-- Eliminación de cuenta: cascadas y sucesión de la propiedad.
begin;

select tests.create_user('alice@example.test', 'Alice') as alice \gset
select tests.create_user('bob@example.test', 'Bob') as bob \gset
select tests.create_user('carol@example.test', 'Carol') as carol \gset
select tests.create_user('dave@example.test', 'Dave') as dave \gset

insert into public.households (id, name, currency_code, time_zone, created_by) values
  ('00000000-0000-0000-0000-0000000000a1', 'Compartido', 'EUR', 'UTC', :'alice'),
  ('00000000-0000-0000-0000-0000000000b2', 'Solo Dave', 'EUR', 'UTC', :'dave');
insert into public.household_members (household_id, user_id, role, joined_at) values
  ('00000000-0000-0000-0000-0000000000a1', :'alice', 'owner', now() - interval '3 days'),
  ('00000000-0000-0000-0000-0000000000a1', :'carol', 'member', now() - interval '1 day'),
  ('00000000-0000-0000-0000-0000000000a1', :'bob', 'member', now() - interval '2 days'),
  ('00000000-0000-0000-0000-0000000000b2', :'dave', 'owner', now());

-- Elimina la cuenta de Alice (último owner con otros integrantes).
delete from auth.users where id = :'alice';
select tests.is((select count(*)::int from public.profiles where id = :'alice'), 0,
  'eliminar la cuenta elimina el perfil');
select tests.is((select role::text from public.household_members
                 where household_id = '00000000-0000-0000-0000-0000000000a1' and user_id = :'bob'), 'owner',
  'la propiedad pasa al integrante más antiguo');
select tests.is((select role::text from public.household_members
                 where household_id = '00000000-0000-0000-0000-0000000000a1' and user_id = :'carol'), 'member',
  'el resto de integrantes mantiene su rol');
select tests.ok((select created_by is null from public.households
                 where id = '00000000-0000-0000-0000-0000000000a1'),
  'created_by queda en null tras eliminar al creador');

-- Elimina la cuenta de Dave (único integrante).
delete from auth.users where id = :'dave';
select tests.is((select count(*)::int from public.households
                 where id = '00000000-0000-0000-0000-0000000000b2'), 0,
  'un hogar sin integrantes se elimina con la última cuenta');

rollback;

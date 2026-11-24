-- ─────────────────────────────────────────────────────────────────────────
-- Vivensia · 0003 · Hogares e integrantes
--
-- Todo dato compartido se aísla por hogar. Roles: owner > admin > member.
-- Reglas de integridad:
--   · Un hogar siempre tiene al menos un owner (salvo al borrarse el hogar).
--   · Si se elimina la cuenta del último owner, la propiedad pasa al integrante
--     más antiguo; si no quedan integrantes, el hogar se elimina.
--   · Los hogares se crean solo con `public.create_household` (atómico).
-- ─────────────────────────────────────────────────────────────────────────

create type public.household_role as enum ('owner', 'admin', 'member');

create table public.households (
  id            uuid primary key default gen_random_uuid(),
  name          text not null check (char_length(btrim(name)) between 1 and 80),
  -- ISO 4217. Configurable por hogar: ninguna moneda fija en la lógica.
  currency_code char(3) not null check (currency_code ~ '^[A-Z]{3}$'),
  -- Zona horaria IANA (validada por trigger).
  time_zone     text not null check (char_length(time_zone) between 1 and 64),
  created_by    uuid references public.profiles (id) on delete set null,
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now()
);

comment on table public.households is 'Hogar: unidad de aislamiento de datos compartidos.';

create index households_created_by_idx on public.households (created_by);

create trigger households_set_updated_at
  before update on public.households
  for each row execute function private.set_updated_at();

create or replace function private.validate_household_time_zone()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  if not exists (select 1 from pg_catalog.pg_timezone_names where name = new.time_zone) then
    raise exception 'invalid_time_zone' using errcode = '22023', detail = new.time_zone;
  end if;
  return new;
end;
$$;

revoke all on function private.validate_household_time_zone() from public;

create trigger households_validate_time_zone
  before insert or update of time_zone on public.households
  for each row execute function private.validate_household_time_zone();

create table public.household_members (
  household_id uuid not null references public.households (id) on delete cascade,
  user_id      uuid not null references public.profiles (id) on delete cascade,
  role         public.household_role not null default 'member',
  joined_at    timestamptz not null default now(),
  updated_at   timestamptz not null default now(),
  primary key (household_id, user_id)
);

comment on table public.household_members is 'Pertenencia de usuarios a hogares y su rol.';

create index household_members_user_id_idx on public.household_members (user_id);

create trigger household_members_set_updated_at
  before update on public.household_members
  for each row execute function private.set_updated_at();

alter table public.households enable row level security;
alter table public.household_members enable row level security;

-- ── Funciones de pertenencia (security definer: evitan recursión de RLS) ──

create or replace function private.is_household_member(p_household_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.household_members m
    where m.household_id = p_household_id
      and m.user_id = (select auth.uid())
  );
$$;

create or replace function private.household_role_of(p_household_id uuid)
returns public.household_role
language sql
stable
security definer
set search_path = ''
as $$
  select m.role
  from public.household_members m
  where m.household_id = p_household_id
    and m.user_id = (select auth.uid());
$$;

create or replace function private.shares_household_with(p_user_id uuid)
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.household_members mine
    join public.household_members theirs
      on theirs.household_id = mine.household_id
    where mine.user_id = (select auth.uid())
      and theirs.user_id = p_user_id
  );
$$;

revoke all on function private.is_household_member(uuid) from public;
revoke all on function private.household_role_of(uuid) from public;
revoke all on function private.shares_household_with(uuid) from public;
grant execute on function private.is_household_member(uuid) to authenticated;
grant execute on function private.household_role_of(uuid) to authenticated;
grant execute on function private.shares_household_with(uuid) to authenticated;

-- ── Protección del último owner ──────────────────────────────────────────

create or replace function private.protect_last_owner()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  if old.role <> 'owner' then
    return coalesce(new, old);
  end if;
  if tg_op = 'UPDATE' and new.role = 'owner' then
    return new;
  end if;

  -- Borrado del hogar completo (cascada): permitido.
  if not exists (select 1 from public.households h where h.id = old.household_id) then
    return coalesce(new, old);
  end if;

  -- Eliminación de la cuenta (cascada desde profiles): permitido; la sucesión
  -- se resuelve en private.handle_owner_succession.
  if tg_op = 'DELETE'
     and not exists (select 1 from public.profiles p where p.id = old.user_id) then
    return old;
  end if;

  if not exists (
    select 1
    from public.household_members m
    where m.household_id = old.household_id
      and m.role = 'owner'
      and m.user_id <> old.user_id
  ) then
    raise exception 'last_owner'
      using errcode = 'P0001',
            hint = 'Transfiere la propiedad o elimina el hogar antes de salir.';
  end if;

  return coalesce(new, old);
end;
$$;

revoke all on function private.protect_last_owner() from public;

create trigger household_members_protect_last_owner
  before update of role or delete on public.household_members
  for each row execute function private.protect_last_owner();

create or replace function private.handle_owner_succession()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_successor uuid;
begin
  if old.role <> 'owner'
     or not exists (select 1 from public.households h where h.id = old.household_id)
     or exists (
       select 1 from public.household_members m
       where m.household_id = old.household_id and m.role = 'owner'
     ) then
    return null;
  end if;

  select m.user_id into v_successor
  from public.household_members m
  where m.household_id = old.household_id
  order by m.joined_at, m.user_id
  limit 1;

  if v_successor is null then
    delete from public.households where id = old.household_id;
  else
    update public.household_members
       set role = 'owner'
     where household_id = old.household_id
       and user_id = v_successor;
  end if;
  return null;
end;
$$;

revoke all on function private.handle_owner_succession() from public;

create trigger household_members_owner_succession
  after delete on public.household_members
  for each row execute function private.handle_owner_succession();

-- ── Creación atómica de hogares ──────────────────────────────────────────

create or replace function public.create_household(
  p_name text,
  p_currency_code text,
  p_time_zone text
)
returns public.households
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_uid       uuid := (select auth.uid());
  v_household public.households;
begin
  if v_uid is null then
    raise exception 'not_authenticated' using errcode = '28000';
  end if;

  -- Límite anti-abuso de hogares propios por usuario.
  if (
    select count(*) from public.household_members m
    where m.user_id = v_uid and m.role = 'owner'
  ) >= 20 then
    raise exception 'household_limit_reached' using errcode = 'P0001';
  end if;

  insert into public.households (name, currency_code, time_zone, created_by)
  values (btrim(p_name), upper(btrim(p_currency_code)), btrim(p_time_zone), v_uid)
  returning * into v_household;

  insert into public.household_members (household_id, user_id, role)
  values (v_household.id, v_uid, 'owner');

  return v_household;
end;
$$;

comment on function public.create_household(text, text, text) is
  'Crea un hogar y registra al usuario actual como owner en una sola transacción.';

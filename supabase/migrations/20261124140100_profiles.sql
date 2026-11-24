-- ─────────────────────────────────────────────────────────────────────────
-- Vivensia · 0002 · Perfiles de usuario
--
-- Un perfil por usuario de Supabase Auth, creado automáticamente.
-- No se copia el email: vive solo en auth.users.
-- ─────────────────────────────────────────────────────────────────────────

create table public.profiles (
  id           uuid primary key references auth.users (id) on delete cascade,
  display_name text check (
    display_name is null or char_length(btrim(display_name)) between 1 and 80
  ),
  avatar_path  text check (avatar_path is null or char_length(avatar_path) <= 512),
  locale       text not null default 'es' check (locale in ('es', 'en')),
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);

comment on table public.profiles is
  'Perfil público dentro de los hogares del usuario. Sin email ni datos sensibles.';
comment on column public.profiles.display_name is
  'Nombre visible para los integrantes de sus hogares. Null hasta el onboarding.';
comment on column public.profiles.avatar_path is
  'Ruta en Storage (bucket privado), nunca una URL pública.';

create trigger profiles_set_updated_at
  before update on public.profiles
  for each row execute function private.set_updated_at();

alter table public.profiles enable row level security;

-- Crea el perfil al registrarse. Solo confía en metadatos con validación.
create or replace function private.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_name   text := nullif(btrim(left(new.raw_user_meta_data ->> 'display_name', 80)), '');
  v_locale text := new.raw_user_meta_data ->> 'locale';
begin
  insert into public.profiles (id, display_name, locale)
  values (
    new.id,
    v_name,
    case when v_locale in ('es', 'en') then v_locale else 'es' end
  );
  return new;
end;
$$;

revoke all on function private.handle_new_user() from public;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function private.handle_new_user();

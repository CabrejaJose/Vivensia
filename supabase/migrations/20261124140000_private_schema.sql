-- ─────────────────────────────────────────────────────────────────────────
-- Vivensia · 0001 · Esquema privado y utilidades comunes
--
-- `private` no está en `[api].schemas` (config.toml): sus funciones no se
-- exponen por la API de datos. Se usa para funciones de seguridad y triggers.
-- ─────────────────────────────────────────────────────────────────────────

create schema if not exists private;

revoke all on schema private from public;
-- Las políticas RLS llaman a funciones de `private` con el rol del usuario.
grant usage on schema private to authenticated, service_role;

-- Mantiene `updated_at` en cada UPDATE.
create or replace function private.set_updated_at()
returns trigger
language plpgsql
set search_path = ''
as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

revoke all on function private.set_updated_at() from public;

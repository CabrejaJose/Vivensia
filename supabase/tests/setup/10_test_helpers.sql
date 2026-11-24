-- SOLO PRUEBAS LOCALES. Utilidades de aserción y de identidad.

create schema if not exists tests;
grant usage on schema tests to anon, authenticated, service_role;

-- Crea un usuario de Auth (el trigger crea su perfil) y devuelve su id.
create or replace function tests.create_user(p_email text, p_name text default null)
returns uuid
language sql
as $$
  insert into auth.users (email, raw_user_meta_data)
  values (
    p_email,
    case when p_name is null then '{}'::jsonb
         else jsonb_build_object('display_name', p_name) end
  )
  returning id;
$$;

create or replace function tests.ok(p_condition boolean, p_description text)
returns void
language plpgsql
as $$
begin
  if p_condition is distinct from true then
    raise exception 'FALLO: %', p_description;
  end if;
  raise notice 'ok - %', p_description;
end;
$$;

create or replace function tests.is(p_actual anyelement, p_expected anyelement, p_description text)
returns void
language plpgsql
as $$
begin
  if p_actual is distinct from p_expected then
    raise exception 'FALLO: % (obtenido: %, esperado: %)', p_description, p_actual, p_expected;
  end if;
  raise notice 'ok - %', p_description;
end;
$$;

-- Ejecuta SQL dinámico y exige que falle con el SQLSTATE indicado.
create or replace function tests.throws(p_sql text, p_sqlstate text, p_description text)
returns void
language plpgsql
as $$
begin
  begin
    execute p_sql;
  exception when others then
    if sqlstate = p_sqlstate then
      raise notice 'ok - %', p_description;
      return;
    end if;
    raise exception 'FALLO: % (SQLSTATE %, esperado %: %)', p_description, sqlstate, p_sqlstate, sqlerrm;
  end;
  raise exception 'FALLO: % (no lanzó error, esperado %)', p_description, p_sqlstate;
end;
$$;

-- Ejecuta SQL dinámico y devuelve el número de filas afectadas.
create or replace function tests.affected(p_sql text)
returns integer
language plpgsql
as $$
declare
  v_count integer;
begin
  execute p_sql;
  get diagnostics v_count = row_count;
  return v_count;
end;
$$;

grant execute on all functions in schema tests to anon, authenticated, service_role;

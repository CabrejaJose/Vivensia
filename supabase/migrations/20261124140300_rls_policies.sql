-- ─────────────────────────────────────────────────────────────────────────
-- Vivensia · 0004 · Privilegios y políticas RLS
--
-- Principio: denegar por defecto. Supabase concede privilegios amplios a
-- `anon` y `authenticated` en `public`; aquí se revocan y se conceden solo
-- los necesarios (incluido UPDATE por columnas). RLS filtra las filas.
-- ─────────────────────────────────────────────────────────────────────────

-- ── Privilegios ──────────────────────────────────────────────────────────

revoke all on table public.profiles from anon, authenticated;
revoke all on table public.households from anon, authenticated;
revoke all on table public.household_members from anon, authenticated;

grant select on table public.profiles to authenticated;
grant update (display_name, avatar_path, locale) on table public.profiles to authenticated;

grant select, delete on table public.households to authenticated;
grant update (name, currency_code, time_zone) on table public.households to authenticated;

grant select, delete on table public.household_members to authenticated;
grant update (role) on table public.household_members to authenticated;

revoke all on function public.create_household(text, text, text) from public, anon;
grant execute on function public.create_household(text, text, text) to authenticated;

-- ── profiles ─────────────────────────────────────────────────────────────

create policy "profiles: ver el propio y los de mis hogares"
  on public.profiles for select to authenticated
  using (
    id = (select auth.uid())
    or private.shares_household_with(id)
  );

create policy "profiles: editar solo el propio"
  on public.profiles for update to authenticated
  using (id = (select auth.uid()))
  with check (id = (select auth.uid()));

-- Sin INSERT (trigger de registro) ni DELETE (cascada desde auth.users).

-- ── households ───────────────────────────────────────────────────────────

create policy "households: ver mis hogares"
  on public.households for select to authenticated
  using (private.is_household_member(id));

create policy "households: editar si soy owner o admin"
  on public.households for update to authenticated
  using (private.household_role_of(id) in ('owner', 'admin'))
  with check (private.household_role_of(id) in ('owner', 'admin'));

create policy "households: eliminar si soy owner"
  on public.households for delete to authenticated
  using (private.household_role_of(id) = 'owner');

-- Sin INSERT directo: usar public.create_household.

-- ── household_members ────────────────────────────────────────────────────

create policy "household_members: ver integrantes de mis hogares"
  on public.household_members for select to authenticated
  using (private.is_household_member(household_id));

create policy "household_members: solo owners cambian roles"
  on public.household_members for update to authenticated
  using (private.household_role_of(household_id) = 'owner')
  with check (private.household_role_of(household_id) = 'owner');

create policy "household_members: salir, o expulsar según rol"
  on public.household_members for delete to authenticated
  using (
    user_id = (select auth.uid())
    or private.household_role_of(household_id) = 'owner'
    or (private.household_role_of(household_id) = 'admin' and role = 'member')
  );

-- Sin INSERT directo: altas por create_household e invitaciones (Fase 03).

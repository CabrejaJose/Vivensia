# Base de datos

PostgreSQL gestionado por Supabase. Esquema construido **solo** mediante
migraciones SQL versionadas en `supabase/migrations/` (`YYYYMMDDHHMMSS_descripcion.sql`).
Nunca se modifica el esquema a mano en un entorno remoto.

## Convenciones
- Claves primarias `uuid` (generadas en cliente cuando haga falta idempotencia offline).
- `created_at` / `updated_at` `timestamptz` en todas las tablas; trigger de `updated_at`.
- Tablas compartidas llevan `household_id` (FK) e índice correspondiente.
- Dinero: `numeric(14,2)` + `currency char(3)` ISO 4217. **Nunca** `float`.
- Cantidades de despensa/recetas: `numeric` + unidad explícita.
- `snake_case`, nombres de tabla en plural.
- FKs con estrategia de borrado explícita (`cascade` solo para datos dependientes del hogar).
- Borrado lógico (`deleted_at`) solo donde se requiera historial/sincronización.

## Seguridad
- `alter table … enable row level security` en toda tabla con datos de usuario.
- Sin políticas = acceso denegado. Políticas mínimas por operación (select/insert/update/delete).
- Pertenencia al hogar resuelta con funciones `security definer` con `search_path` fijo,
  p. ej. `is_household_member(household_id)` y `has_household_role(household_id, role)`.
- Pruebas de acceso cruzado entre hogares en `supabase/tests/`.

## Primera migración prevista (Hito 6)
`profiles`, `households`, `household_members` (+ `invitations` en Fase 03).

## Tablas previstas por área
| Área | Tablas | Fase |
|---|---|---|
| Usuarios | profiles, user_settings | 02 |
| Hogares | households, household_members, invitations | 03 |
| Limpieza | rooms, tasks, task_schedules, task_completions | 05 |
| Compras | shopping_lists, shopping_items, products | 06 |
| Finanzas | accounts, transactions, budgets, categories, recurring_expenses | 07 |
| Calendario | calendars, events, event_participants, event_comments | 08 |
| Recetas/Menús | recipes, recipe_ingredients, recipe_steps, meal_plans, meal_plan_items | 09 |
| Despensa | pantry_items, stock_movements, product_batches | 10 |
| Mantenimiento | assets, maintenance_schedules, maintenance_history | 11 |
| Documentos | documents, document_permissions | 12 |
| Gamificación | points_ledger, achievements, rewards | 13 |
| Automatización | automation_rules, automation_runs | 14 |
| Sistema | notifications, audit_logs, device_tokens | varias |
| Monetización | subscriptions, entitlements | 16 |

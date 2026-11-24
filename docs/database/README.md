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

## Esquema actual (Hito 6)

```
auth.users ──1:1──▶ profiles ◀──┐
                                 │ user_id (cascade)
households ◀── household_id ── household_members (role: owner|admin|member)
   (cascade)
```

| Migración | Contenido |
|---|---|
| `20261124140000_private_schema` | Esquema `private` (no expuesto por la API), `set_updated_at()` |
| `20261124140100_profiles` | `profiles` + trigger que lo crea al registrarse |
| `20261124140200_households` | `households`, `household_members`, rol `household_role`, funciones de pertenencia, protección del último owner, sucesión, `create_household()` |
| `20261124140300_rls_policies` | Privilegios mínimos y políticas RLS |

### Matriz de permisos (rol `authenticated`)
| Tabla | SELECT | INSERT | UPDATE | DELETE |
|---|---|---|---|---|
| profiles | propio + integrantes de mis hogares | ✗ (trigger) | solo el propio: `display_name`, `avatar_path`, `locale` | ✗ (cascada) |
| households | mis hogares | ✗ → `create_household()` | owner/admin: `name`, `currency_code`, `time_zone` | owner |
| household_members | integrantes de mis hogares | ✗ (Fase 03: invitaciones) | owner: `role` | yo mismo (salir) · owner: cualquiera · admin: members |

`anon` no tiene ningún privilegio sobre estas tablas ni sobre `create_household()`.

### Reglas de integridad
- Un hogar siempre conserva al menos un owner: el último no puede salir ni degradarse (`last_owner`).
- Eliminar la cuenta del último owner transfiere la propiedad al integrante más antiguo;
  si no quedan integrantes, el hogar se elimina.
- `create_household()` es atómico, exige sesión y limita a 20 hogares propios por usuario.
- Zona horaria validada contra `pg_timezone_names`; moneda ISO 4217 (`^[A-Z]{3}$`).
- El email no se copia a `profiles`; sin nombre en el registro, `display_name` queda null.

### Pruebas
`bash scripts/test-db.sh` — 66 aserciones (ver `supabase/tests/README.md`). Se verificó
con mutaciones que una política demasiado amplia o un privilegio olvidado a `anon`
hacen fallar las pruebas.

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

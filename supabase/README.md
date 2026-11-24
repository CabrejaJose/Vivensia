# Supabase

- `migrations/` — migraciones SQL versionadas (`YYYYMMDDHHMMSS_descripcion.sql`).
- `functions/` — Edge Functions (se crea cuando haga falta).
- `tests/` — pruebas de BD y RLS (`bash scripts/test-db.sh`, ver `tests/README.md`).
- `config.toml` — generado con `supabase init` (CLI 3.3.0) y endurecido; solo desarrollo local.
- `seed.sql` — vacío hasta la Fase 03.

**Ninguna migración se ha aplicado a un proyecto remoto.** Hacerlo requiere autorización
explícita, credenciales rotadas y un entorno de staging.

`seed.sql` contendrá **solo datos ficticios** claramente identificados.
Convenciones en [`docs/database/README.md`](../docs/database/README.md).

# Supabase

- `migrations/` — migraciones SQL versionadas (`YYYYMMDDHHMMSS_descripcion.sql`).
- `functions/` — Edge Functions (se crea cuando haga falta).
- `tests/` — pruebas de BD y RLS (se crea en el Hito 6).
- `config.toml` y `seed.sql` — se generan con `supabase init` en el Hito 6.

`seed.sql` contendrá **solo datos ficticios** claramente identificados.
Convenciones en [`docs/database/README.md`](../docs/database/README.md).

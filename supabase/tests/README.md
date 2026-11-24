# Pruebas de base de datos

Verifican migraciones, restricciones y **RLS / aislamiento entre hogares**.

```bash
bash scripts/test-db.sh
```

El script levanta un PostgreSQL temporal (sin Docker), aplica:

1. `tests/setup/00_supabase_shim.sql` — emulación mínima de Supabase (roles,
   `auth.users`, `auth.uid()`, privilegios por defecto). **Solo pruebas.**
2. `migrations/*.sql` en orden.
3. `seed.sql`.
4. `tests/setup/10_test_helpers.sql` — aserciones (`tests.ok`, `tests.is`,
   `tests.throws`, `tests.affected`).
5. Cada `tests/database/*_test.sql` en su propia transacción (rollback).

Requisitos: binarios de PostgreSQL (`initdb`, `pg_ctl`, `psql`); `PGBIN` permite
indicar su ruta. Con Docker disponible, las migraciones también se validan con
`supabase start` / `supabase db reset`.

Cada tabla nueva con datos de usuario debe añadir pruebas de acceso cruzado.

#!/usr/bin/env bash
# Vivensia — pruebas de base de datos sobre un PostgreSQL temporal (sin Docker).
# Uso: bash scripts/test-db.sh        (PGBIN=/ruta/bin para otra instalación)
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
SB="$ROOT/supabase"
PGBIN="${PGBIN:-$(ls -d /usr/lib/postgresql/*/bin 2>/dev/null | sort -V | tail -1 || true)}"
if [[ -z "$PGBIN" ]]; then PGBIN="$(dirname "$(command -v initdb 2>/dev/null || echo /nonexistent/initdb)")"; fi
[[ -x "$PGBIN/initdb" && -x "$PGBIN/pg_ctl" ]] || {
  echo "✖ No se encontraron initdb/pg_ctl. Instala PostgreSQL o define PGBIN." >&2; exit 2; }

PORT="${PGTEST_PORT:-54399}"
WORK="$(mktemp -d)"
as_pg() { if [[ "$(id -u)" -eq 0 ]]; then runuser -u postgres -- "$@"; else "$@"; fi; }
[[ "$(id -u)" -eq 0 ]] && chown -R postgres "$WORK"

cleanup() {
  as_pg "$PGBIN/pg_ctl" -D "$WORK/data" -m fast stop >/dev/null 2>&1 || true
  rm -rf "$WORK"
}
trap cleanup EXIT

as_pg "$PGBIN/initdb" -D "$WORK/data" -U postgres --auth=trust -E UTF8 >/dev/null
as_pg "$PGBIN/pg_ctl" -D "$WORK/data" -l "$WORK/postgres.log" -w \
  -o "-p $PORT -k $WORK -c listen_addresses=''" start >/dev/null

PSQL=(psql -h "$WORK" -p "$PORT" -U postgres -d postgres -X -q -v ON_ERROR_STOP=1)
run() { "${PSQL[@]}" -f "$1" 2>&1; }

echo "PostgreSQL $("${PSQL[@]}" -tAc 'show server_version')"
echo "→ shim de Supabase (solo pruebas)"; run "$SB/tests/setup/00_supabase_shim.sql" >/dev/null
for m in "$SB"/migrations/*.sql; do
  echo "→ migración $(basename "$m")"; run "$m" >/dev/null
done
echo "→ seed.sql"; run "$SB/seed.sql" >/dev/null
run "$SB/tests/setup/10_test_helpers.sql" >/dev/null

total=0; failed=0
for t in "$SB"/tests/database/*_test.sql; do
  name="$(basename "$t")"
  if out="$(run "$t")"; then
    n="$(grep -c 'ok - ' <<<"$out" || true)"; total=$((total + n))
    echo "✔ $name ($n)"
  else
    failed=$((failed + 1))
    n="$(grep -c 'ok - ' <<<"$out" || true)"; total=$((total + n))
    echo "✖ $name"; grep -E 'FALLO|ERROR' <<<"$out" | sed 's/^/    /'
  fi
done

echo "Aserciones superadas: $total"
if ((failed > 0)); then echo "✖ $failed archivo(s) con fallos"; exit 1; fi
echo "✔ Todas las pruebas de base de datos pasaron"

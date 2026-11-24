#!/usr/bin/env bash
# Vivensia — detector básico de secretos.
# Analiza los archivos versionados o pendientes de versionar (respeta .gitignore).
# No sustituye a un escáner profesional; es una red de seguridad mínima.
set -euo pipefail

cd "$(git rev-parse --show-toplevel)"
self="scripts/check-secrets.sh"

patterns=(
  'postgres(ql)?://[^:/[:space:]]+:[^@[:space:]]+@'   # cadena de conexión con contraseña
  'GOCSPX-[A-Za-z0-9_-]{20,}'                          # Google OAuth client secret
  'AIza[0-9A-Za-z_-]{35}'                              # Google API key
  'AKIA[0-9A-Z]{16}'                                   # AWS access key
  'sk-ant-[A-Za-z0-9_-]{20,}'                          # Anthropic API key
  'sk-(proj-)?[A-Za-z0-9]{32,}'                        # OpenAI-style API key
  'sb_secret_[A-Za-z0-9_-]{20,}'                       # Supabase secret key
  'eyJ[A-Za-z0-9_-]{15,}\.eyJ[A-Za-z0-9_-]{15,}\.'     # JWT (p. ej. service_role)
  '-----BEGIN ([A-Z]+ )?PRIVATE KEY-----'              # claves privadas
)

mapfile -t files < <(git ls-files --cached --others --exclude-standard | grep -v -x "$self" || true)

status=0

for f in "${files[@]}"; do
  base="$(basename "$f")"
  if [[ "$base" == .env* && "$base" != ".env.example" ]]; then
    echo "✖ Archivo de entorno versionable: $f"
    status=1
  fi
done

for p in "${patterns[@]}"; do
  if ((${#files[@]})); then
    if matches=$(grep -nIE -- "$p" "${files[@]}" 2>/dev/null); then
      # Muestra ubicación pero oculta el valor.
      echo "✖ Posible secreto (patrón: $p):"
      echo "$matches" | cut -d: -f1,2 | sed 's/^/    /'
      status=1
    fi
  fi
done

if ((status == 0)); then
  echo "✔ check-secrets: sin secretos detectados en ${#files[@]} archivos."
fi
exit $status

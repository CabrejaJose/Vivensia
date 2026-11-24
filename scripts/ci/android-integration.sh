#!/usr/bin/env bash
# Ejecuta la prueba de integración en el emulador con límite de tiempo.
#
# Motivo: en el emulador de CI Android a veces relanza la actividad durante
# `flutter drive`; la prueba se reinicia y el driver queda esperando para
# siempre (visto en el run 45411844738). Cada intento tiene un límite y, si
# falla o se cuelga, se reintenta UNA vez desde cero. Un fallo real de la app
# fallará en ambos intentos: el reintento no oculta errores.
set -uo pipefail

APP_ID="com.vivensia.app"
LIMIT_SECONDS="${INTEGRATION_TIMEOUT:-600}"

for attempt in 1 2; do
  echo "::group::Prueba de integración — intento ${attempt} (límite ${LIMIT_SECONDS}s)"
  rm -rf build/integration_screenshots
  timeout --kill-after=30 "${LIMIT_SECONDS}" \
    flutter drive \
      --driver=test_driver/integration_test.dart \
      --target=integration_test/app_test.dart
  status=$?
  echo "::endgroup::"
  if [[ $status -eq 0 ]]; then
    echo "✔ Prueba de integración superada en el intento ${attempt}"
    exit 0
  fi
  if [[ $status -eq 124 || $status -eq 137 ]]; then
    echo "::warning::Intento ${attempt}: superó ${LIMIT_SECONDS}s (posible relanzamiento de la actividad en el emulador)"
  else
    echo "::warning::Intento ${attempt}: falló con código ${status}"
  fi
  adb shell am force-stop "${APP_ID}" || true
done

echo "::error::La prueba de integración falló en los 2 intentos"
exit 1

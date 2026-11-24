# Estrategia de pruebas

| Nivel | Herramienta | Qué cubre |
|---|---|---|
| Análisis estático | `flutter analyze` (lints estrictos) | Estilo, errores, imports entre capas |
| Unitarias | `flutter test` | domain, application, mappers de data |
| Widgets | `flutter test` | Componentes del design system, pantallas, estados carga/vacío/error |
| Golden (opcional) | `flutter test --update-goldens` | Regresión visual de componentes clave |
| Integración | `integration_test` + `flutter drive` | Recorrido completo en emulador Android API 34 (CI) con capturas |
| Base de datos | SQL/pgTAP en `supabase/tests/` | Restricciones, triggers y **RLS / acceso cruzado** |
| Seguridad | `scripts/check-secrets.sh` + revisión por fase | Secretos, permisos |

## Prueba en emulador (CI)
`scripts/ci/android-integration.sh` ejecuta `flutter drive` con límite de 10 min por intento y
**un** reintento en limpio. Motivo: el emulador de CI a veces relanza la actividad durante la
prueba y el driver queda esperando indefinidamente (run 45411844738). Un fallo real de la app
falla en ambos intentos; cada intento queda registrado como aviso en el log.

## Reglas
- Ninguna prueba se desactiva para obtener verde.
- Los resultados reportados deben provenir de ejecuciones reales.
- Cada fase define sus criterios de aceptación y pruebas mínimas.
- CI bloquea merge si analyze o tests fallan.

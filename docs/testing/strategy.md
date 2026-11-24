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

## Reglas
- Ninguna prueba se desactiva para obtener verde.
- Los resultados reportados deben provenir de ejecuciones reales.
- Cada fase define sus criterios de aceptación y pruebas mínimas.
- CI bloquea merge si analyze o tests fallan.

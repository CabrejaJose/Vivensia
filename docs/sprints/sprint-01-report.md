# Sprint 01 — Reporte final de validación

- **Fecha:** 2026-11-24
- **Rama:** `claude/busy-mayer-9lre3s`
- **Estado del sprint:** COMPLETADO (aprobado 2026-11-24) — criterios cumplidos salvo iOS (documentado)

## Resumen

Base profesional de Vivensia: repositorio documentado, app Flutter (`com.vivensia.app`)
con sistema de diseño propio, navegación principal, dashboard conceptual con datos de
ejemplo identificados, backend preparado (migraciones + RLS probadas) y CI con
análisis, pruebas, base de datos y emulador Android.

| Métrica | Valor |
|---|---|
| Archivos versionados | 202 |
| Dart en `lib/` (sin código generado) | ~3 750 líneas · 59 archivos |
| Pruebas Dart (unitarias, widgets, integración) | ~1 210 líneas |
| SQL de migraciones / pruebas de BD | 421 / 269 líneas |
| Commits | 23+ (Conventional Commits) |

## Criterios de aceptación

| Criterio | Estado | Evidencia |
|---|---|---|
| Repositorio organizado | ✔ | Estructura del plan; carpetas solo cuando su fase lo requiere |
| Documentación técnica | ✔ | `README`, `AGENTS.md`, `CHANGELOG`, `docs/` (producto, arquitectura, 6 ADR, BD, diseño, seguridad, pruebas, despliegue) |
| App Flutter ejecutable | ✔ | APK debug y release compilados; ejecutada en emulador Android |
| Arquitectura coherente | ✔ | Feature-first + capas; dashboard con dominio/datos/aplicación/presentación |
| Sistema de diseño reutilizable | ✔ | Tokens, temas claro/oscuro/sistema, 13 componentes `Viv*`, contraste AA verificado (62 pares) |
| Navegación funcional | ✔ | Barra inferior con 5 destinos, pruebas de navegación |
| Localización preparada | ✔ | es/en (ARB), fallback a inglés, plurales ICU |
| Sin secretos en el repositorio | ✔ | `check-secrets.sh` en CI: 0 hallazgos |
| Pruebas satisfactorias | ✔ | 136 Dart + 66 aserciones SQL + 12 capturas de regresión |
| Sin errores de análisis | ✔ | `flutter analyze`: sin problemas (lints estrictos) |
| Evidencia real en Android | ✔ | Emulador API 34 en CI: instalación + recorrido + 8 capturas (ver "Android") |
| Validación iOS | ✗ (documentado) | Requiere macOS; ver "Limitaciones" |

## Validación local (contenedor Linux, 2026-11-24)

Ejecutada desde cero (`flutter clean` + `pub get`):

| Comando | Resultado |
|---|---|
| `dart format --set-exit-if-changed` | 71 archivos, 0 cambios |
| `flutter analyze` | No issues found |
| `flutter test` | 136/136 |
| `flutter test screenshots` (regresión visual) | 12/12 coinciden con las referencias |
| `bash scripts/test-db.sh` | 66 aserciones, 4/4 archivos |
| `bash scripts/check-secrets.sh` | 0 secretos en 200 archivos |
| `flutter build apk --debug` | ✔ 158 MB · `com.vivensia.app` · minSdk 24 · targetSdk 36 |
| `flutter build apk --release` (firma debug, solo medición) | ✔ 51 MB (APK universal, todas las ABI) |
| `flutter build apk --debug --target=integration_test/app_test.dart` | ✔ compila |

## Android

Prueba de integración `integration_test/app_test.dart`, ejecutada con `flutter drive`
en un emulador Android API 34 (Pixel 6, x86_64) dentro de GitHub Actions:
arranque → Inicio → Tareas → Compras → Agenda → Más → Finanzas ("Próximamente") →
tema oscuro → sistema de diseño, con 8 capturas publicadas como artefacto
`android-emulator-screenshots` y el APK como `vivensia-debug-apk`.

**Resultado: ✔ SUPERADO** — run de CI [45407520294](https://github.com/CabrejaJose/Vivensia/actions/runs/45407520294)
(commit `035f1be`, 2026-11-24 13:51–13:59 UTC). Los 4 jobs en verde.

| Paso del job `android` | Duración | Resultado |
|---|---|---|
| Compilar APK debug | 3 min 29 s | ✔ |
| Emulador API 34 (1080×2400, 420 dpi): arranque en frío | 43 s | ✔ |
| `flutter drive` · instalación de `com.vivensia.app` + recorrido completo | 51 s de prueba | ✔ `All tests passed.` |
| Capturas publicadas | 8 archivos (871 KB) | ✔ artefacto `android-emulator-screenshots` (30 días) |
| APK publicado | 54 MB comprimido | ✔ artefacto `vivensia-debug-apk` (7 días) |

Observaciones del log (no bloqueantes):
- `Choreographer: Skipped N frames` en el arranque: esperable con GPU emulada (SwiftShader) y build debug.
- Aviso `enableOnBackInvokedCallback`: activar el gesto "atrás predictivo" de Android en una fase posterior.
- Primer intento (run 45405874669) falló al compilar: el build interno de Flutter resolvía plugins
  solo en el Gradle Plugin Portal. Corregido con `.github/gradle/plugin-repositories.init.gradle`.

## Incidencias encontradas y resueltas en el sprint

| Incidencia | Resolución |
|---|---|
| Credencial de BD pegada en el chat (Hito 1) | No usada ni almacenada; se recomendó rotarla |
| Material separado en `material_ui` (Flutter 3.47+) | Imports y delegados de localización ajustados |
| Contraste insuficiente de terracota/salvia con texto blanco | Derivados accesibles; terracota y salvia solo decorativos |
| "Automático" truncado a 390 dp | Etiqueta "Sistema" |
| Botón atrás sin icono Lucide | `ActionIconTheme` con Lucide |
| Pantalla "Próximamente" sin salida por enlace directo | Botón de volver a Inicio |
| `repo.maven.apache.org` 429 vía proxy del contenedor | Init script local (no versionado) hacia `repo1.maven.org` |
| CI: plugins de Gradle de Flutter solo buscaban en el Plugin Portal | Init script de CI con repositorios explícitos |

## Limitaciones conocidas

- **iOS:** sin compilar ni ejecutar (requiere macOS + Xcode). Opción: job `macos` en CI
  (`flutter build ios --no-codesign`), con mayor coste de minutos en repos privados.
- **Contenedor de agente:** sin KVM (sin emulador local) ni Docker (sin `supabase start`).
- **Base de datos:** probada en PostgreSQL 16 con emulación mínima de Supabase; validar con
  `supabase db reset` (PostgreSQL 17) antes de aplicar a un proyecto remoto.
- Preferencia de tema no persistida; saludo sin nombre hasta la autenticación (Fase 02).
- Ningún proyecto remoto creado ni modificado.

## Recomendaciones para la siguiente fase

1. Rotar la contraseña de la base de datos expuesta y crear un proyecto **staging** separado.
2. Fase 02 (Autenticación): `supabase_flutter`, registro/inicio/recuperación, Sign in with Apple
   y Google, onboarding con nombre, conexión de la app a `profiles`.
3. Decidir si se añade el job de compilación iOS en CI.
4. Ejecutar la prueba de integración en un teléfono real (pendiente: la carpeta compartida por
   Remote Control no está disponible para sesiones en la nube en el equipo del responsable).
5. Activar `android:enableOnBackInvokedCallback` (atrás predictivo).

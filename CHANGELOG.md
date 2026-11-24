# Changelog

Todos los cambios relevantes de Vivensia se documentan aquí.
Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/)
y versionado [SemVer](https://semver.org/lang/es/).

## [Unreleased]

### Added
- Fase 02 · Hito 2.3: perfil del usuario (`profiles`), onboarding con nombre e idioma,
  pantalla Mi perfil, idioma del perfil aplicado a la app y saludo personalizado.
- Fase 02 · Hito 2.1: autenticación con Supabase (PKCE) y sesión en almacenamiento seguro;
  bienvenida, registro, inicio de sesión, recuperación de contraseña y cierre de sesión;
  guardia de rutas; modo demostración sin backend; componentes `VivNotice` y `VivBrandMark`.
- ADR 0007 (autenticación, sesión y modo demostración).

### Changed
- Configuración: `SUPABASE_ANON_KEY` → `SUPABASE_PUBLISHABLE_KEY` (el SDK marca `anonKey` como obsoleto).
- Sprint 01 · Hito 7: prueba de integración en dispositivo (`integration_test`) y job de CI
  con emulador Android API 34 que publica capturas y el APK debug como artefactos.
- Reporte final del Sprint 01 (`docs/sprints/sprint-01-report.md`).

### Fixed
- CI: repositorios explícitos para plugins de Gradle (el build interno de Flutter solo
  consultaba el Gradle Plugin Portal).
- Sprint 01 · Hito 6: `supabase/config.toml` local, migraciones de `profiles`, `households`
  y `household_members` con RLS, `create_household()` atómico, protección del último owner
  y sucesión al eliminar cuentas.
- `scripts/test-db.sh` y 66 aserciones de base de datos (aislamiento entre hogares); job de CI.
- `AppConfig` con `SUPABASE_URL`/`SUPABASE_ANON_KEY` y ejemplos de configuración por entorno.
- ADR 0005 (acceso por hogar) y 0006 (pruebas de BD sin Docker); estrategia de autenticación.
- Sprint 01 · Hito 5: navegación principal con barra inferior (Inicio, Tareas, Compras,
  Agenda, Más), dashboard conceptual con datos de ejemplo identificados, pantallas
  "Próximamente" para funciones futuras y pestaña Más con selector de tema.
- Feature dashboard con capas dominio/datos/aplicación/presentación y estados de carga/error.
- `clockProvider` para controlar la hora en pruebas.
- Pruebas de navegación, dashboard y desbordamientos (4 tamaños × 2 temas).

### Changed
- El acceso al sistema de diseño pasa de Inicio a Más → Desarrollo.
- Sprint 01 · Hito 4: sistema de diseño (tokens, temas claro/oscuro/sistema, tipografía
  Manrope + Inter empaquetada, iconos Lucide, 13 componentes `Viv*`).
- Pantalla de demostración de componentes (solo builds de desarrollo), textos es/en.
- Pruebas de contraste WCAG AA (62 pares), tema, componentes y desbordamientos en 3 tamaños.
- Capturas reales renderizadas en `apps/mobile/screenshots/goldens/`.
- ADR 0004 (iconografía Lucide).
- Sprint 01 · Hito 3: app Flutter en `apps/mobile` (`com.vivensia.app`, nombre "Vivensia").
- Riverpod, GoRouter, localización es/en, `AppConfig` por entorno y manejo global de errores.
- Lints estrictos (`strict-casts`, `strict-inference`, `strict-raw-types`).
- Pruebas unitarias y de widgets iniciales (9).
- CI fijado a Flutter 3.50.1.
- Sprint 01 · Hito 2: estructura inicial del repositorio.
- Documentación de producto, arquitectura (ADR 0001–0003), base de datos,
  diseño, seguridad, pruebas, despliegue y sprint 01.
- `AGENTS.md` con las reglas permanentes para agentes de IA.
- `.gitignore`, `.gitattributes`, `.editorconfig` y `.env.example` sin secretos.
- Script `scripts/check-secrets.sh` y workflow de CI (higiene + Flutter condicional).

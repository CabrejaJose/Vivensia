# Sprint 01 — Fundación

**Objetivo:** base profesional, reproducible y ejecutable para Vivensia.

| Hito | Descripción | Estado |
|---|---|---|
| 1 | Auditoría del entorno y planificación | COMPLETADO (aprobado 2026-11-24) |
| 2 | Repositorio y documentación | COMPLETADO (aprobado 2026-11-24) |
| 3 | App Flutter inicial (`com.vivensia.app`, Riverpod, GoRouter, l10n) | COMPLETADO (aprobado 2026-11-24) |
| 4 | Sistema de diseño (tokens, temas, componentes) | COMPLETADO (aprobado 2026-11-24) |
| 5 | Navegación y pantallas iniciales | COMPLETADO (aprobado 2026-11-24) |
| 6 | Preparación del backend (migraciones + RLS iniciales) | COMPLETADO (aprobado 2026-11-24) |
| 7 | Validación (analyze, tests, Android, temas) | EN REVISIÓN — ver [reporte final](sprint-01-report.md) |

## Hito 1 — resultado de la auditoría (entorno de agente en la nube)
- Ubuntu 24.04.5 x86_64, 4 CPU, 15 GB RAM. Git 2.43, Java, Node 22, psql 16 disponibles.
- Flutter/Dart no instalados (descargables). Android SDK no instalado (`dl.google.com` bloqueado).
- Sin `/dev/kvm` → sin emulador. Docker instalado pero sin daemon. Supabase CLI no disponible.
- Sin macOS → sin iOS.

## Hito 3 — resultado
- Flutter 3.50.1 / Dart 3.14.0 instalado en `$HOME/flutter` (checksum SHA-256 verificado).
- Proyecto en `apps/mobile`, plataformas android + ios, `com.vivensia.app`, nombre visible "Vivensia".
- Dependencias: flutter_riverpod 3.5, go_router 18.1, intl 0.20, flutter_localizations, material_ui 1.x
  (en Flutter 3.47+ Material se distribuye como paquete `material_ui`).
- `bootstrap()` con manejo global de errores, `AppConfig` por `--dart-define`, router con pantalla de ruta no encontrada.
- l10n es/en (ARB, plantilla es); idioma no soportado → inglés.
- `flutter analyze`: sin problemas. `flutter test`: 9/9.
- Compilación Android: verificada en el Hito 4 (ver abajo). iOS: requiere macOS.

## Hito 4 — resultado
- Tokens (color, espaciado, radios, movimiento, tamaños, elevación), temas claro/oscuro/sistema,
  tipografía Manrope + Inter empaquetada, iconos Lucide, 13 componentes `Viv*`.
- Pantalla de demostración `/dev/design-system` (solo builds no release), textos es/en.
- Contraste WCAG AA: 62 pares verificados por prueba automática.
- `flutter analyze`: sin problemas. `flutter test`: 98/98.
- Pruebas sin desbordamientos en 320×640, 390×844 con texto 1.3× y tablet 820×1180.
- Capturas reales (motor Flutter, fuentes reales) en `apps/mobile/screenshots/goldens/`.
- **APK debug compilado** en el entorno: `com.vivensia.app`, etiqueta "Vivensia", targetSdk 36.
- Entorno: se permitió `dl.google.com`; Android SDK (cmdline-tools) instalado en `$HOME/android-sdk`.
  `repo.maven.apache.org` devuelve 429 vía proxy → init script local de Gradle redirige a
  `repo1.maven.org` (solo en el contenedor, no versionado).
- **No verificado**: ejecución en emulador/dispositivo (sin KVM) ni iOS.

## Hito 5 — resultado
- Shell con barra inferior persistente (`StatefulShellRoute.indexedStack`): Inicio, Tareas,
  Compras, Agenda, Más. Cada pestaña conserva su estado; volver a pulsarla regresa a su raíz.
- Inicio: dashboard conceptual (selector de hogar, notificaciones, saludo según la hora,
  "Tu hogar hoy", cuadrícula "Organiza tu hogar", acceso al asistente). Datos de ejemplo
  marcados con la etiqueta "Datos de ejemplo". Sin importes ni datos privados.
- Estados de carga (skeleton), error (con reintento, sin reintentos automáticos) y contenido.
- Arquitectura del feature dashboard: `HomeSummary` (dominio) → `HomeSummaryRepository`
  (contrato) → `DemoHomeSummaryRepository` (datos) → `homeSummaryProvider` (aplicación).
- Funciones futuras: una única `ComingSoonScreen` parametrizada por `AppModule`
  (sin carpetas vacías de features). Enlace directo → botón de volver a Inicio.
- Más: todas las funciones, selector de tema, acceso al sistema de diseño (solo desarrollo).
- `flutter analyze`: sin problemas. `flutter test`: 133/133.
- Sin desbordamientos en 6 rutas × 4 tamaños (320×640, 390×844 texto 1.3×, 360×780 texto 2×,
  tablet 820×1180) × 2 temas.
- Capturas reales actualizadas en `apps/mobile/screenshots/goldens/`. APK debug recompilado.
- **No verificado**: ejecución en emulador/dispositivo (sin KVM) ni iOS.

## Hito 6 — resultado
- `supabase/config.toml` generado con `supabase init` (CLI 3.3.0 instalado localmente vía npm,
  sin instalación global) y endurecido (contraseña ≥ 8 con letras y dígitos, reautenticación).
- 4 migraciones: esquema privado, `profiles`, `households` + `household_members`, RLS.
- 66 aserciones SQL en PostgreSQL 16 temporal (`scripts/test-db.sh`), incluidas pruebas de
  acceso cruzado entre hogares, escalamiento de privilegios y eliminación de cuenta.
  Verificado con 2 mutaciones que las pruebas detectan regresiones de seguridad.
- Job `database` en CI.
- App: `AppConfig` acepta `SUPABASE_URL`/`SUPABASE_ANON_KEY` por `--dart-define-from-file`
  (`apps/mobile/config/*.example.json`); sin SDK de Supabase todavía (Fase 02). 136/136 pruebas.
- Estrategia de autenticación documentada (`docs/security/auth-strategy.md`).
- **No realizado**: `supabase start` (sin Docker) ni ningún cambio en proyectos remotos.

## Decisiones
- Identificador: `com.vivensia.app` (ADR 0002).
- Fuentes empaquetadas (ADR 0003).

## Criterios de aceptación del sprint
Repositorio organizado · documentación técnica · app ejecutable · arquitectura
coherente · design system reutilizable · navegación funcional · l10n preparada ·
sin secretos · pruebas en verde · analyze sin errores · evidencia real en Android ·
validación iOS si el entorno lo permite (si no, documentada).

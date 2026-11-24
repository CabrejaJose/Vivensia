# Sprint 01 — Fundación

**Objetivo:** base profesional, reproducible y ejecutable para Vivensia.

| Hito | Descripción | Estado |
|---|---|---|
| 1 | Auditoría del entorno y planificación | COMPLETADO (aprobado 2026-11-24) |
| 2 | Repositorio y documentación | COMPLETADO (aprobado 2026-11-24) |
| 3 | App Flutter inicial (`com.vivensia.app`, Riverpod, GoRouter, l10n) | EN REVISIÓN |
| 4 | Sistema de diseño (tokens, temas, componentes) | PENDIENTE |
| 5 | Navegación y pantallas iniciales | PENDIENTE |
| 6 | Preparación del backend (migraciones + RLS iniciales) | PENDIENTE |
| 7 | Validación (analyze, tests, Android, temas) | PENDIENTE |

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
- **No verificado**: compilación Android (sin Android SDK en el entorno) ni iOS (requiere macOS).

## Decisiones
- Identificador: `com.vivensia.app` (ADR 0002).
- Fuentes empaquetadas (ADR 0003).

## Criterios de aceptación del sprint
Repositorio organizado · documentación técnica · app ejecutable · arquitectura
coherente · design system reutilizable · navegación funcional · l10n preparada ·
sin secretos · pruebas en verde · analyze sin errores · evidencia real en Android ·
validación iOS si el entorno lo permite (si no, documentada).

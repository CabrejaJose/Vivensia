# ADR 0001 — Stack tecnológico base

- **Estado:** Aceptado
- **Fecha:** 2026-11-24

## Contexto
Vivensia es una única app comercial Android/iOS, desarrollada por fases con
agentes de IA, con datos compartidos por hogar, colaboración en tiempo real
y necesidad futura de offline, IA, push y suscripciones.

## Decisión
| Área | Elección |
|---|---|
| App | Flutter (canal stable) + Dart |
| Estado | Riverpod |
| Navegación | GoRouter |
| Backend | Supabase: PostgreSQL, Auth, RLS, Realtime, Storage, Edge Functions |
| Local/offline | Drift + SQLite (desde la fase que lo requiera) |
| Push | Firebase Cloud Messaging + APNs (Fase de notificaciones) |
| Suscripciones | RevenueCat o nativo — se decide en Fase 16 |
| IA / OCR | Solo vía Edge Functions con secretos en servidor |
| l10n | `flutter_localizations` + ARB (es, en) |
| CI | GitHub Actions |

Versiones exactas: se fijan en el Hito 3 tras verificar la documentación oficial
y se registran en `apps/mobile/pubspec.yaml` y en la configuración de CI.

## Consecuencias
- + Un solo código para ambas plataformas; Postgres relacional con RLS encaja con
  el aislamiento por hogar; Realtime cubre listas colaborativas.
- − iOS requiere macOS para compilar/firmar. Dependencia de Supabase como proveedor
  (mitigada: es Postgres estándar y migraciones SQL versionadas).
- Servicios adicionales se instalan solo en la fase que los necesita.

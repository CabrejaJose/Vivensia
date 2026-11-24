# Arquitectura — visión general

## Estilo
**Monolito modular** en una única app Flutter, organizado **feature-first**
con **Clean Architecture pragmática**. Sin microservicios. Backend gestionado
con Supabase y lógica privilegiada en Edge Functions.

```
┌──────────────────────── App Flutter (Android / iOS) ────────────────────────┐
│ presentation   Screens · Widgets · Riverpod providers · GoRouter            │
│ application    Casos de uso · orquestación entre repositorios               │
│ domain         Entidades · value objects · contratos de repositorio · reglas│
│ data           Modelos/DTO · datasources (Supabase, Drift) · repositorios   │
└──────────────┬──────────────────────────────────────────────┬───────────────┘
               │ HTTPS (publishable key + JWT)               │ local
     ┌─────────▼──────────────────────────────┐        ┌──────▼──────┐
     │ Supabase: PostgreSQL + RLS · Auth ·    │        │ SQLite/Drift│
     │ Realtime · Storage · Edge Functions    │        │ caché/offline│
     └─────────┬──────────────────────────────┘        └─────────────┘
               │ (solo desde Edge Functions, con secretos del servidor)
        IA · Push (FCM/APNs) · Pagos · OCR
```

## Reglas de dependencia
- `presentation → application → domain`; `data → domain` (implementa contratos).
- `domain` es Dart puro: sin Flutter, sin Supabase.
- Features no importan `presentation` de otros features. Lo compartido vive en
  `core/` (infraestructura) o `design_system/` (UI).
- La integración entre módulos (automatizaciones) se modela con **eventos de
  dominio** y **casos de uso idempotentes** (claves de idempotencia por operación).
- Casos de uso y contratos se crean cuando aportan valor; un CRUD trivial puede
  ir de provider a repositorio sin capa extra.

## Estructura objetivo
```
apps/mobile/lib/
├── app/            app.dart · bootstrap.dart · router/ · config/
├── core/           constants · errors · network · security · storage · services · utils · extensions
├── design_system/  tokens · theme · typography · components · animations
├── features/<feature>/
│   ├── presentation/ (screens · widgets · providers)
│   ├── application/  (use_cases)
│   ├── domain/       (entities · repositories)
│   └── data/         (models · datasources · repositories)
├── l10n/
└── main.dart
```
Features previstos: auth, onboarding, households, dashboard, cleaning, finances,
shopping, pantry, calendar, recipes, meal_planning, maintenance, documents,
gamification, assistant, notifications, subscriptions, profile, settings.
**Se crean solo cuando llega su fase.**

## Navegación (Hito 5)
- `lib/app/router/`: rutas (`AppRoutes`) y `appRouterProvider` con `StatefulShellRoute`.
- `lib/app/navigation/`: shell con barra inferior, catálogo `AppModule` (nombre, icono,
  destino), pestañas provisionales, "Más" y `ComingSoonScreen`.
- Los features pueden importar `app/router/app_routes.dart` y `app/navigation/app_module.dart`
  (contratos de navegación), pero no pantallas de otros features. Cuando una función se
  implemente, su ruta en el router pasa de la pantalla provisional a la del feature.

## Entornos
`development` (local) · `staging` · `production`, cada uno con su propio
proyecto Supabase y claves. Configuración inyectada en build
(`--dart-define-from-file`), nunca hardcodeada.

## Offline (progresivo)
Fase inicial: online con caché simple. Fase 17: Drift como fuente local,
cola de operaciones pendientes con IDs generados en cliente (UUID v7),
reintentos y resolución de conflictos por entidad. Realtime **no** es offline.

## Decisiones
Ver [`adr/`](adr/).

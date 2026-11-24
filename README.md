# Vivensia

> **Organiza menos. Vive más.** · *Organize less. Live more.*

Vivensia es una aplicación móvil integral del hogar para **Android e iOS**:
limpieza, finanzas, compras, despensa, calendario, recetas y menús,
mantenimiento, documentos y organización familiar — **en una sola app**,
conectadas entre sí para que la información no se introduzca dos veces.

| | |
|---|---|
| Nombre técnico | `vivensia` |
| Identificador de app | `com.vivensia.app` |
| Plataformas | Android · iOS (Flutter) |
| Backend | Supabase (PostgreSQL · Auth · RLS · Realtime · Storage) |
| Idiomas | Español · Inglés |
| Modelo | Freemium |

## Estado

🚧 **Fase 02 — Autenticación.** Hito 2.1 en revisión — ver [plan de la fase](docs/sprints/phase-02-auth.md).
Sprint 01 (fundación) completado: [reporte](docs/sprints/sprint-01-report.md). Ver [`docs/sprints/sprint-01.md`](docs/sprints/sprint-01.md)
y la hoja de ruta en [`docs/product/roadmap.md`](docs/product/roadmap.md).

## Estructura del repositorio

```
vivensia/
├── apps/mobile/        App Flutter (com.vivensia.app)
├── supabase/           Migraciones, Edge Functions y pruebas del backend
├── docs/               Producto, arquitectura, BD, diseño, seguridad, pruebas, despliegue
├── scripts/            Utilidades de desarrollo y CI
├── .github/workflows/  Integración continua
├── AGENTS.md           Reglas permanentes para agentes de IA
└── CHANGELOG.md
```

La estructura objetivo completa está en [`docs/architecture/overview.md`](docs/architecture/overview.md).
Las carpetas se crean cuando su fase lo requiere, sin archivos vacíos innecesarios.

## Requisitos de desarrollo

| Herramienta | Uso | Notas |
|---|---|---|
| Git | Control de versiones | — |
| Flutter 3.50.1 (stable) + Dart 3.14 | App móvil | Misma versión que CI |
| Android Studio / SDK | Compilar y emular Android | Emulador requiere virtualización (KVM/HAXM/Hyper-V) |
| Xcode (macOS) | Compilar iOS | Imprescindible para iOS nativo |
| Docker + Supabase CLI | Backend local | A partir del Hito 6 |

## Configuración local

```bash
cp .env.example .env   # rellena SOLO valores de desarrollo local
```

Nunca subas `.env`, claves `service_role`, cadenas de conexión de PostgreSQL
ni archivos de firma. Ver [`docs/security/security-baseline.md`](docs/security/security-baseline.md).

## Ejecutar la app

```bash
cd apps/mobile
flutter pub get
flutter run --dart-define=APP_ENV=development
```

Pruebas de base de datos (migraciones + RLS, sin Docker):

```bash
bash scripts/test-db.sh
```

Comprobaciones locales de la app (las mismas que CI):

```bash
dart format --output=none --set-exit-if-changed lib test && flutter analyze && flutter test
```

## Documentación

- Producto: [visión](docs/product/vision.md) · [hoja de ruta](docs/product/roadmap.md)
- Arquitectura: [visión general](docs/architecture/overview.md) · [ADRs](docs/architecture/adr/)
- [Base de datos](docs/database/README.md) · [Sistema de diseño](docs/design/design-tokens.md)
- [Seguridad](docs/security/security-baseline.md) · [Pruebas](docs/testing/strategy.md) · [Despliegue](docs/deployment/README.md)

## Licencia

Software propietario. © Vivensia. Todos los derechos reservados.

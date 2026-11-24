# ADR 0002 — Identificador de aplicación

- **Estado:** Aceptado (sujeto a validación de marca/dominio antes de publicar)
- **Fecha:** 2026-11-24

## Decisión
- Android `applicationId` / iOS `PRODUCT_BUNDLE_IDENTIFIER`: **`com.vivensia.app`**
- Nombre visible: **Vivensia**
- Nombre del paquete Dart: `vivensia`

## Consecuencias
El identificador **no puede cambiarse** tras publicar en las tiendas.
Antes de la Fase 19 debe confirmarse el control del dominio `vivensia.app`
(o ajustarse el identificador) y la disponibilidad de la marca.
Variantes por entorno (p. ej. `com.vivensia.app.dev`) se evaluarán con los flavors.

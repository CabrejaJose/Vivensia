# ADR 0003 — Fuentes empaquetadas en la app

- **Estado:** Aceptado
- **Fecha:** 2026-11-24

## Contexto
El sistema de diseño usa **Manrope** (títulos) e **Inter** (contenido). Ambas
se distribuyen bajo **SIL Open Font License 1.1**, que permite uso comercial y
empaquetado en apps, conservando el archivo de licencia.

## Decisión
Incluir los archivos de fuente en `apps/mobile/assets/fonts/` junto con sus
licencias OFL, en lugar del paquete `google_fonts` (que descarga en tiempo de ejecución).

## Consecuencias
- + Funciona offline, sin llamadas a terceros (mejor privacidad), render consistente.
- − Aumenta ligeramente el tamaño de la app; se incluirán solo los pesos usados.

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

## Origen de los archivos (Hito 4)
TTF estáticos de los paquetes npm `@expo-google-fonts/manrope@0.4.3` e
`@expo-google-fonts/inter@0.4.2` (redistribuyen los binarios de Google Fonts).
Licencias `OFL.txt` descargadas del repositorio oficial `google/fonts`.
Pesos incluidos: Manrope 600/700/800, Inter 400/500/600 (~1.3 MB).

## Consecuencias
- + Funciona offline, sin llamadas a terceros (mejor privacidad), render consistente.
- − Aumenta ligeramente el tamaño de la app; se incluirán solo los pesos usados.

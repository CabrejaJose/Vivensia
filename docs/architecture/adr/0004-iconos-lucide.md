# ADR 0004 — Iconografía Lucide

- **Estado:** Aceptado
- **Fecha:** 2026-11-24

## Contexto
El plan pide Lucide o equivalente. Material Icons está disponible sin dependencias,
pero refuerza la apariencia Material genérica.

## Opciones evaluadas (pub.dev, 2026-11-24)
| Paquete | Versión | Última publicación | Puntos | Descargas/30 d |
|---|---|---|---|---|
| `lucide_icons_flutter` | 4.0.3 | 2026-11-10 | 150/160 | ~465 k |
| `lucide_icons` | 0.257.0 | 2023-06 (abandonado) | 45/160 | ~167 k |
| `flutter_lucide` | 1.78.0 | 2026-11-24 | 160/160 | ~30 k |

## Decisión
`lucide_icons_flutter` ^4.0.3: el más usado y mantenido activamente.
Licencias: paquete MIT; iconos Lucide ISC.

## Consecuencias
- + Trazo fino y redondeado coherente con la identidad cálida.
- − Dependencia externa; si se abandona, migrar a `flutter_lucide` (misma familia de iconos).

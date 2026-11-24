# Sistema de diseño — tokens iniciales

Identidad: cálida, familiar, premium, minimalista. Material 3 como base técnica,
**personalizado** (no apariencia Material por defecto).

## Color (primitivos)
| Token | Hex | Uso semántico previsto |
|---|---|---|
| green-600 | `#527A65` | primary |
| sage-400 | `#7FA68A` | secondary |
| cream-50 | `#F7F5EF` | background (claro) |
| terracotta-400 | `#C9816C` | accent / tertiary |
| green-900 | `#27352E` | text primary (claro) |
| gold-400 | `#D6AC60` | logros / destacados |
| white | `#FFFFFF` | surface (claro) |
| sage-100 | `#DCE8DF` | contenedores suaves |
| green-950 | `#141C18` | background (oscuro) |

Las pantallas consumen **tokens semánticos** (`primary`, `onPrimary`, `surface`,
`textPrimary`, `success`, `warning`, `danger`…), nunca primitivos ni hex.
El contraste de cada par se verificará (objetivo WCAG AA) en el Hito 4; p. ej.
texto blanco sobre `#527A65` debe comprobarse y, si no llega a 4.5:1 en texto
pequeño, se usará una variante más oscura.

## Tipografía
- Títulos: **Manrope** · Contenido y componentes: **Inter** (OFL, empaquetadas — ADR 0003).
- Escala basada en la de Material 3, respetando el escalado de texto del sistema.

## Espaciado
`4 · 8 · 12 · 16 · 24 · 32`

## Radios
`8 · 12 · 16 · 24 · 32`

## Movimiento
Animaciones fluidas, discretas y funcionales; duraciones como tokens
(p. ej. 150 / 250 / 400 ms) y respeto a "reducir movimiento".

## Temas
Claro, oscuro y automático (sistema).

## Componentes previstos (Hito 4)
Botones, campos de texto, tarjetas, diálogos, bottom sheets, progreso, listas,
badges, selectores, estados vacío/error, skeletons, barra de navegación, encabezados.

## Navegación principal
Barra inferior: **Inicio · Tareas · Compras · Agenda · Más**.

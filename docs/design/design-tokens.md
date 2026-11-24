# Sistema de diseño

Identidad: cálida, familiar, premium, minimalista. Material 3 como base técnica,
**personalizado** (esquemas de color construidos a mano, tipografía propia, iconos
Lucide, superficies planas con bordes sutiles).

Código: `apps/mobile/lib/design_system/` — importar siempre el barrel
`design_system/design_system.dart`.

```
design_system/
├── tokens/       color (primitivos) · spacing · radius · motion · size · elevation
├── theme/        esquemas M3 claro/oscuro · VivensiaColors (extensión) · ThemeData · themeModeProvider
├── typography/   escala Manrope + Inter
└── components/   Viv* (ver abajo)
```

## Reglas de uso
- Las pantallas usan **colores semánticos**: `Theme.of(context).colorScheme.*` y
  `context.vivColors.*`. Nunca `VivensiaPalette` ni `Color(0x…)` directamente.
- Espaciados, radios, tamaños y duraciones solo desde tokens (`VivSpacing`, `VivRadius`, `VivSize`, `VivMotion`).
- Componentes con prefijo `Viv`. Reciben textos ya localizados: no contienen copy propio.

## Color
### Paleta de marca (primitivos)
| Token | Hex | Rol |
|---|---|---|
| green600 | `#527A65` | primary (claro) |
| sage400 | `#7FA68A` | **solo decorativo** (blanco encima = 2.72:1 ✗) |
| cream50 | `#F7F5EF` | fondo (claro) |
| terracotta400 | `#C9816C` | **solo decorativo** (blanco encima = 3.07:1 ✗) |
| green900 | `#27352E` | texto principal (claro) |
| gold400 | `#D6AC60` | logros (texto verde profundo encima = 6.07:1 ✓) |
| white | `#FFFFFF` | superficie (claro) |
| sage100 | `#DCE8DF` | primaryContainer (claro) |
| green950 | `#141C18` | fondo (oscuro) |

### Derivados para accesibilidad
| Token | Hex | Por qué |
|---|---|---|
| green700 | `#3F6150` | Texto/enlaces verdes sobre crema: green600 da 4.45:1 (< 4.5) → green700 da 6.34:1 |
| terracotta600 | `#A35F4B` | Terciario con texto blanco: 4.89:1 |
| green300 | `#8DBA9C` | Primario en oscuro: 7.97:1 sobre el fondo |

### Verificación
`test/design_system/contrast_test.dart` comprueba **62 pares** (31 por tema):
texto ≥ 4.5:1 y componentes de interfaz ≥ 3:1. Todos pasan.

### Colores semánticos extra (`VivensiaColors`)
background, textPrimary, textSecondary, link, success/warning/info (+ container),
gold (+ container), decorativeSage, decorativeTerracotta, skeletonBase/Highlight.

## Tipografía
- Títulos (display, headline, title): **Manrope** 600/700/800.
- Cuerpo y etiquetas: **Inter** 400/500/600.
- Archivos TTF estáticos en `assets/fonts/` con su `OFL.txt` (ADR 0003).
- Respeta el escalado de texto del sistema (probado con 1.3×).

## Escalas
| | Valores |
|---|---|
| Espaciado | 4 · 8 · 12 · 16 · 24 · 32 |
| Radios | 8 · 12 · 16 · 24 · 32 · pill |
| Movimiento | 150 / 250 / 400 ms; brillo de skeleton 1400 ms |
| Área táctil mínima | 48 dp |

## Iconos
Lucide vía `lucide_icons_flutter` (ADR 0004). El botón de volver/cerrar del tema también usa Lucide.

## Componentes
| Componente | Notas |
|---|---|
| `VivButton` | primary · secondary · tertiary · destructive; icono; `isLoading` deshabilita y muestra progreso |
| `VivTextField` / `.password` | etiqueta, ayuda, error; contraseña con mostrar/ocultar accesible |
| `VivCard` | surface · tonal · accent; `onTap` opcional |
| `showVivConfirmDialog` | devuelve `true` solo al confirmar; variante destructiva |
| `showVivBottomSheet` | asa, título, área segura, teclado |
| `VivProgressBar`, `VivLoader` | etiquetas accesibles |
| `VivListTile`, `VivListTileContent` | icono en contenedor tonal |
| `VivBadge` | 7 tonos; siempre con texto (el color no es el único significado) |
| `VivChoiceChips`, `VivSegmentedControl` | selección única |
| `VivEmptyState`, `VivErrorState`, `VivLoadingState` | estados estándar |
| `VivSkeleton`, `VivSkeletonListTile` | estático si el sistema reduce animaciones |
| `VivNavigationBar` | Inicio · Tareas · Compras · Agenda · Más |
| `VivPageHeader`, `VivSectionHeader` | encabezados con semántica de título |

## Temas
Claro, oscuro y sistema (`themeModeProvider`, por defecto sistema). Persistencia de
la preferencia: pendiente para la pantalla de Configuración.

## Pantalla de demostración
Ruta `/dev/design-system`, **solo en builds no release**; accesible desde el botón
"Ver sistema de diseño" de la pantalla de inicio provisional. Muestra datos marcados
como "Datos de ejemplo".

## Capturas
Renderizadas por el motor de Flutter con las fuentes reales (no emulador):
`apps/mobile/screenshots/goldens/`. Regenerar con:

```bash
cd apps/mobile && flutter test screenshots --update-goldens
```

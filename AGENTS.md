# AGENTS.md — Reglas permanentes del proyecto Vivensia

Este archivo es de lectura obligatoria para cualquier agente de IA
(Antigravity, Claude Code u otros) antes de modificar el repositorio.

## Producto

- Vivensia es **UNA sola app** (Android + iOS, Flutter). Sin submarcas,
  sin apps independientes, sin nombres comerciales adicionales.
- Tody, Budgy, Bring!, TimeTree y Paprika son **referencias funcionales**.
  No copiar su código, marcas, mascotas, ilustraciones ni diseños.
- La app debe funcionar sin depender de la IA.
- Identificador de aplicación: `com.vivensia.app`.

## Forma de trabajo

1. Inspeccionar antes de modificar. No asumir herramientas instaladas.
2. Presentar un plan antes de implementar.
3. Trabajar **solo en la fase/hito autorizado**. No avanzar automáticamente.
4. Tareas pequeñas y commits pequeños y descriptivos (Conventional Commits:
   `feat:`, `fix:`, `docs:`, `chore:`, `test:`, `refactor:`, `ci:`).
5. No modificar funcionalidades fuera del alcance.
6. No eliminar archivos con riesgo de pérdida de trabajo sin autorización.
7. No ejecutar comandos destructivos (`rm -rf`, `git push --force`,
   `git reset --hard`, `DROP` sobre datos reales…).
8. No crear servicios remotos de pago ni desplegar sin autorización.
9. No instalar herramientas globales ni cambiar configuración del sistema sin permiso.
10. **No inventar resultados**: ni pruebas, ni capturas, ni "funciona" sin ejecutarlo.
11. No desactivar ni saltarse pruebas para obtener verde.
12. Documentar decisiones en `docs/architecture/adr/` y actualizar `CHANGELOG.md`.
13. No sustituir Flutter por web ni usar WebView como arquitectura principal.
14. No usar datos reales ni credenciales de producción en desarrollo.

## Arquitectura

- Monolito modular, **feature-first + Clean Architecture pragmática**:
  `presentation/ → application/ → domain/ ← data/`.
- `domain` no depende de Flutter, Supabase ni de otros features.
- Las pantallas no contienen SQL ni lógica de negocio compleja.
- Un feature no importa pantallas/widgets internos de otro feature.
  La comunicación entre features pasa por contratos de `domain` o por `core`.
- Estado: Riverpod. Navegación: GoRouter.
- Sin abstracciones que no aporten valor (no crear interfaces "por si acaso").

## Diseño

- Todos los colores, tipografías, espaciados, radios y duraciones
  salen de `lib/design_system/tokens`. **Prohibido** `Color(0xFF…)` o
  números mágicos dispersos en pantallas.
- Ningún texto visible hardcodeado en widgets: usar l10n (es/en).
- Objetivo de accesibilidad: WCAG AA, áreas táctiles ≥ 48 dp, escalado de texto.

## Seguridad (innegociable)

- **Nunca** commitear secretos. `.env` está ignorado; solo `.env.example`.
- **Nunca** incluir `service_role`, cadenas de conexión de PostgreSQL ni
  claves de IA/pagos/push en la app móvil.
- RLS activado en **todas** las tablas con datos de usuario; denegar por defecto.
- Aislamiento por hogar (`household_id`) y pruebas de acceso cruzado.
- Dinero con tipos exactos (`numeric` en PostgreSQL; nunca `double` para importes).
- No registrar datos sensibles en logs.
- No afirmar cifrado de extremo a extremo si no está implementado y verificado.
- Ejecutar `scripts/check-secrets.sh` antes de cada commit.

## Internacionalización

- Sin monedas fijas (ni RD$ ni USD) en la lógica de negocio.
- Fechas, horas, zonas horarias y unidades según configuración del usuario/hogar.

## Definición de terminado

Un hito solo es **COMPLETADO** si cumple sus criterios de aceptación,
pasa análisis y pruebas reales, está documentado y el responsable lo aprueba.
Estados: PENDIENTE · EN PROGRESO · BLOQUEADO · EN REVISIÓN · COMPLETADO.

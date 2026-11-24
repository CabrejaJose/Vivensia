# ADR 0005 — Modelo de acceso por hogar (RLS)

- **Estado:** Aceptado
- **Fecha:** 2026-11-24

## Decisión
- Todo dato compartido lleva `household_id`; RLS lo filtra con funciones
  `security definer` en el esquema `private` (`is_household_member`, `household_role_of`,
  `shares_household_with`) para evitar recursión de políticas.
- Roles: `owner` > `admin` > `member`. Solo los owners cambian roles.
- Privilegios mínimos: se revocan los privilegios por defecto de Supabase en `public`
  y se conceden por operación y por columna (UPDATE).
- Altas en `households`/`household_members` solo mediante funciones (`create_household`,
  invitaciones en Fase 03), nunca con INSERT directo, para impedir auto-asignarse roles.
- Funciones `security definer` con `search_path = ''` y nombres totalmente cualificados.

## Consecuencias
- + El aislamiento no depende de la interfaz; probado con pruebas de acceso cruzado.
- − Cada tabla nueva debe definir privilegios y políticas explícitas y añadir pruebas.

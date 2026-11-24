# ADR 0006 — Pruebas de base de datos sin Docker

- **Estado:** Aceptado
- **Fecha:** 2026-11-24

## Contexto
`supabase start` y `supabase test db` requieren Docker, no disponible en el entorno
de agente en la nube. pgTAP no está instalado.

## Decisión
`scripts/test-db.sh` levanta un PostgreSQL temporal, aplica una emulación mínima de
Supabase (`supabase/tests/setup/00_supabase_shim.sql`: roles, `auth.users`,
`auth.uid()`, privilegios por defecto), las migraciones reales y pruebas SQL con
aserciones propias. Corre igual en local y en GitHub Actions.

## Consecuencias
- + Rápido, reproducible, sin Docker; detecta regresiones de RLS (verificado con mutaciones).
- − PostgreSQL 16 local frente a 17 en Supabase; el shim no replica todo Supabase.
  Mitigación: validar también con `supabase db reset` cuando haya Docker y antes de
  aplicar migraciones a un proyecto remoto.
- Migrar a pgTAP si se adopta `supabase test db` como ejecutor principal.

# Changelog

Todos los cambios relevantes de Vivensia se documentan aquí.
Formato basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/)
y versionado [SemVer](https://semver.org/lang/es/).

## [Unreleased]

### Added
- Sprint 01 · Hito 3: app Flutter en `apps/mobile` (`com.vivensia.app`, nombre "Vivensia").
- Riverpod, GoRouter, localización es/en, `AppConfig` por entorno y manejo global de errores.
- Lints estrictos (`strict-casts`, `strict-inference`, `strict-raw-types`).
- Pruebas unitarias y de widgets iniciales (9).
- CI fijado a Flutter 3.50.1.
- Sprint 01 · Hito 2: estructura inicial del repositorio.
- Documentación de producto, arquitectura (ADR 0001–0003), base de datos,
  diseño, seguridad, pruebas, despliegue y sprint 01.
- `AGENTS.md` con las reglas permanentes para agentes de IA.
- `.gitignore`, `.gitattributes`, `.editorconfig` y `.env.example` sin secretos.
- Script `scripts/check-secrets.sh` y workflow de CI (higiene + Flutter condicional).

# ADR 0007 — Autenticación, sesión y modo demostración

- **Estado:** Aceptado
- **Fecha:** 2026-11-24

## Decisión
- Supabase Auth con flujo **PKCE** y clave **publicable** (`publishableKey`).
- Sesión y verificador PKCE en **almacenamiento seguro del sistema** (`flutter_secure_storage`):
  Keychain con `first_unlock_this_device` en iOS, Keystore en Android.
- Errores de Supabase traducidos a `AuthFailure` (dominio) en la capa de datos; la UI nunca
  muestra mensajes del servidor.
- Anti-enumeración: el registro con confirmación y la recuperación de contraseña responden
  igual exista o no la cuenta.
- Guardia de rutas basada en `AuthStatus`; la navegación tras iniciar/cerrar sesión la decide
  el router, no las pantallas.
- **Modo demostración**: si el entorno no tiene backend, la app funciona con datos de ejemplo,
  sin pantallas de auth, y lo indica en Más. Las builds de publicación deberán exigir backend
  (control en CI antes de la Fase 18).

## Consecuencias
- + Credenciales cifradas en reposo; dominio testeable sin red; UI estable ante cambios del SDK.
- − Dos implementaciones de almacenamiento que mantener frente a cambios de `LocalStorage` /
  `GotrueAsyncStorage` del SDK (cubiertas por pruebas).

# Estrategia de autenticación

- **Estado:** En implementación (Fase 02; ver `docs/sprints/phase-02-auth.md` y ADR 0007)
- **Fecha:** 2026-11-24

## Proveedor
Supabase Auth. La app solo usa la URL del proyecto y la clave publicable (antes "anon");
toda autorización se resuelve con RLS en PostgreSQL.

## Métodos
| Método | Fase | Notas |
|---|---|---|
| Email + contraseña | 02 | Contraseña ≥ 8 con letras y dígitos (también en `config.toml` local) |
| Recuperación por email | 02 | Enlace profundo a la app |
| Sign in with Apple | 02 | **Obligatorio en iOS** si se ofrece otro inicio social (App Store 4.8) |
| Google | 02 | Nativo en Android/iOS |
| Anónimo | ✗ | No previsto: los datos del hogar son compartidos |

## Decisiones
- Flujo PKCE para enlaces de confirmación y recuperación (deep links con el esquema de la app).
- Sesión y verificador PKCE en almacenamiento seguro (Keychain / Keystore) mediante
  `SecureSessionStorage` / `SecurePkceStorage` (el SDK usaría `SharedPreferences`, sin cifrar).
- Confirmación de email **activada en staging y producción** (en local está desactivada).
- Cambio de contraseña con reautenticación (`secure_password_change`).
- El perfil se crea por trigger; el nombre se pide en el onboarding (no se deriva del email).
- Eliminación de cuenta desde la app (requisito de Apple y Google), con sucesión de
  propiedad de hogares ya resuelta en la base de datos.
- Límites de intentos: los de Supabase Auth; revisar en el panel antes de la beta.

## Fuera de alcance del Hito 6
Integrar `supabase_flutter`, pantallas de registro/inicio y deep links (Fase 02).

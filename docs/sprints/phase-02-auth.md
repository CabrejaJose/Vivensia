# Fase 02 — Autenticación

| Hito | Contenido | Estado |
|---|---|---|
| 2.1 | Infraestructura (Supabase, sesión cifrada, guardia de rutas, modo demo) + email/contraseña (bienvenida, registro, inicio, recuperación) | COMPLETADO (aprobado 2026-11-24) |
| 2.3 | Onboarding (nombre/idioma → `profiles`), perfil | EN REVISIÓN |
| 2.4 | Enlaces profundos: confirmación de email y nueva contraseña (PKCE) | PENDIENTE — esquema `vivensia://` (decidido 2026-11-24) |
| 2.5 | Sign in with Apple y Google | PENDIENTE — requiere cuentas de desarrollador |
| 2.6 | Eliminación de cuenta (Edge Function) | PENDIENTE |
| 2.7 | Validación con backend real (staging) en emulador | PENDIENTE — requiere proyecto staging |

El antiguo 2.2 (email y contraseña) se integró en 2.1: sin pantallas no se podía
probar la guardia de rutas de extremo a extremo.

## Hito 2.1 — resultado
- Dependencias: `supabase_flutter` ^2.18.3 (publisher supabase.io), `flutter_secure_storage` ^11.2.0.
- `SecureSessionStorage` y `SecurePkceStorage`: sesión y verificador PKCE en Keychain/Keystore
  (por defecto `supabase_flutter` usa `SharedPreferences`, no cifrado). iOS: `first_unlock_this_device`.
- `initializeSupabase()`: flujo PKCE, `publishableKey` (`anonKey` está obsoleto en el SDK),
  enlaces de auth desactivados hasta 2.4. Config renombrada a `SUPABASE_PUBLISHABLE_KEY`.
- Dominio: `AuthUser`, `AuthStatus` (demo / sin sesión / con sesión), `AuthFailure`, validadores
  alineados con `config.toml` (≥ 8, letras y dígitos) y contrato `AuthRepository`.
- Datos: `SupabaseAuthRepository` + `mapAuthError` (códigos de Supabase → `AuthFailure`).
  La recuperación de contraseña nunca revela si el email existe.
- Aplicación: `authStatusProvider` (stream), `AuthActions` (normaliza email/nombre).
- Router: guardia `authRedirect` (pura y probada) con `refreshListenable`.
  Sin backend → **modo demostración** (como hasta ahora, indicado en Más).
- Pantallas: carga, bienvenida, inicio de sesión, registro (+ "Revisa tu correo"),
  recuperación; cerrar sesión en Más. Componentes nuevos `VivNotice` y `VivBrandMark`.
- Pruebas: 175/175 (39 nuevas: validadores, errores, almacenamiento, guardia, flujos completos
  con repositorio falso, desbordamientos de auth en 4 tamaños × 2 temas). 20 capturas.
- **No verificado aquí**: compilación nativa (Maven Central limita al contenedor; la valida CI)
  ni contra un Supabase real (requiere staging, Hito 2.7).

## Hito 2.3 — resultado
- Feature `profile`: `UserProfile` (dominio), `ProfileRepository` + `SupabaseProfileRepository`
  (`public.profiles`, protegido por RLS), `myProfileProvider`, `ProfileActions`.
- Guardia extendida: con sesión, perfil cargando → carga; sin nombre → **onboarding**
  ("¿Cómo te llamamos?" + idioma); un error al cargar el perfil no bloquea el acceso.
- **Mi perfil** (desde Más): nombre, idioma y email de solo lectura.
- El idioma del perfil se aplica a toda la app (`MaterialApp.locale`); sin sesión, el del dispositivo.
- Inicio saluda por el nombre ("Buenos días, Ana").
- `VivFormLayout` pasa al sistema de diseño (lo usan auth y perfil).
- Pruebas: 192/192 (17 nuevas). 23 capturas (3 nuevas; las 20 anteriores sin cambios).

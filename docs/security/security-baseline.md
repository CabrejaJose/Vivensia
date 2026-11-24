# Línea base de seguridad

## Secretos
- Ningún secreto en Git. `.env` ignorado; solo `.env.example` con placeholders.
- La app móvil solo conoce `SUPABASE_URL` y la clave publicable (antes "anon") del entorno.
- `service_role`, contraseñas de BD, claves de IA, pagos y push → solo en
  Edge Functions / secretos de CI.
- `scripts/check-secrets.sh` se ejecuta en CI y debe pasarse antes de cada commit.
- **Si un secreto se expone (chat, commit, captura): se rota inmediatamente.**
  Borrar el mensaje o el commit no es suficiente.

## Datos
- RLS en todas las tablas con datos de usuario; denegar por defecto.
- Aislamiento por hogar; los permisos se verifican en el backend, no en la UI.
- Prevención de escalamiento de privilegios (un miembro no puede auto-asignarse `owner`).
- Datos privados vs compartidos explícitos en el modelo.
- Buckets de Storage privados con políticas por hogar/documento.
- Sin datos sensibles en logs ni en analítica.

## Cliente
- Tokens de sesión en almacenamiento seguro (Keychain / Keystore).
- Solo HTTPS. Validación de entradas y de archivos subidos (tipo/tamaño).

## Servicios sensibles
- Límites de uso (rate limiting) en Edge Functions de IA/OCR.
- La IA actúa con herramientas autorizadas, respeta RLS y pide confirmación
  antes de cambios sensibles.

## Cumplimiento
- Exportación y eliminación de cuenta (requisito de Apple y Google).
- Entornos separados: development, staging, production.
- No se afirmará cifrado de extremo a extremo sin implementarlo y verificarlo.
- Documentos y credenciales del hogar (Wi-Fi) requieren **modelo de amenazas**
  propio antes de la Fase 12.

## Pruebas
- Pruebas de acceso cruzado entre hogares para cada tabla nueva.
- Revisión de seguridad al cierre de cada fase.

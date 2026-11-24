# Despliegue y plataformas

## Entornos
| Entorno | Backend | Uso |
|---|---|---|
| development | Supabase local (Docker) o proyecto dev | Desarrollo diario, datos ficticios |
| staging | Proyecto Supabase staging | QA y beta |
| production | Proyecto Supabase producción | Usuarios reales |

Ningún proyecto remoto se crea ni modifica sin autorización explícita.

## Android
- Requiere Android SDK; el emulador necesita virtualización por hardware.
- Firma de release con keystore fuera del repositorio (secretos de CI).

## iOS
- **Compilar, firmar y ejecutar iOS requiere macOS con Xcode**
  (o runners macOS de CI). Desde Windows/Linux solo se puede escribir y
  probar código Dart; la validación nativa de iOS queda pendiente de ese entorno.
- Publicación requiere cuenta Apple Developer.

## Limitaciones conocidas del entorno de agente en la nube (Sprint 01)
- Linux sin KVM → sin emulador Android.
- `dl.google.com` bloqueado por la red del entorno → sin Android SDK salvo autorización.
- Sin macOS → sin iOS.
- La evidencia de ejecución real en Android se obtendrá en la máquina del
  desarrollador o en CI.

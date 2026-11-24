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
- `dl.google.com` permitido desde el Hito 4 → Android SDK y compilación de APK disponibles.
- `repo.maven.apache.org` responde 429 vía proxy → se usa un init script local de Gradle
  (`~/.gradle/init.d/`) que redirige Maven Central a `repo1.maven.org`. No afecta al repositorio.
- Sin macOS → sin iOS.
- La evidencia de ejecución real en Android se obtendrá en la máquina del
  desarrollador o en CI.

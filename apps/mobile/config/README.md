# Configuración por entorno

Copia el ejemplo y rellena SOLO valores aptos para el cliente:

```bash
cp config/development.example.json config/development.json
flutter run --dart-define-from-file=config/development.json
```

- `config/*.json` está ignorado por Git (excepto `*.example.json`).
- `SUPABASE_PUBLISHABLE_KEY` es la clave publicable (antes "anon"): está protegida por RLS.
- **Nunca** pongas aquí `service_role`, contraseñas de base de datos ni claves de terceros.
- En local, `supabase status` muestra la URL y la clave publicable.

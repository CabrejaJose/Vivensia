import 'package:supabase_flutter/supabase_flutter.dart';

import '../../app/config/app_config.dart';
import '../security/secure_auth_storage.dart';

/// Inicializa Supabase si el entorno tiene backend configurado.
///
/// Devuelve `null` en modo demostración (sin backend).
Future<SupabaseClient?> initializeSupabase(AppConfig config) async {
  if (!config.hasBackend) return null;
  await Supabase.initialize(
    url: config.supabaseUrl,
    publishableKey: config.supabasePublishableKey,
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
      localStorage: SecureSessionStorage(),
      pkceAsyncStorage: SecurePkceStorage(),
      // Los enlaces profundos de auth se gestionan en el Hito 2.4.
      detectSessionInUri: false,
    ),
    debug: false,
  );
  return Supabase.instance.client;
}

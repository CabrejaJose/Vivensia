import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Entornos de ejecución soportados.
enum AppEnvironment {
  development,
  staging,
  production;

  static AppEnvironment parse(String value) => AppEnvironment.values.firstWhere(
    (e) => e.name == value.trim().toLowerCase(),
    orElse: () => AppEnvironment.development,
  );
}

/// Configuración inmutable de la app, inyectada en tiempo de compilación con
/// `--dart-define` o `--dart-define-from-file`.
///
/// Solo contiene valores aptos para el cliente. Nunca añadir aquí claves
/// `service_role`, contraseñas de base de datos ni secretos de terceros.
class AppConfig {
  const AppConfig({
    required this.environment,
    this.supabaseUrl = '',
    this.supabasePublishableKey = '',
  });

  factory AppConfig.fromEnvironment() => AppConfig(
    environment: AppEnvironment.parse(
      const String.fromEnvironment('APP_ENV', defaultValue: 'development'),
    ),
    supabaseUrl: const String.fromEnvironment('SUPABASE_URL').trim(),
    supabasePublishableKey: const String.fromEnvironment(
      'SUPABASE_PUBLISHABLE_KEY',
    ).trim(),
  );

  final AppEnvironment environment;

  /// URL del proyecto Supabase del entorno. Vacía si no se configuró.
  final String supabaseUrl;

  /// Clave publicable (antes "anon"), protegida por RLS. Nunca `service_role`.
  final String supabasePublishableKey;

  bool get isProduction => environment == AppEnvironment.production;

  /// `true` si hay backend configurado. Sin él, la app usa datos de ejemplo.
  bool get hasBackend {
    final uri = Uri.tryParse(supabaseUrl);
    final validUrl =
        uri != null &&
        uri.hasAuthority &&
        (uri.scheme == 'https' || (!isProduction && uri.scheme == 'http'));
    return validUrl && supabasePublishableKey.isNotEmpty;
  }

  /// Representación sin secretos para registros de diagnóstico.
  @override
  String toString() =>
      'AppConfig(environment: ${environment.name}, hasBackend: $hasBackend)';
}

/// Se sobrescribe en `bootstrap()` con la configuración real.
final appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError(
    'appConfigProvider debe sobrescribirse en bootstrap()',
  ),
);

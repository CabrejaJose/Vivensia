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
  const AppConfig({required this.environment});

  factory AppConfig.fromEnvironment() => AppConfig(
    environment: AppEnvironment.parse(
      const String.fromEnvironment('APP_ENV', defaultValue: 'development'),
    ),
  );

  final AppEnvironment environment;

  bool get isProduction => environment == AppEnvironment.production;
}

/// Se sobrescribe en `bootstrap()` con la configuración real.
final appConfigProvider = Provider<AppConfig>(
  (ref) => throw UnimplementedError(
    'appConfigProvider debe sobrescribirse en bootstrap()',
  ),
);

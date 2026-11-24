import 'package:flutter_test/flutter_test.dart';
import 'package:vivensia/app/config/app_config.dart';

void main() {
  group('AppEnvironment.parse', () {
    test('reconoce los entornos válidos sin importar mayúsculas', () {
      expect(AppEnvironment.parse('staging'), AppEnvironment.staging);
      expect(AppEnvironment.parse(' Production '), AppEnvironment.production);
    });

    test('valor desconocido cae a development', () {
      expect(AppEnvironment.parse('foo'), AppEnvironment.development);
    });
  });

  test('por defecto (sin --dart-define) es development y sin backend', () {
    final config = AppConfig.fromEnvironment();
    expect(config.environment, AppEnvironment.development);
    expect(config.isProduction, isFalse);
    expect(config.hasBackend, isFalse);
  });

  group('hasBackend', () {
    test('requiere URL válida y clave', () {
      expect(
        const AppConfig(
          environment: AppEnvironment.development,
          supabaseUrl: 'http://127.0.0.1:54321',
          supabaseAnonKey: 'k',
        ).hasBackend,
        isTrue,
      );
      expect(
        const AppConfig(
          environment: AppEnvironment.development,
          supabaseUrl: 'http://127.0.0.1:54321',
        ).hasBackend,
        isFalse,
      );
      expect(
        const AppConfig(
          environment: AppEnvironment.development,
          supabaseUrl: 'no es una url',
          supabaseAnonKey: 'k',
        ).hasBackend,
        isFalse,
      );
    });

    test('producción exige HTTPS', () {
      expect(
        const AppConfig(
          environment: AppEnvironment.production,
          supabaseUrl: 'http://example.supabase.co',
          supabaseAnonKey: 'k',
        ).hasBackend,
        isFalse,
      );
      expect(
        const AppConfig(
          environment: AppEnvironment.production,
          supabaseUrl: 'https://example.supabase.co',
          supabaseAnonKey: 'k',
        ).hasBackend,
        isTrue,
      );
    });

    test('toString no expone la clave', () {
      const config = AppConfig(
        environment: AppEnvironment.staging,
        supabaseUrl: 'https://example.supabase.co',
        supabaseAnonKey: 'clave-secreta-de-prueba',
      );
      expect(config.toString(), isNot(contains('clave-secreta-de-prueba')));
    });
  });
}

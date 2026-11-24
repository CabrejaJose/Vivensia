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

  test('por defecto (sin --dart-define) es development', () {
    final config = AppConfig.fromEnvironment();
    expect(config.environment, AppEnvironment.development);
    expect(config.isProduction, isFalse);
  });
}

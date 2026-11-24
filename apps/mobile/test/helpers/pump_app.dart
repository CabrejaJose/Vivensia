import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/app.dart';
import 'package:vivensia/app/config/app_config.dart';

/// Monta la app completa con un idioma de dispositivo concreto.
Future<void> pumpVivensiaApp(
  WidgetTester tester, {
  Locale locale = const Locale('es'),
}) async {
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(environment: AppEnvironment.development),
        ),
      ],
      child: const VivensiaApp(),
    ),
  );
  await tester.pumpAndSettle();
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/app.dart';
import 'package:vivensia/app/config/app_config.dart';
import 'package:vivensia/core/utils/clock.dart';

/// Hora fija por defecto en pruebas: 09:00 (mañana).
final fixedMorning = DateTime(2026, 11, 24, 9);

/// Avanza el tiempo sin `pumpAndSettle` (loaders y skeletons animan siempre).
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Monta la app completa con idioma, hora y tamaño de pantalla controlados.
Future<void> pumpVivensiaApp(
  WidgetTester tester, {
  Locale locale = const Locale('es'),
  DateTime? now,
  Size? size,
  double textScale = 1,
  List<Override> overrides = const [],
}) async {
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  if (size != null) {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
  }
  if (textScale != 1) {
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
  }
  final time = now ?? fixedMorning;
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(environment: AppEnvironment.development),
        ),
        clockProvider.overrideWithValue(() => time),
        ...overrides,
      ],
      child: const VivensiaApp(),
    ),
  );
  await settle(tester);
}

/// Navega a una ruta usando el router de la app.
ProviderContainer containerOf(WidgetTester tester) =>
    ProviderScope.containerOf(tester.element(find.byType(VivensiaApp)));

/// Busca [text] dentro de la pantalla [T], desplaza su lista hasta que sea
/// visible y lo pulsa. Evita coincidencias en pestañas ocultas del shell.
Future<void> tapInScreen<T extends Widget>(
  WidgetTester tester,
  String text,
) async {
  final scope = find.byType(T);
  final target = find.descendant(of: scope, matching: find.text(text));
  final scrollable = find
      .descendant(of: scope, matching: find.byType(Scrollable))
      .first;
  await tester.scrollUntilVisible(target, 150, scrollable: scrollable);
  // Puede estar construido (caché del ListView) pero fuera de la vista.
  await tester.ensureVisible(target.first);
  await tester.pump();
  await tester.tap(target.first);
  await settle(tester);
}

// Pruebas de integración en dispositivo/emulador real.
//
//   flutter drive --driver=test_driver/integration_test.dart \
//     --target=integration_test/app_test.dart
//
// Las capturas se guardan en build/integration_screenshots/.
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/app.dart';
import 'package:vivensia/app/config/app_config.dart';
import 'package:vivensia/app/navigation/more_screen.dart';
import 'package:vivensia/core/utils/clock.dart';
import 'package:vivensia/design_system/design_system.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 15; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  var surfaceConverted = false;
  Future<void> shot(WidgetTester tester, String name) async {
    if (Platform.isAndroid && !surfaceConverted) {
      await binding.convertFlutterSurfaceToImage();
      surfaceConverted = true;
    }
    await settle(tester);
    await binding.takeScreenshot(name);
  }

  Finder navItem(String label) => find.descendant(
    of: find.byType(NavigationBar),
    matching: find.text(label),
  );

  Future<void> tapInMore(WidgetTester tester, String text) async {
    final scope = find.byType(MoreScreen);
    final target = find.descendant(of: scope, matching: find.text(text));
    final scrollable = find
        .descendant(of: scope, matching: find.byType(Scrollable))
        .first;
    await tester.scrollUntilVisible(target, 150, scrollable: scrollable);
    await tester.ensureVisible(target.first);
    await settle(tester);
    await tester.tap(target.first);
    await settle(tester);
  }

  testWidgets('recorrido principal en dispositivo', (tester) async {
    tester.platformDispatcher.localesTestValue = [const Locale('es')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(environment: AppEnvironment.development),
          ),
          clockProvider.overrideWithValue(() => DateTime(2026, 11, 24, 9)),
        ],
        child: const VivensiaApp(),
      ),
    );
    await settle(tester);

    expect(find.text('Buenos días'), findsOneWidget);
    expect(find.widgetWithText(VivBadge, 'Datos de ejemplo'), findsOneWidget);
    await shot(tester, '01_inicio_claro');

    await tester.tap(navItem('Tareas'));
    await settle(tester);
    expect(find.text('Aquí verás las tareas del hogar'), findsOneWidget);
    await shot(tester, '02_tareas');

    await tester.tap(navItem('Compras'));
    await settle(tester);
    expect(find.text('Aquí verás tus listas de compras'), findsOneWidget);
    await shot(tester, '03_compras');

    await tester.tap(navItem('Agenda'));
    await settle(tester);
    expect(find.text('Aquí verás los eventos del hogar'), findsOneWidget);
    await shot(tester, '04_agenda');

    await tester.tap(navItem('Más'));
    await settle(tester);
    expect(find.text('Funciones'), findsOneWidget);
    await shot(tester, '05_mas');

    await tapInMore(tester, 'Finanzas');
    expect(find.text('Próximamente'), findsOneWidget);
    await shot(tester, '06_proximamente');
    await tester.tap(find.byType(BackButton));
    await settle(tester);

    await tapInMore(tester, 'Oscuro');
    await tester.tap(navItem('Inicio'));
    await settle(tester);
    expect(
      Theme.of(tester.element(find.text('Buenos días'))).brightness,
      Brightness.dark,
    );
    await shot(tester, '07_inicio_oscuro');

    await tester.tap(navItem('Más'));
    await settle(tester);
    await tapInMore(tester, 'Ver sistema de diseño');
    expect(find.text('Sistema de diseño'), findsWidgets);
    await shot(tester, '08_sistema_diseno_oscuro');

    expect(tester.takeException(), isNull);
  });
}

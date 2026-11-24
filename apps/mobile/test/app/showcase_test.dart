import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/app.dart';
import 'package:vivensia/app/router/app_router.dart';
import 'package:vivensia/app/router/app_routes.dart';
import 'package:vivensia/design_system/design_system.dart';

import '../helpers/pump_app.dart';

/// Los loaders y skeletons animan indefinidamente: se avanza con tiempo
/// fijo en vez de `pumpAndSettle`.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> openShowcase(WidgetTester tester) async {
  await tester.tap(find.text('Ver sistema de diseño'));
  await settle(tester);
}

final demoBadge = find.widgetWithText(VivBadge, 'Datos de ejemplo');

/// Recorre toda la lista: cualquier desbordamiento hace fallar la prueba.
Future<void> scrollToEnd(WidgetTester tester) async {
  final list = find.byType(Scrollable).first;
  for (var i = 0; i < 40; i++) {
    await tester.drag(list, const Offset(0, -500));
    await tester.pump(const Duration(milliseconds: 50));
  }
}

void main() {
  group('Pantalla de sistema de diseño', () {
    testWidgets('se abre desde inicio en builds de desarrollo', (tester) async {
      await pumpVivensiaApp(tester);
      await openShowcase(tester);
      expect(find.text('Sistema de diseño'), findsWidgets);
      expect(demoBadge, findsOneWidget);
    });

    for (final (name, size, scale) in [
      ('teléfono pequeño 320×640', const Size(320, 640), 1.0),
      ('teléfono 390×844 con texto 1.3×', const Size(390, 844), 1.3),
      ('tablet 820×1180', const Size(820, 1180), 1.0),
    ]) {
      testWidgets('sin desbordamientos en $name', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(tester.view.reset);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

        await pumpVivensiaApp(tester);
        await openShowcase(tester);
        await scrollToEnd(tester);
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('el selector de tema cambia a oscuro y a claro', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await pumpVivensiaApp(tester);
      await openShowcase(tester);
      BuildContext ctx() => tester.element(demoBadge);

      await tester.tap(find.text('Oscuro'));
      await settle(tester);
      expect(Theme.of(ctx()).brightness, Brightness.dark);

      await tester.tap(find.text('Claro'));
      await settle(tester);
      expect(Theme.of(ctx()).brightness, Brightness.light);
    });

    testWidgets('se muestra en inglés', (tester) async {
      await pumpVivensiaApp(tester, locale: const Locale('en'));
      final container = ProviderScope.containerOf(
        tester.element(find.byType(VivensiaApp)),
      );
      container.read(appRouterProvider).go(AppRoutes.designSystem);
      await settle(tester);
      expect(find.text('Design system'), findsWidgets);
      expect(find.widgetWithText(VivBadge, 'Sample data'), findsOneWidget);
    });
  });
}

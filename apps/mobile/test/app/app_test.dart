import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/app.dart';
import 'package:vivensia/app/router/app_router.dart';

import '../helpers/pump_app.dart';

void main() {
  group('VivensiaApp', () {
    testWidgets('arranca en Inicio en español', (tester) async {
      await pumpVivensiaApp(tester, locale: const Locale('es', 'DO'));
      expect(find.text('Buenos días'), findsOneWidget);
      expect(find.text('Organiza tu hogar'), findsOneWidget);
    });

    testWidgets('arranca en Inicio en inglés', (tester) async {
      await pumpVivensiaApp(tester, locale: const Locale('en', 'US'));
      expect(find.text('Good morning'), findsOneWidget);
      expect(find.text('Organize your home'), findsOneWidget);
    });

    testWidgets('idioma no soportado usa inglés', (tester) async {
      await pumpVivensiaApp(tester, locale: const Locale('fr', 'FR'));
      expect(find.text('Good morning'), findsOneWidget);
    });

    testWidgets('ruta inexistente muestra error y permite volver', (
      tester,
    ) async {
      await pumpVivensiaApp(tester);
      containerOf(tester).read(appRouterProvider).go('/no-existe');
      await settle(tester);
      expect(find.text('No encontramos esta página'), findsOneWidget);

      await tester.tap(find.text('Ir al inicio'));
      await settle(tester);
      expect(find.text('Buenos días'), findsOneWidget);
    });
  });

  group('resolveLocale', () {
    const supported = [Locale('es'), Locale('en')];

    test('coincide por código de idioma', () {
      expect(
        resolveLocale(const Locale('es', 'MX'), supported),
        const Locale('es'),
      );
    });

    test('sin idioma del dispositivo usa inglés', () {
      expect(resolveLocale(null, supported), const Locale('en'));
    });
  });
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/app.dart';
import 'package:vivensia/app/router/app_router.dart';

import '../helpers/pump_app.dart';

void main() {
  group('VivensiaApp', () {
    testWidgets('muestra nombre y eslogan en español', (tester) async {
      await pumpVivensiaApp(tester, locale: const Locale('es', 'DO'));

      expect(find.text('Vivensia'), findsOneWidget);
      expect(find.text('Organiza menos. Vive más.'), findsOneWidget);
    });

    testWidgets('muestra el eslogan en inglés', (tester) async {
      await pumpVivensiaApp(tester, locale: const Locale('en', 'US'));

      expect(find.text('Organize less. Live more.'), findsOneWidget);
    });

    testWidgets('idioma no soportado usa inglés', (tester) async {
      await pumpVivensiaApp(tester, locale: const Locale('fr', 'FR'));

      expect(find.text('Organize less. Live more.'), findsOneWidget);
    });

    testWidgets('ruta inexistente muestra error y permite volver', (
      tester,
    ) async {
      await pumpVivensiaApp(tester);

      final container = ProviderScope.containerOf(
        tester.element(find.byType(VivensiaApp)),
      );
      container.read(appRouterProvider).go('/no-existe');
      await tester.pumpAndSettle();
      expect(find.text('No encontramos esta página'), findsOneWidget);

      await tester.tap(find.text('Ir al inicio'));
      await tester.pumpAndSettle();
      expect(find.text('Organiza menos. Vive más.'), findsOneWidget);
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

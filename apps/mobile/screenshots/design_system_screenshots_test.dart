// Genera capturas reales renderizadas por el motor de Flutter (no emulador).
// No forma parte de `flutter test` por defecto (está fuera de test/).
//
//   flutter test screenshots --update-goldens
//
// Las imágenes se escriben en screenshots/goldens/.
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/app.dart';
import 'package:vivensia/app/config/app_config.dart';
import 'package:vivensia/design_system/design_system.dart';

Future<void> loadFonts() async {
  Future<void> load(String family, List<String> assets) async {
    final loader = FontLoader(family);
    for (final a in assets) {
      loader.addFont(rootBundle.load(a));
    }
    await loader.load();
  }

  await load('Manrope', [
    'assets/fonts/manrope/Manrope-SemiBold.ttf',
    'assets/fonts/manrope/Manrope-Bold.ttf',
    'assets/fonts/manrope/Manrope-ExtraBold.ttf',
  ]);
  await load('Inter', [
    'assets/fonts/inter/Inter-Regular.ttf',
    'assets/fonts/inter/Inter-Medium.ttf',
    'assets/fonts/inter/Inter-SemiBold.ttf',
  ]);
  await load('packages/lucide_icons_flutter/Lucide', [
    'packages/lucide_icons_flutter/assets/lucide.ttf',
  ]);
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<ProviderContainer> pumpApp(
  WidgetTester tester, {
  required Size size,
  required Locale locale,
}) async {
  tester.view.physicalSize = size * 2;
  tester.view.devicePixelRatio = 2;
  tester.platformDispatcher.localesTestValue = [locale];
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  final container = ProviderContainer(
    overrides: [
      appConfigProvider.overrideWithValue(
        const AppConfig(environment: AppEnvironment.development),
      ),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const VivensiaApp()),
  );
  await settle(tester);
  return container;
}

void main() {
  setUpAll(loadFonts);

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('inicio ${mode.name}', (tester) async {
      final c = await pumpApp(
        tester,
        size: const Size(390, 844),
        locale: const Locale('es'),
      );
      c.read(themeModeProvider.notifier).set(mode);
      await settle(tester);
      await expectLater(
        find.byType(VivensiaApp),
        matchesGoldenFile('goldens/home_${mode.name}.png'),
      );
    });

    testWidgets('sistema de diseño ${mode.name}', (tester) async {
      // Alto suficiente para ver la página completa en una sola imagen.
      final c = await pumpApp(
        tester,
        size: const Size(390, 4300),
        locale: const Locale('es'),
      );
      c.read(themeModeProvider.notifier).set(mode);
      await tester.tap(find.text('Ver sistema de diseño'));
      await settle(tester);
      await expectLater(
        find.byType(VivensiaApp),
        matchesGoldenFile('goldens/design_system_${mode.name}.png'),
      );
    });
  }

  testWidgets('sistema de diseño inglés móvil', (tester) async {
    await pumpApp(
      tester,
      size: const Size(390, 844),
      locale: const Locale('en'),
    );
    await tester.tap(find.text('View design system'));
    await settle(tester);
    await expectLater(
      find.byType(VivensiaApp),
      matchesGoldenFile('goldens/design_system_en_viewport.png'),
    );
  });
}

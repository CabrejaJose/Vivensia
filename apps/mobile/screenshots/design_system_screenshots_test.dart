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
import 'package:vivensia/app/router/app_router.dart';
import 'package:vivensia/app/router/app_routes.dart';
import 'package:vivensia/core/utils/clock.dart';
import 'package:vivensia/design_system/design_system.dart';
import 'package:vivensia/features/auth/application/auth_providers.dart';

import '../test/helpers/fake_auth_repository.dart';

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
  bool signedOut = false,
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
      clockProvider.overrideWithValue(() => DateTime(2026, 11, 24, 9)),
      if (signedOut)
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const VivensiaApp()),
  );
  await settle(tester);
  return container;
}

Future<void> shot(
  WidgetTester tester, {
  required String name,
  required String route,
  ThemeMode mode = ThemeMode.light,
  Size size = const Size(390, 844),
  Locale locale = const Locale('es'),
  bool signedOut = false,
}) async {
  final c = await pumpApp(
    tester,
    size: size,
    locale: locale,
    signedOut: signedOut,
  );
  c.read(themeModeProvider.notifier).set(mode);
  c.read(appRouterProvider).go(route);
  await settle(tester);
  await expectLater(
    find.byType(VivensiaApp),
    matchesGoldenFile('goldens/$name.png'),
  );
}

void main() {
  setUpAll(loadFonts);

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    final m = mode.name;
    testWidgets(
      'inicio $m',
      (t) => shot(t, name: 'home_$m', route: AppRoutes.home, mode: mode),
    );
    testWidgets(
      'inicio completo $m',
      (t) => shot(
        t,
        name: 'home_full_$m',
        route: AppRoutes.home,
        mode: mode,
        size: const Size(390, 1400),
      ),
    );
    testWidgets(
      'más $m',
      (t) => shot(
        t,
        name: 'more_$m',
        route: AppRoutes.more,
        mode: mode,
        size: const Size(390, 1250),
      ),
    );
    testWidgets(
      'sistema de diseño $m',
      (t) => shot(
        t,
        name: 'design_system_$m',
        route: AppRoutes.designSystem,
        mode: mode,
        size: const Size(390, 4300),
      ),
    );
  }
  testWidgets(
    'tareas',
    (t) => shot(t, name: 'tasks_light', route: AppRoutes.tasks),
  );
  testWidgets(
    'próximamente',
    (t) => shot(
      t,
      name: 'coming_soon_finances_light',
      route: AppRoutes.module('finances'),
    ),
  );
  testWidgets(
    'inicio inglés',
    (t) => shot(
      t,
      name: 'home_en_light',
      route: AppRoutes.home,
      locale: const Locale('en'),
    ),
  );
  testWidgets(
    'inicio tablet',
    (t) => shot(
      t,
      name: 'home_tablet_light',
      route: AppRoutes.home,
      size: const Size(820, 1180),
    ),
  );
  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    final m = mode.name;
    testWidgets(
      'bienvenida $m',
      (t) => shot(
        t,
        name: 'auth_welcome_$m',
        route: AppRoutes.welcome,
        mode: mode,
        signedOut: true,
      ),
    );
    testWidgets(
      'iniciar sesión $m',
      (t) => shot(
        t,
        name: 'auth_sign_in_$m',
        route: AppRoutes.signIn,
        mode: mode,
        signedOut: true,
      ),
    );
    testWidgets(
      'registro $m',
      (t) => shot(
        t,
        name: 'auth_sign_up_$m',
        route: AppRoutes.signUp,
        mode: mode,
        signedOut: true,
      ),
    );
  }
  testWidgets('iniciar sesión con errores', (t) async {
    final c = await pumpApp(
      t,
      size: const Size(390, 844),
      locale: const Locale('es'),
      signedOut: true,
    );
    c.read(appRouterProvider).go(AppRoutes.signIn);
    await settle(t);
    await t.tap(find.widgetWithText(VivButton, 'Iniciar sesión'));
    await settle(t);
    await expectLater(
      find.byType(VivensiaApp),
      matchesGoldenFile('goldens/auth_sign_in_validation_light.png'),
    );
  });
  testWidgets(
    'recuperar contraseña',
    (t) => shot(
      t,
      name: 'auth_forgot_password_light',
      route: AppRoutes.forgotPassword,
      signedOut: true,
    ),
  );
}

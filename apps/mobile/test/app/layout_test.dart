import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/router/app_router.dart';
import 'package:vivensia/app/router/app_routes.dart';
import 'package:vivensia/design_system/design_system.dart';
import 'package:vivensia/features/auth/domain/entities/auth_user.dart';
import 'package:vivensia/features/profile/application/profile_providers.dart';

import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_profile_repository.dart';
import '../helpers/pump_app.dart';

/// Recorre la pantalla: cualquier desbordamiento hace fallar la prueba.
Future<void> scrollAll(WidgetTester tester) async {
  final scrollables = find.byType(Scrollable);
  if (scrollables.evaluate().isEmpty) return;
  for (var i = 0; i < 15; i++) {
    await tester.drag(scrollables.first, const Offset(0, -400));
    await tester.pump(const Duration(milliseconds: 50));
  }
}

void main() {
  const sizes = [
    ('320×640', Size(320, 640), 1.0),
    ('390×844 texto 1.3×', Size(390, 844), 1.3),
    ('360×780 texto 2×', Size(360, 780), 2.0),
    ('tablet 820×1180', Size(820, 1180), 1.0),
  ];
  const routes = [
    AppRoutes.home,
    AppRoutes.tasks,
    AppRoutes.shopping,
    AppRoutes.agenda,
    AppRoutes.more,
    '/module/finances',
  ];

  for (final (name, size, scale) in sizes) {
    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('sin desbordamientos · $name · ${mode.name}', (tester) async {
        await pumpVivensiaApp(tester, size: size, textScale: scale);
        final container = containerOf(tester);
        container.read(themeModeProvider.notifier).set(mode);
        final router = container.read(appRouterProvider);
        for (final route in routes) {
          router.go(route);
          await settle(tester);
          await scrollAll(tester);
          expect(tester.takeException(), isNull, reason: route);
        }
      });
    }
  }

  const authRoutes = [
    AppRoutes.welcome,
    AppRoutes.signIn,
    AppRoutes.signUp,
    AppRoutes.forgotPassword,
  ];
  for (final (name, size, scale) in sizes) {
    for (final mode in [ThemeMode.light, ThemeMode.dark]) {
      testWidgets('auth sin desbordamientos · $name · ${mode.name}', (
        tester,
      ) async {
        await pumpVivensiaApp(
          tester,
          size: size,
          textScale: scale,
          authRepository: FakeAuthRepository(),
        );
        final container = containerOf(tester);
        container.read(themeModeProvider.notifier).set(mode);
        final router = container.read(appRouterProvider);
        for (final route in authRoutes) {
          router.go(route);
          await settle(tester);
          await scrollAll(tester);
          expect(tester.takeException(), isNull, reason: route);
        }
      });
    }
  }

  for (final (name, size, scale) in sizes) {
    testWidgets('onboarding y perfil sin desbordamientos · $name', (
      tester,
    ) async {
      final profiles = FakeProfileRepository();
      await pumpVivensiaApp(
        tester,
        size: size,
        textScale: scale,
        authRepository: FakeAuthRepository(
          signedInAs: const AuthUser(
            id: 'u',
            email: 'ana.maria.perez@example.com',
          ),
        ),
        profileRepository: profiles,
      );
      await scrollAll(tester);
      expect(tester.takeException(), isNull, reason: 'onboarding');

      profiles.profile = profiles.profile.copyWith(displayName: 'Ana María');
      final container = containerOf(tester);
      container.invalidate(myProfileProvider);
      await settle(tester);
      unawaited(container.read(appRouterProvider).push(AppRoutes.profile));
      await settle(tester);
      await scrollAll(tester);
      expect(tester.takeException(), isNull, reason: 'perfil');
    });
  }
}

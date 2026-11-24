import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/navigation/more_screen.dart';
import 'package:vivensia/app/router/app_router.dart';
import 'package:vivensia/app/router/app_routes.dart';
import 'package:vivensia/design_system/design_system.dart';
import 'package:vivensia/features/auth/domain/entities/auth_user.dart';
import 'package:vivensia/features/profile/domain/entities/user_profile.dart';
import 'package:vivensia/features/profile/domain/repositories/profile_repository.dart';

import '../../helpers/fake_auth_repository.dart';
import '../../helpers/fake_profile_repository.dart';
import '../../helpers/pump_app.dart';

const _ana = AuthUser(id: 'user-1', email: 'ana@example.com');

Future<void> tapButton(WidgetTester tester, String label) async {
  final target = find.widgetWithText(VivButton, label);
  await tester.ensureVisible(target);
  await tester.pump();
  await tester.tap(target);
  await settle(tester);
}

void main() {
  test('UserProfile.isComplete exige nombre no vacío', () {
    expect(const UserProfile(id: 'x', locale: 'es').isComplete, isFalse);
    expect(
      const UserProfile(id: 'x', locale: 'es', displayName: ' ').isComplete,
      isFalse,
    );
    expect(
      const UserProfile(id: 'x', locale: 'es', displayName: 'Ana').isComplete,
      isTrue,
    );
  });

  group('Onboarding', () {
    testWidgets('sin nombre lleva a "¿Cómo te llamamos?" y no deja salir', (
      tester,
    ) async {
      await pumpVivensiaApp(
        tester,
        authRepository: FakeAuthRepository(signedInAs: _ana),
        profileRepository: FakeProfileRepository(),
      );
      expect(find.text('¿Cómo te llamamos?'), findsOneWidget);
      containerOf(tester).read(appRouterProvider).go(AppRoutes.tasks);
      await settle(tester);
      expect(find.text('¿Cómo te llamamos?'), findsOneWidget);
    });

    testWidgets('guarda nombre e idioma y entra con saludo personalizado', (
      tester,
    ) async {
      final profiles = FakeProfileRepository();
      await pumpVivensiaApp(
        tester,
        authRepository: FakeAuthRepository(signedInAs: _ana),
        profileRepository: profiles,
      );
      await tapButton(tester, 'Continuar');
      expect(find.text('Introduce tu nombre'), findsOneWidget);
      expect(profiles.updates, isEmpty);

      await tester.enterText(find.byType(TextFormField), '  Ana  ');
      await tapButton(tester, 'Continuar');
      expect(profiles.updates.single, {'displayName': 'Ana', 'locale': 'es'});
      expect(find.text('Buenos días, Ana'), findsOneWidget);
    });

    testWidgets('elegir English cambia el idioma de la app', (tester) async {
      await pumpVivensiaApp(
        tester,
        authRepository: FakeAuthRepository(signedInAs: _ana),
        profileRepository: FakeProfileRepository(),
      );
      await tester.enterText(find.byType(TextFormField), 'Ana');
      await tester.tap(find.text('English'));
      await settle(tester);
      await tapButton(tester, 'Continuar');
      expect(find.text('Good morning, Ana'), findsOneWidget);
    });

    testWidgets('si falla el guardado lo indica y permite reintentar', (
      tester,
    ) async {
      final profiles = FakeProfileRepository()
        ..nextFailure = ProfileFailure.network;
      await pumpVivensiaApp(
        tester,
        authRepository: FakeAuthRepository(signedInAs: _ana),
        profileRepository: profiles,
      );
      await tester.enterText(find.byType(TextFormField), 'Ana');
      await tapButton(tester, 'Continuar');
      expect(
        find.text(
          'No pudimos guardar los cambios. Revisa tu conexión e inténtalo de nuevo.',
        ),
        findsOneWidget,
      );
      await tapButton(tester, 'Continuar');
      expect(find.text('Buenos días, Ana'), findsOneWidget);
    });
  });

  group('Mi perfil', () {
    Future<FakeProfileRepository> openProfile(WidgetTester tester) async {
      final profiles = FakeProfileRepository(displayName: 'Ana');
      await pumpVivensiaApp(
        tester,
        authRepository: FakeAuthRepository(signedInAs: _ana),
        profileRepository: profiles,
      );
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Más'),
        ),
      );
      await settle(tester);
      await tapInScreen<MoreScreen>(tester, 'Ana');
      return profiles;
    }

    testWidgets('con nombre completo entra directo y saluda por el nombre', (
      tester,
    ) async {
      await pumpVivensiaApp(
        tester,
        authRepository: FakeAuthRepository(signedInAs: _ana),
        profileRepository: FakeProfileRepository(displayName: 'Ana'),
      );
      expect(find.text('Buenos días, Ana'), findsOneWidget);
    });

    testWidgets('Más muestra nombre y email y abre el perfil', (tester) async {
      await openProfile(tester);
      expect(find.text('Mi perfil'), findsOneWidget);
      expect(find.text('ana@example.com'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Ana'), findsOneWidget);
    });

    testWidgets('editar nombre e idioma guarda y aplica el idioma', (
      tester,
    ) async {
      final profiles = await openProfile(tester);
      await tester.enterText(find.byType(TextFormField), 'Ana María');
      await tester.tap(find.text('English'));
      await settle(tester);
      await tapButton(tester, 'Guardar cambios');
      expect(profiles.updates.single, {
        'displayName': 'Ana María',
        'locale': 'en',
      });
      expect(find.text('Profile updated.'), findsOneWidget);
      expect(find.text('My profile'), findsOneWidget);
    });

    testWidgets('no permite guardar un nombre vacío', (tester) async {
      final profiles = await openProfile(tester);
      await tester.enterText(find.byType(TextFormField), '   ');
      await tapButton(tester, 'Guardar cambios');
      expect(find.text('Introduce tu nombre'), findsOneWidget);
      expect(profiles.updates, isEmpty);
    });
  });
}

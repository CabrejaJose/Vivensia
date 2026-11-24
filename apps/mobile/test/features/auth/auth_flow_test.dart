import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:vivensia/app/navigation/more_screen.dart';
import 'package:vivensia/app/router/app_router.dart';
import 'package:vivensia/design_system/design_system.dart';
import 'package:vivensia/features/auth/domain/auth_failure.dart';
import 'package:vivensia/features/auth/domain/entities/auth_user.dart';

import '../../helpers/fake_auth_repository.dart';
import '../../helpers/pump_app.dart';

Finder field(String label) => find.widgetWithText(TextFormField, label);

Future<void> tapButton(WidgetTester tester, String label) async {
  final target = find.widgetWithText(VivButton, label);
  await tester.ensureVisible(target);
  await tester.pump();
  await tester.tap(target);
  await settle(tester);
}

void main() {
  group('Guardia de rutas', () {
    testWidgets('sin sesión arranca en Bienvenida', (tester) async {
      await pumpVivensiaApp(tester, authRepository: FakeAuthRepository());
      expect(find.text('Tu hogar, en armonía'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('sin sesión no se puede abrir la app por URL', (tester) async {
      await pumpVivensiaApp(tester, authRepository: FakeAuthRepository());
      containerOf(tester).read(appRouterProvider).go('/tasks');
      await settle(tester);
      expect(find.text('Tu hogar, en armonía'), findsOneWidget);
    });

    testWidgets('con sesión restaurada arranca en Inicio', (tester) async {
      await pumpVivensiaApp(
        tester,
        authRepository: FakeAuthRepository(
          signedInAs: const AuthUser(id: 'u', email: 'ana@example.com'),
        ),
      );
      expect(find.text('Buenos días'), findsOneWidget);
    });

    testWidgets('en modo demo no hay pantallas de auth', (tester) async {
      await pumpVivensiaApp(tester);
      containerOf(tester).read(appRouterProvider).go('/sign-in');
      await settle(tester);
      expect(find.text('Buenos días'), findsOneWidget);
    });
  });

  group('Inicio de sesión', () {
    Future<FakeAuthRepository> openSignIn(WidgetTester tester) async {
      final repo = FakeAuthRepository();
      await pumpVivensiaApp(tester, authRepository: repo);
      await tapButton(tester, 'Ya tengo cuenta');
      return repo;
    }

    testWidgets('valida los campos antes de enviar', (tester) async {
      final repo = await openSignIn(tester);
      await tapButton(tester, 'Iniciar sesión');
      expect(find.text('Introduce tu correo electrónico'), findsOneWidget);
      expect(find.text('Introduce tu contraseña'), findsOneWidget);
      expect(repo.calls, isEmpty);
    });

    testWidgets('credenciales incorrectas muestran un error claro', (
      tester,
    ) async {
      final repo = await openSignIn(tester)
        ..nextFailure = AuthFailure.invalidCredentials;
      await tester.enterText(field('Correo electrónico'), 'ana@example.com');
      await tester.enterText(field('Contraseña'), 'mala');
      await tapButton(tester, 'Iniciar sesión');
      expect(find.text('Correo o contraseña incorrectos.'), findsOneWidget);
      expect(repo.calls, ['signIn']);
    });

    testWidgets('mientras carga no se puede reenviar', (tester) async {
      final repo = await openSignIn(tester)
        ..gate = Completer<void>();
      await tester.enterText(field('Correo electrónico'), 'ana@example.com');
      await tester.enterText(field('Contraseña'), 'casa2026');
      await tapButton(tester, 'Iniciar sesión');
      expect(find.text('Iniciando sesión…'), findsOneWidget);
      await tester.tap(find.text('Iniciando sesión…'));
      await tester.pump();
      expect(repo.calls, ['signIn']);
      repo.gate!.complete();
      await settle(tester);
    });

    testWidgets('éxito: normaliza el email y entra en Inicio', (tester) async {
      final repo = await openSignIn(tester);
      await tester.enterText(field('Correo electrónico'), '  Ana@Example.COM ');
      await tester.enterText(field('Contraseña'), 'casa2026');
      await tapButton(tester, 'Iniciar sesión');
      expect(repo.lastEmail, 'ana@example.com');
      expect(find.text('Buenos días'), findsOneWidget);
    });
  });

  group('Registro', () {
    Future<FakeAuthRepository> openSignUp(WidgetTester tester) async {
      final repo = FakeAuthRepository();
      await pumpVivensiaApp(tester, authRepository: repo);
      await tapButton(tester, 'Crear cuenta');
      return repo;
    }

    Future<void> fill(
      WidgetTester tester, {
      String password = 'casa2026',
    }) async {
      await tester.enterText(field('Tu nombre'), ' Ana ');
      await tester.enterText(field('Correo electrónico'), 'ana@example.com');
      await tester.enterText(field('Contraseña'), password);
    }

    testWidgets('aplica la política de contraseña en el cliente', (
      tester,
    ) async {
      final repo = await openSignUp(tester);
      await fill(tester, password: 'abcdefgh');
      await tapButton(tester, 'Crear cuenta');
      expect(find.text('Debe incluir al menos un número'), findsOneWidget);
      expect(repo.calls, isEmpty);
    });

    testWidgets('con confirmación de email muestra "Revisa tu correo"', (
      tester,
    ) async {
      final repo = await openSignUp(tester);
      await fill(tester);
      await tapButton(tester, 'Crear cuenta');
      expect(find.text('Revisa tu correo'), findsOneWidget);
      expect(repo.lastSignUp, {
        'email': 'ana@example.com',
        'displayName': 'Ana',
        'locale': 'es',
      });
    });

    testWidgets('sin confirmación entra directamente en Inicio', (
      tester,
    ) async {
      final repo = await openSignUp(tester);
      repo.signUpOutcome = SignUpOutcome.signedIn;
      await fill(tester);
      await tapButton(tester, 'Crear cuenta');
      expect(find.text('Buenos días'), findsOneWidget);
    });

    testWidgets('error del servidor se muestra localizado', (tester) async {
      final repo = await openSignUp(tester)
        ..nextFailure = AuthFailure.rateLimited;
      await fill(tester);
      await tapButton(tester, 'Crear cuenta');
      expect(
        find.text(
          'Demasiados intentos. Espera unos minutos e inténtalo de nuevo.',
        ),
        findsOneWidget,
      );
      expect(repo.calls, ['signUp']);
    });
  });

  group('Recuperar contraseña', () {
    testWidgets('confirma sin revelar si la cuenta existe', (tester) async {
      final repo = FakeAuthRepository();
      await pumpVivensiaApp(tester, authRepository: repo);
      await tapButton(tester, 'Ya tengo cuenta');
      await tapButton(tester, '¿Olvidaste tu contraseña?');
      await tester.enterText(field('Correo electrónico'), 'Nadie@Example.com');
      await tapButton(tester, 'Enviar enlace');
      expect(repo.lastEmail, 'nadie@example.com');
      expect(
        find.text(
          'Si existe una cuenta con ese correo, recibirás un enlace en unos minutos.',
        ),
        findsOneWidget,
      );
    });
  });

  group('Cuenta en Más', () {
    testWidgets('muestra el email y cierra sesión tras confirmar', (
      tester,
    ) async {
      final repo = FakeAuthRepository(
        signedInAs: const AuthUser(id: 'u', email: 'ana@example.com'),
      );
      await pumpVivensiaApp(tester, authRepository: repo);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Más'),
        ),
      );
      await settle(tester);
      expect(find.text('ana@example.com'), findsOneWidget);

      await tapInScreen<MoreScreen>(tester, 'Cerrar sesión');
      expect(find.text('¿Cerrar sesión?'), findsOneWidget);
      await tester.tap(find.widgetWithText(VivButton, 'Cerrar sesión'));
      await settle(tester);
      expect(repo.calls, ['signOut']);
      expect(find.text('Tu hogar, en armonía'), findsOneWidget);
    });

    testWidgets('en modo demo lo indica claramente', (tester) async {
      await pumpVivensiaApp(tester);
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text('Más'),
        ),
      );
      await settle(tester);
      expect(find.text('Modo demostración'), findsOneWidget);
    });
  });
}

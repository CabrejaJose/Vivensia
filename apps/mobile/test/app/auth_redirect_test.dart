import 'package:flutter_test/flutter_test.dart';
import 'package:vivensia/app/router/app_routes.dart';
import 'package:vivensia/app/router/auth_redirect.dart';
import 'package:vivensia/features/auth/domain/auth_status.dart';
import 'package:vivensia/features/auth/domain/entities/auth_user.dart';

void main() {
  const signedIn = AuthSignedIn(AuthUser(id: 'u'));
  const signedOut = AuthSignedOut();
  const demo = AuthDemo();

  test('cargando: todo va a la pantalla de carga', () {
    expect(authRedirect(null, AppRoutes.home), AppRoutes.splash);
    expect(authRedirect(null, AppRoutes.signIn), AppRoutes.splash);
    expect(authRedirect(null, AppRoutes.splash), isNull);
  });

  test('sin sesión: solo rutas de auth', () {
    for (final r in AppRoutes.authRoutes) {
      expect(authRedirect(signedOut, r), isNull, reason: r);
    }
    for (final r in [
      AppRoutes.home,
      AppRoutes.more,
      '/module/finances',
      AppRoutes.splash,
    ]) {
      expect(authRedirect(signedOut, r), AppRoutes.welcome, reason: r);
    }
  });

  test('con sesión o en demo: la app, nunca las rutas de auth', () {
    for (final status in [signedIn, demo]) {
      expect(authRedirect(status, AppRoutes.home), isNull);
      expect(authRedirect(status, AppRoutes.tasks), isNull);
      expect(authRedirect(status, AppRoutes.splash), AppRoutes.home);
      for (final r in AppRoutes.authRoutes) {
        expect(authRedirect(status, r), AppRoutes.home, reason: r);
      }
    }
  });
}

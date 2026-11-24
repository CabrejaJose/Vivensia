import '../../features/auth/domain/auth_status.dart';
import 'app_routes.dart';

/// Decide la redirección según el estado de autenticación.
///
/// - Cargando → pantalla de carga.
/// - Demo (sin backend) → la app sin rutas de auth.
/// - Sin sesión → solo rutas de auth.
/// - Con sesión → la app; las rutas de auth llevan a Inicio.
String? authRedirect(AuthStatus? status, String location) {
  final isAuthRoute = AppRoutes.authRoutes.contains(location);
  final isSplash = location == AppRoutes.splash;

  return switch (status) {
    null => isSplash ? null : AppRoutes.splash,
    AuthDemo() ||
    AuthSignedIn() => isAuthRoute || isSplash ? AppRoutes.home : null,
    AuthSignedOut() => isAuthRoute ? null : AppRoutes.welcome,
  };
}

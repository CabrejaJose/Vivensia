import '../../features/auth/domain/auth_status.dart';
import 'app_routes.dart';

/// Estado del perfil para la guardia (solo relevante con sesión).
enum ProfileGate { loading, incomplete, ready }

/// Decide la redirección según la sesión y el perfil.
///
/// - Cargando sesión → pantalla de carga.
/// - Demo (sin backend) → la app sin rutas de auth ni onboarding.
/// - Sin sesión → solo rutas de auth.
/// - Con sesión: perfil cargando → carga; sin nombre → onboarding;
///   completo → la app.
String? authRedirect(
  AuthStatus? status,
  String location, {
  ProfileGate profile = ProfileGate.ready,
}) {
  final isAuthRoute = AppRoutes.authRoutes.contains(location);
  final isSplash = location == AppRoutes.splash;
  final isOnboarding = location == AppRoutes.onboarding;
  final leavesApp = isAuthRoute || isSplash || isOnboarding;

  switch (status) {
    case null:
      return isSplash ? null : AppRoutes.splash;
    case AuthDemo():
      // En demo no hay cuenta: tampoco pantalla de perfil.
      return leavesApp || location == AppRoutes.profile ? AppRoutes.home : null;
    case AuthSignedOut():
      return isAuthRoute ? null : AppRoutes.welcome;
    case AuthSignedIn():
      return switch (profile) {
        ProfileGate.loading => isSplash ? null : AppRoutes.splash,
        ProfileGate.incomplete => isOnboarding ? null : AppRoutes.onboarding,
        ProfileGate.ready => leavesApp ? AppRoutes.home : null,
      };
  }
}

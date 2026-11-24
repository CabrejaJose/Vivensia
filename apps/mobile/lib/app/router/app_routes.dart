/// Rutas de la app. Centralizadas para evitar strings dispersos.
abstract final class AppRoutes {
  // Pestañas de la barra inferior.
  static const home = '/';
  static const tasks = '/tasks';
  static const shopping = '/shopping';
  static const agenda = '/agenda';
  static const more = '/more';

  /// Pantalla de una función (por ahora, "Próximamente").
  static const modulePattern = '/module/:id';
  static String module(String id) => '/module/$id';

  // Autenticación.
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const forgotPassword = '/forgot-password';

  static const onboarding = '/onboarding';
  static const profile = '/profile';

  /// Rutas accesibles sin sesión.
  static const authRoutes = {welcome, signIn, signUp, forgotPassword};

  /// Solo en builds de desarrollo.
  static const designSystem = '/dev/design-system';
}

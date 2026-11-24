import 'entities/auth_user.dart';

/// Estado de autenticación de la app.
sealed class AuthStatus {
  const AuthStatus();
}

/// Sin backend configurado: la app funciona con datos de ejemplo.
final class AuthDemo extends AuthStatus {
  const AuthDemo();
}

final class AuthSignedOut extends AuthStatus {
  const AuthSignedOut();
}

final class AuthSignedIn extends AuthStatus {
  const AuthSignedIn(this.user);

  final AuthUser user;
}

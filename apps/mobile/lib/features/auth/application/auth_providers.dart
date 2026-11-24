import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/auth_failure.dart';
import '../domain/auth_status.dart';
import '../domain/auth_validators.dart';
import '../domain/repositories/auth_repository.dart';

/// Repositorio de auth. `null` en modo demostración (sin backend).
/// Se sobrescribe en `bootstrap()` cuando hay backend.
final authRepositoryProvider = Provider<AuthRepository?>((ref) => null);

/// Estado de autenticación reactivo.
final authStatusProvider = StreamProvider<AuthStatus>((ref) async* {
  final repository = ref.watch(authRepositoryProvider);
  if (repository == null) {
    yield const AuthDemo();
    return;
  }
  final current = repository.currentUser;
  yield current == null ? const AuthSignedOut() : AuthSignedIn(current);
  yield* repository.userChanges().map(
    (user) => user == null ? const AuthSignedOut() : AuthSignedIn(user),
  );
});

/// Casos de uso de autenticación. Normalizan la entrada antes de llamar
/// al repositorio. Lanzan [AuthFailure].
class AuthActions {
  const AuthActions(this._repository);

  final AuthRepository _repository;

  Future<void> signIn({required String email, required String password}) =>
      _repository.signInWithEmail(
        email: normalizeEmail(email),
        password: password,
      );

  Future<SignUpOutcome> signUp({
    required String email,
    required String password,
    required String displayName,
    required String locale,
  }) => _repository.signUpWithEmail(
    email: normalizeEmail(email),
    password: password,
    displayName: displayName.trim(),
    locale: locale,
  );

  Future<void> sendPasswordReset({required String email}) =>
      _repository.sendPasswordReset(email: normalizeEmail(email));

  Future<void> signOut() => _repository.signOut();
}

/// Solo disponible con backend (las pantallas de auth no existen en demo).
final authActionsProvider = Provider<AuthActions>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  if (repository == null) {
    throw StateError('Autenticación no disponible en modo demostración');
  }
  return AuthActions(repository);
});

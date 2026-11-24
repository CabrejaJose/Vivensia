import '../auth_failure.dart';
import '../entities/auth_user.dart';

/// Contrato de autenticación. Los métodos lanzan [AuthFailure].
abstract interface class AuthRepository {
  /// Usuario actual y sus cambios (null = sin sesión).
  Stream<AuthUser?> userChanges();

  AuthUser? get currentUser;

  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

  Future<SignUpOutcome> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    required String locale,
  });

  /// Siempre termina sin revelar si el email existe.
  Future<void> sendPasswordReset({required String email});

  Future<void> signOut();
}

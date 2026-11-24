import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../domain/auth_failure.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../auth_error_mapper.dart';

/// Implementación con Supabase Auth.
class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._auth);

  final GoTrueClient _auth;

  static AuthUser? _toUser(User? user) =>
      user == null ? null : AuthUser(id: user.id, email: user.email);

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (error) {
      throw mapAuthError(error);
    }
  }

  @override
  Stream<AuthUser?> userChanges() =>
      _auth.onAuthStateChange.map((state) => _toUser(state.session?.user));

  @override
  AuthUser? get currentUser => _toUser(_auth.currentUser);

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) =>
      _guard(() => _auth.signInWithPassword(email: email, password: password));

  @override
  Future<SignUpOutcome> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    required String locale,
  }) => _guard(() async {
    final response = await _auth.signUp(
      email: email,
      password: password,
      data: {'display_name': displayName, 'locale': locale},
    );
    // Con confirmación activada no hay sesión (y, si el email ya existe,
    // Supabase responde igual para no revelarlo).
    return response.session == null
        ? SignUpOutcome.confirmationRequired
        : SignUpOutcome.signedIn;
  });

  @override
  Future<void> sendPasswordReset({required String email}) async {
    try {
      await _auth.resetPasswordForEmail(email);
    } catch (error) {
      final failure = mapAuthError(error);
      // Solo se informan errores que no revelan si la cuenta existe.
      if (failure == AuthFailure.network ||
          failure == AuthFailure.rateLimited) {
        throw failure;
      }
    }
  }

  @override
  Future<void> signOut() => _guard(() => _auth.signOut());
}

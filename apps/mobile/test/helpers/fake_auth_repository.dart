import 'dart:async';

import 'package:vivensia/features/auth/domain/auth_failure.dart';
import 'package:vivensia/features/auth/domain/entities/auth_user.dart';
import 'package:vivensia/features/auth/domain/repositories/auth_repository.dart';

/// Repositorio de auth en memoria y controlable para pruebas.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({AuthUser? signedInAs}) : _user = signedInAs;

  final _changes = StreamController<AuthUser?>.broadcast();
  AuthUser? _user;

  /// Si se define, la próxima operación lanza este fallo.
  AuthFailure? nextFailure;

  /// Resultado de los registros.
  SignUpOutcome signUpOutcome = SignUpOutcome.confirmationRequired;

  /// Si se define, las operaciones esperan a que se complete (estado de carga).
  Completer<void>? gate;

  final List<String> calls = [];
  Map<String, String>? lastSignUp;
  String? lastEmail;

  Future<void> _step(String name) async {
    calls.add(name);
    await gate?.future;
    final failure = nextFailure;
    if (failure != null) {
      nextFailure = null;
      throw failure;
    }
  }

  void _emit(AuthUser? user) {
    _user = user;
    _changes.add(user);
  }

  @override
  Stream<AuthUser?> userChanges() => _changes.stream;

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    lastEmail = email;
    await _step('signIn');
    _emit(AuthUser(id: 'user-1', email: email));
  }

  @override
  Future<SignUpOutcome> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    required String locale,
  }) async {
    lastSignUp = {'email': email, 'displayName': displayName, 'locale': locale};
    await _step('signUp');
    if (signUpOutcome == SignUpOutcome.signedIn) {
      _emit(AuthUser(id: 'user-2', email: email));
    }
    return signUpOutcome;
  }

  @override
  Future<void> sendPasswordReset({required String email}) async {
    lastEmail = email;
    await _step('reset');
  }

  @override
  Future<void> signOut() async {
    await _step('signOut');
    _emit(null);
  }
}

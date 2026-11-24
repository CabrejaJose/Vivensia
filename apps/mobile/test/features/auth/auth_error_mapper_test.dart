import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vivensia/features/auth/data/auth_error_mapper.dart';
import 'package:vivensia/features/auth/domain/auth_failure.dart';

void main() {
  test('códigos de Supabase Auth', () {
    const cases = {
      'invalid_credentials': AuthFailure.invalidCredentials,
      'email_not_confirmed': AuthFailure.emailNotConfirmed,
      'user_already_exists': AuthFailure.emailAlreadyInUse,
      'email_exists': AuthFailure.emailAlreadyInUse,
      'weak_password': AuthFailure.weakPassword,
      'email_address_invalid': AuthFailure.invalidEmail,
      'over_request_rate_limit': AuthFailure.rateLimited,
      'over_email_send_rate_limit': AuthFailure.rateLimited,
      'signup_disabled': AuthFailure.signupDisabled,
      'algo_nuevo': AuthFailure.unexpected,
    };
    cases.forEach((code, failure) {
      expect(
        mapAuthError(AuthException('x', code: code)),
        failure,
        reason: code,
      );
    });
  });

  test('HTTP 429 sin código es límite de intentos', () {
    expect(
      mapAuthError(const AuthException('x', statusCode: '429')),
      AuthFailure.rateLimited,
    );
  });

  test('errores de red', () {
    expect(mapAuthError(const SocketException('x')), AuthFailure.network);
    expect(mapAuthError(TimeoutException('x')), AuthFailure.network);
    expect(
      mapAuthError(AuthRetryableFetchException(message: 'x')),
      AuthFailure.network,
    );
  });

  test('cualquier otra cosa es inesperado (sin filtrar detalles)', () {
    expect(mapAuthError(StateError('x')), AuthFailure.unexpected);
    expect(mapAuthError(AuthFailure.weakPassword), AuthFailure.weakPassword);
  });
}

import 'dart:async';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/auth_failure.dart';

/// Traduce errores de Supabase Auth / red a [AuthFailure].
/// Códigos: https://supabase.com/docs/guides/auth/debugging/error-codes
AuthFailure mapAuthError(Object error) {
  if (error is AuthFailure) return error;
  if (error is AuthRetryableFetchException ||
      error is SocketException ||
      error is TimeoutException) {
    return AuthFailure.network;
  }
  if (error is AuthException) {
    switch (error.code) {
      case 'invalid_credentials':
        return AuthFailure.invalidCredentials;
      case 'email_not_confirmed':
        return AuthFailure.emailNotConfirmed;
      case 'user_already_exists':
      case 'email_exists':
        return AuthFailure.emailAlreadyInUse;
      case 'weak_password':
        return AuthFailure.weakPassword;
      case 'email_address_invalid':
      case 'validation_failed':
        return AuthFailure.invalidEmail;
      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
        return AuthFailure.rateLimited;
      case 'signup_disabled':
      case 'email_provider_disabled':
        return AuthFailure.signupDisabled;
    }
    if (error.statusCode == '429') return AuthFailure.rateLimited;
  }
  return AuthFailure.unexpected;
}

import '../../../l10n/app_localizations.dart';
import '../domain/auth_failure.dart';
import '../domain/auth_validators.dart';

/// Textos localizados para errores de autenticación y validación.
extension AuthMessages on AppLocalizations {
  String authFailure(AuthFailure failure) => switch (failure) {
    AuthFailure.invalidCredentials => authErrorInvalidCredentials,
    AuthFailure.emailNotConfirmed => authErrorEmailNotConfirmed,
    AuthFailure.emailAlreadyInUse => authErrorEmailInUse,
    AuthFailure.weakPassword => authErrorWeakPassword,
    AuthFailure.invalidEmail => authErrorInvalidEmail,
    AuthFailure.rateLimited => authErrorRateLimited,
    AuthFailure.signupDisabled => authErrorSignupDisabled,
    AuthFailure.network => authErrorNetwork,
    AuthFailure.unexpected => authErrorUnexpected,
  };

  String? emailError(EmailError? error) => switch (error) {
    null => null,
    EmailError.empty => errorEmailRequired,
    EmailError.invalid => errorEmailInvalid,
  };

  String? passwordError(PasswordError? error) => switch (error) {
    null => null,
    PasswordError.empty => errorPasswordRequired,
    PasswordError.tooShort => errorPasswordTooShort(minPasswordLength),
    PasswordError.missingLetter => errorPasswordNeedsLetter,
    PasswordError.missingDigit => errorPasswordNeedsDigit,
  };

  String? displayNameError(DisplayNameError? error) => switch (error) {
    null => null,
    DisplayNameError.empty => errorNameRequired,
    DisplayNameError.tooLong => errorNameTooLong(maxDisplayNameLength),
  };
}

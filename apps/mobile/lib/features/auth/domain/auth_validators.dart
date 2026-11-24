/// Validaciones de formularios de autenticación (puras, sin Flutter).
///
/// Coinciden con la política del servidor (`supabase/config.toml`):
/// contraseña de 8 caracteres o más con letras y dígitos.
enum EmailError { empty, invalid }

enum PasswordError { empty, tooShort, missingLetter, missingDigit }

enum DisplayNameError { empty, tooLong }

const int minPasswordLength = 8;
const int maxDisplayNameLength = 80;

final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');
final _letter = RegExp(r'\p{L}', unicode: true);
final _digit = RegExp(r'\d');

String normalizeEmail(String value) => value.trim().toLowerCase();

EmailError? validateEmail(String value) {
  final v = value.trim();
  if (v.isEmpty) return EmailError.empty;
  if (v.length > 254 || !_emailPattern.hasMatch(v)) return EmailError.invalid;
  return null;
}

/// Para iniciar sesión solo se exige que no esté vacía.
PasswordError? validatePasswordPresent(String value) =>
    value.isEmpty ? PasswordError.empty : null;

PasswordError? validateNewPassword(String value) {
  if (value.isEmpty) return PasswordError.empty;
  if (value.length < minPasswordLength) return PasswordError.tooShort;
  if (!_letter.hasMatch(value)) return PasswordError.missingLetter;
  if (!_digit.hasMatch(value)) return PasswordError.missingDigit;
  return null;
}

DisplayNameError? validateDisplayName(String value) {
  final v = value.trim();
  if (v.isEmpty) return DisplayNameError.empty;
  if (v.length > maxDisplayNameLength) return DisplayNameError.tooLong;
  return null;
}

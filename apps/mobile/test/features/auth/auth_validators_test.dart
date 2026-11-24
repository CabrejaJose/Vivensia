import 'package:flutter_test/flutter_test.dart';
import 'package:vivensia/features/auth/domain/auth_validators.dart';

void main() {
  group('validateEmail', () {
    test('vacío e inválidos', () {
      expect(validateEmail('   '), EmailError.empty);
      for (final v in [
        'ana',
        'ana@',
        '@x.com',
        'ana@x',
        'a b@x.com',
        'ana@x.c',
      ]) {
        expect(validateEmail(v), EmailError.invalid, reason: v);
      }
    });

    test('válidos (con espacios alrededor)', () {
      for (final v in ['ana@example.com', ' Ana.Perez+casa@sub.example.do ']) {
        expect(validateEmail(v), isNull, reason: v);
      }
    });

    test('normalizeEmail recorta y pasa a minúsculas', () {
      expect(normalizeEmail('  Ana@Example.COM '), 'ana@example.com');
    });
  });

  group('validateNewPassword (política del servidor)', () {
    test('reglas', () {
      expect(validateNewPassword(''), PasswordError.empty);
      expect(validateNewPassword('abc123'), PasswordError.tooShort);
      expect(validateNewPassword('12345678'), PasswordError.missingLetter);
      expect(validateNewPassword('abcdefgh'), PasswordError.missingDigit);
      expect(validateNewPassword('casa2026'), isNull);
      expect(
        validateNewPassword('añoNuevo9'),
        isNull,
        reason: 'letras Unicode',
      );
    });

    test('para iniciar sesión solo se exige que no esté vacía', () {
      expect(validatePasswordPresent(''), PasswordError.empty);
      expect(validatePasswordPresent('x'), isNull);
    });
  });

  group('validateDisplayName', () {
    test('reglas', () {
      expect(validateDisplayName('  '), DisplayNameError.empty);
      expect(validateDisplayName('a' * 81), DisplayNameError.tooLong);
      expect(validateDisplayName(' Ana '), isNull);
    });
  });
}

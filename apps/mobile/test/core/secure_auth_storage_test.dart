import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vivensia/core/security/secure_auth_storage.dart';

void main() {
  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test(
    'la sesión se guarda, se lee y se elimina en almacenamiento seguro',
    () async {
      const storage = SecureSessionStorage();
      expect(await storage.hasAccessToken(), isFalse);

      await storage.persistSession('{"access_token":"t"}');
      expect(await storage.hasAccessToken(), isTrue);
      expect(await storage.accessToken(), '{"access_token":"t"}');
      expect(
        await vivensiaSecureStorage.read(key: SecureSessionStorage.sessionKey),
        '{"access_token":"t"}',
      );

      await storage.removePersistedSession();
      expect(await storage.hasAccessToken(), isFalse);
    },
  );

  test('el verificador PKCE usa un espacio de claves propio', () async {
    const storage = SecurePkceStorage();
    await storage.setItem(key: 'code-verifier', value: 'v');
    expect(await storage.getItem(key: 'code-verifier'), 'v');
    expect(
      await vivensiaSecureStorage.read(
        key: '${SecurePkceStorage.prefix}code-verifier',
      ),
      'v',
    );
    await storage.removeItem(key: 'code-verifier');
    expect(await storage.getItem(key: 'code-verifier'), isNull);
  });
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Almacenamiento cifrado del sistema: Keychain (iOS) / Keystore (Android).
///
/// `first_unlock_this_device`: permite refrescar la sesión en segundo plano
/// tras el primer desbloqueo y no migra a otros dispositivos en copias.
const FlutterSecureStorage vivensiaSecureStorage = FlutterSecureStorage(
  iOptions: IOSOptions(
    accessibility: KeychainAccessibility.first_unlock_this_device,
  ),
);

/// Persiste la sesión de Supabase Auth en almacenamiento seguro en lugar de
/// `SharedPreferences` (que no está cifrado).
class SecureSessionStorage extends LocalStorage {
  const SecureSessionStorage({this.storage = vivensiaSecureStorage});

  final FlutterSecureStorage storage;

  static const sessionKey = 'vivensia.auth.session';

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasAccessToken() => storage.containsKey(key: sessionKey);

  @override
  Future<String?> accessToken() => storage.read(key: sessionKey);

  @override
  Future<void> removePersistedSession() => storage.delete(key: sessionKey);

  @override
  Future<void> persistSession(String persistSessionString) =>
      storage.write(key: sessionKey, value: persistSessionString);
}

/// Guarda el verificador PKCE (flujos de confirmación y recuperación) en
/// almacenamiento seguro.
class SecurePkceStorage extends GotrueAsyncStorage {
  const SecurePkceStorage({this.storage = vivensiaSecureStorage});

  final FlutterSecureStorage storage;

  static const prefix = 'vivensia.auth.pkce.';

  @override
  Future<String?> getItem({required String key}) =>
      storage.read(key: '$prefix$key');

  @override
  Future<void> setItem({required String key, required String value}) =>
      storage.write(key: '$prefix$key', value: value);

  @override
  Future<void> removeItem({required String key}) =>
      storage.delete(key: '$prefix$key');
}

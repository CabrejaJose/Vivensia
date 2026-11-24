import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../../auth/domain/auth_status.dart';
import '../domain/entities/user_profile.dart';
import '../domain/repositories/profile_repository.dart';

/// `null` en modo demostración. Se sobrescribe en `bootstrap()`.
final profileRepositoryProvider = Provider<ProfileRepository?>((ref) => null);

/// Perfil del usuario con sesión; `null` sin sesión o en modo demo.
final myProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final status = await ref.watch(authStatusProvider.future);
  final repository = ref.watch(profileRepositoryProvider);
  if (status is! AuthSignedIn || repository == null) return null;
  return repository.fetchMyProfile();
}, retry: (retryCount, error) => null);

/// Casos de uso del perfil.
class ProfileActions {
  ProfileActions(this._ref, this._repository);

  final Ref _ref;
  final ProfileRepository _repository;

  Future<UserProfile> update({String? displayName, String? locale}) async {
    if (locale != null && !supportedLanguageCodes.contains(locale)) {
      throw ArgumentError.value(locale, 'locale');
    }
    final updated = await _repository.updateMyProfile(
      displayName: displayName?.trim(),
      locale: locale,
    );
    _ref.invalidate(myProfileProvider);
    return updated;
  }
}

final profileActionsProvider = Provider<ProfileActions>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  if (repository == null) {
    throw StateError('Perfil no disponible en modo demostración');
  }
  return ProfileActions(ref, repository);
});

/// Idioma preferido del usuario con sesión (null = idioma del dispositivo).
final preferredLocaleCodeProvider = Provider<String?>(
  (ref) => ref.watch(myProfileProvider).value?.locale,
);

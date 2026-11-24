import 'dart:async';

import 'package:vivensia/features/profile/domain/entities/user_profile.dart';
import 'package:vivensia/features/profile/domain/repositories/profile_repository.dart';

/// Repositorio de perfil en memoria para pruebas.
class FakeProfileRepository implements ProfileRepository {
  FakeProfileRepository({String? displayName, String locale = 'es'})
    : profile = UserProfile(
        id: 'user-1',
        displayName: displayName,
        locale: locale,
      );

  UserProfile profile;
  ProfileFailure? nextFailure;
  int fetchCount = 0;
  final List<Map<String, String?>> updates = [];

  @override
  Future<UserProfile> fetchMyProfile() async {
    fetchCount++;
    return profile;
  }

  @override
  Future<UserProfile> updateMyProfile({
    String? displayName,
    String? locale,
  }) async {
    updates.add({'displayName': displayName, 'locale': locale});
    final failure = nextFailure;
    if (failure != null) {
      nextFailure = null;
      throw failure;
    }
    profile = profile.copyWith(displayName: displayName, locale: locale);
    return profile;
  }
}

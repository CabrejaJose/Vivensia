import '../entities/user_profile.dart';

enum ProfileFailure implements Exception { network, notFound, unexpected }

/// Perfil del usuario con sesión. Lanza [ProfileFailure].
abstract interface class ProfileRepository {
  Future<UserProfile> fetchMyProfile();

  Future<UserProfile> updateMyProfile({String? displayName, String? locale});
}

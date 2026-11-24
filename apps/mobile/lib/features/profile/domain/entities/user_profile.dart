/// Idiomas soportados por la app (coinciden con la restricción de BD).
const supportedLanguageCodes = ['es', 'en'];

/// Perfil público del usuario dentro de sus hogares.
class UserProfile {
  const UserProfile({required this.id, required this.locale, this.displayName});

  final String id;
  final String? displayName;

  /// 'es' o 'en'.
  final String locale;

  /// El onboarding termina cuando hay nombre visible.
  bool get isComplete => (displayName?.trim().isNotEmpty ?? false);

  UserProfile copyWith({String? displayName, String? locale}) => UserProfile(
    id: id,
    displayName: displayName ?? this.displayName,
    locale: locale ?? this.locale,
  );
}

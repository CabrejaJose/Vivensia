import '../../../design_system/design_system.dart';
import '../../../l10n/app_localizations.dart';

/// Opciones de idioma (nombres en su propio idioma).
List<VivOption<String>> languageOptions(AppLocalizations l10n) => [
  VivOption(value: 'es', label: l10n.languageSpanish),
  VivOption(value: 'en', label: l10n.languageEnglish),
];

/// Idioma actual de la interfaz si está soportado; si no, inglés.
String currentLanguageCode(String languageCode) =>
    languageCode == 'es' ? 'es' : 'en';

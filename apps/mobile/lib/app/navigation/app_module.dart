import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../l10n/app_localizations.dart';
import '../router/app_routes.dart';

/// Catálogo de funciones de Vivensia visibles en la navegación.
///
/// Es metadato de navegación (nombre, icono, destino), no lógica de negocio.
/// Las funciones sin implementar abren la pantalla "Próximamente".
enum AppModule {
  cleaning('cleaning', LucideIcons.sprayCan),
  finances('finances', LucideIcons.wallet),
  shopping('shopping', LucideIcons.shoppingCart),
  pantry('pantry', LucideIcons.package),
  calendar('calendar', LucideIcons.calendarDays),
  recipes('recipes', LucideIcons.chefHat),
  maintenance('maintenance', LucideIcons.wrench),
  documents('documents', LucideIcons.fileText),
  family('family', LucideIcons.users),
  assistant('assistant', LucideIcons.sparkles),
  notifications('notifications', LucideIcons.bell),
  settings('settings', LucideIcons.settings);

  const AppModule(this.id, this.icon);

  final String id;
  final IconData icon;

  static AppModule? fromId(String? id) {
    for (final m in values) {
      if (m.id == id) return m;
    }
    return null;
  }

  /// Funciones del hogar mostradas en Inicio y en Más.
  static const List<AppModule> householdFeatures = [
    cleaning,
    finances,
    shopping,
    pantry,
    recipes,
    maintenance,
    documents,
    family,
  ];

  /// Las funciones con pestaña propia se abren cambiando de pestaña.
  String? get tabRoute => switch (this) {
    cleaning => AppRoutes.tasks,
    shopping => AppRoutes.shopping,
    calendar => AppRoutes.agenda,
    _ => null,
  };

  String get route => tabRoute ?? AppRoutes.module(id);

  String label(AppLocalizations l10n) => switch (this) {
    cleaning => l10n.moduleCleaning,
    finances => l10n.moduleFinances,
    shopping => l10n.moduleShopping,
    pantry => l10n.modulePantry,
    calendar => l10n.moduleCalendar,
    recipes => l10n.moduleRecipes,
    maintenance => l10n.moduleMaintenance,
    documents => l10n.moduleDocuments,
    family => l10n.moduleFamily,
    assistant => l10n.moduleAssistant,
    notifications => l10n.notifications,
    settings => l10n.moduleSettings,
  };
}

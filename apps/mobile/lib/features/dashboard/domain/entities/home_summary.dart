/// Resumen del hogar mostrado en Inicio.
///
/// Solo contadores: no incluye importes ni datos privados de otros
/// integrantes.
class HomeSummary {
  const HomeSummary({
    required this.householdName,
    required this.pendingTasks,
    required this.shoppingItems,
    required this.upcomingEvents,
    required this.pantryItems,
    required this.upcomingMaintenance,
    required this.familyMembers,
    required this.isDemo,
  });

  /// `null` cuando el nombre debe resolverse en la interfaz (p. ej. el hogar
  /// de ejemplo, cuyo nombre se traduce).
  final String? householdName;
  final int pendingTasks;
  final int shoppingItems;
  final int upcomingEvents;
  final int pantryItems;
  final int upcomingMaintenance;
  final int familyMembers;

  /// `true` si los datos son de demostración y deben identificarse como tales.
  final bool isDemo;
}

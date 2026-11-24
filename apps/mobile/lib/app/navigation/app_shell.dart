import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../design_system/design_system.dart';
import '../../l10n/app_localizations.dart';

/// Estructura principal con la barra inferior: Inicio, Tareas, Compras,
/// Agenda y Más. Cada pestaña conserva su propia pila de navegación.
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onSelect(int index) {
    // Volver a pulsar la pestaña activa regresa a su pantalla inicial.
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: VivNavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _onSelect,
        destinations: [
          VivNavDestination(icon: LucideIcons.house, label: l10n.navHome),
          VivNavDestination(icon: LucideIcons.listChecks, label: l10n.navTasks),
          VivNavDestination(
            icon: LucideIcons.shoppingCart,
            label: l10n.navShopping,
          ),
          VivNavDestination(
            icon: LucideIcons.calendarDays,
            label: l10n.navAgenda,
          ),
          VivNavDestination(icon: LucideIcons.ellipsis, label: l10n.navMore),
        ],
      ),
    );
  }
}

import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../design_system/design_system.dart';
import '../../l10n/app_localizations.dart';

/// Pestaña provisional hasta que se implemente su función
/// (Tareas → Fase 05, Compras → Fase 06, Agenda → Fase 08).
class _TabPlaceholder extends StatelessWidget {
  const _TabPlaceholder({
    required this.title,
    required this.message,
    required this.icon,
  });

  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: VivEmptyState(
          icon: icon,
          title: message,
          message: l10n.comingSoonMessage,
        ),
      ),
    );
  }
}

class TasksTabScreen extends StatelessWidget {
  const TasksTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _TabPlaceholder(
      title: l10n.navTasks,
      message: l10n.tasksPlaceholderTitle,
      icon: LucideIcons.listChecks,
    );
  }
}

class ShoppingTabScreen extends StatelessWidget {
  const ShoppingTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _TabPlaceholder(
      title: l10n.navShopping,
      message: l10n.shoppingPlaceholderTitle,
      icon: LucideIcons.shoppingCart,
    );
  }
}

class AgendaTabScreen extends StatelessWidget {
  const AgendaTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _TabPlaceholder(
      title: l10n.navAgenda,
      message: l10n.agendaPlaceholderTitle,
      icon: LucideIcons.calendarDays,
    );
  }
}

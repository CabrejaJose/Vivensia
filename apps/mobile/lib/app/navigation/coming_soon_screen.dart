import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../design_system/design_system.dart';
import '../../l10n/app_localizations.dart';
import '../router/app_routes.dart';
import 'app_module.dart';

/// Pantalla para funciones que todavía no están implementadas.
class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({required this.module, super.key});

  final AppModule module;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(module.label(l10n)),
        // Si se llegó por enlace directo no hay pantalla previa: volver a Inicio.
        leading: context.canPop()
            ? null
            : IconButton(
                tooltip: l10n.goHome,
                icon: const Icon(LucideIcons.arrowLeft),
                onPressed: () => context.go(AppRoutes.home),
              ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: VivSpacing.lg),
            VivBadge(label: l10n.comingSoon, tone: VivBadgeTone.primary),
            Expanded(
              child: VivEmptyState(
                icon: module.icon,
                title: module.label(l10n),
                message: l10n.comingSoonMessage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

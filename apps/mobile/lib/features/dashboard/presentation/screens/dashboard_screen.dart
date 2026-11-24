import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';

/// Pantalla de inicio provisional.
/// El dashboard conceptual se construye en el Hito 5.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(VivSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.appName, style: text.displaySmall),
                const SizedBox(height: VivSpacing.sm),
                Text(
                  l10n.tagline,
                  style: text.titleMedium?.copyWith(
                    color: context.vivColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (!kReleaseMode) ...[
                  const SizedBox(height: VivSpacing.xxl),
                  VivButton(
                    label: l10n.openShowcase,
                    icon: LucideIcons.palette,
                    variant: VivButtonVariant.secondary,
                    onPressed: () => context.push(AppRoutes.designSystem),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

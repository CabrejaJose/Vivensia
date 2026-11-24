import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/navigation/app_module.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/greeting_period.dart';

/// Selector de hogar, notificaciones y saludo.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.householdName,
    required this.period,
    super.key,
    this.userName,
  });

  final String householdName;
  final GreetingPeriod period;

  /// Nombre del usuario con sesión (null en modo demo o sin perfil).
  final String? userName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final viv = context.vivColors;
    final name = userName?.trim();
    final hasName = name != null && name.isNotEmpty;
    final (greeting, icon) = switch (period) {
      GreetingPeriod.morning => (
        hasName ? l10n.greetingMorningNamed(name) : l10n.greetingMorning,
        LucideIcons.sun,
      ),
      GreetingPeriod.afternoon => (
        hasName ? l10n.greetingAfternoonNamed(name) : l10n.greetingAfternoon,
        LucideIcons.sunMedium,
      ),
      GreetingPeriod.evening => (
        hasName ? l10n.greetingEveningNamed(name) : l10n.greetingEvening,
        LucideIcons.moon,
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                button: true,
                hint: l10n.householdSwitcherHint,
                child: InkWell(
                  borderRadius: VivRadius.mdAll,
                  onTap: () => showVivBottomSheet<void>(
                    context,
                    title: l10n.householdSheetTitle,
                    builder: (context) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        VivListTile(
                          icon: LucideIcons.house,
                          title: householdName,
                          trailing: const Icon(LucideIcons.check),
                        ),
                        const SizedBox(height: VivSpacing.md),
                        Text(
                          l10n.householdSheetMessage,
                          style: text.bodyMedium?.copyWith(
                            color: viv.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: VivSize.minTouchTarget,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.myHousehold.toUpperCase(),
                          style: text.labelSmall?.copyWith(color: viv.link),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                householdName,
                                style: text.titleMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: VivSpacing.xs),
                            const Icon(
                              LucideIcons.chevronDown,
                              size: VivSize.iconMd,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: l10n.notifications,
              icon: const Icon(LucideIcons.bell),
              onPressed: () => context.push(AppModule.notifications.route),
            ),
          ],
        ),
        const SizedBox(height: VivSpacing.xl),
        Row(
          children: [
            Flexible(
              child: Semantics(
                header: true,
                child: Text(greeting, style: text.headlineLarge),
              ),
            ),
            const SizedBox(width: VivSpacing.sm),
            Icon(icon, color: viv.gold, size: VivSize.iconXl),
          ],
        ),
        const SizedBox(height: VivSpacing.xs),
        Text(
          l10n.greetingSubtitle,
          style: text.bodyLarge?.copyWith(color: viv.textSecondary),
        ),
      ],
    );
  }
}

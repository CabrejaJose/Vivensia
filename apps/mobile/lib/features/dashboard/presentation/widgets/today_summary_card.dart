import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/home_summary.dart';

/// Tarjeta "Tu hogar hoy" con los contadores principales.
class TodaySummaryCard extends StatelessWidget {
  const TodaySummaryCard({required this.summary, super.key});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;

    return VivCard(
      tone: VivCardTone.tonal,
      padding: const EdgeInsets.all(VivSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.todayEyebrow.toUpperCase(),
            style: text.labelSmall?.copyWith(color: scheme.onPrimaryContainer),
          ),
          const SizedBox(height: VivSpacing.xs),
          Text(
            l10n.todayAllGood,
            style: text.headlineSmall?.copyWith(
              color: scheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: VivSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Stat(
                count: summary.pendingTasks,
                label: l10n.statTasks,
                route: AppRoutes.tasks,
              ),
              _Stat(
                count: summary.shoppingItems,
                label: l10n.statShopping,
                route: AppRoutes.shopping,
              ),
              _Stat(
                count: summary.upcomingEvents,
                label: l10n.statEvents,
                route: AppRoutes.agenda,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.count, required this.label, required this.route});

  final int count;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme.onPrimaryContainer;
    return Expanded(
      child: Semantics(
        button: true,
        excludeSemantics: true,
        label: l10n.statSemantics(label, count),
        child: InkWell(
          borderRadius: VivRadius.mdAll,
          onTap: () => context.go(route),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: VivSize.minTouchTarget,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: VivSpacing.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$count',
                    style: text.headlineLarge?.copyWith(color: color),
                  ),
                  Text(
                    label,
                    style: text.labelMedium?.copyWith(color: color),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

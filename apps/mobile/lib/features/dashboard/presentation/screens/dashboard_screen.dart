import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/utils/clock.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/application/profile_providers.dart';
import '../../application/home_summary_provider.dart';
import '../../domain/entities/home_summary.dart';
import '../../domain/greeting_period.dart';
import '../widgets/assistant_card.dart';
import '../widgets/dashboard_skeleton.dart';
import '../widgets/home_header.dart';
import '../widgets/module_grid.dart';
import '../widgets/today_summary_card.dart';

/// Inicio: resumen del hogar activo con estados de carga, error y contenido.
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(homeSummaryProvider);

    return Scaffold(
      body: SafeArea(
        child: summary.when(
          data: (data) => _Content(summary: data),
          loading: () => const _Frame(children: [DashboardSkeleton()]),
          error: (error, stackTrace) => VivErrorState(
            title: l10n.errorGenericTitle,
            message: l10n.errorGenericMessage,
            retryLabel: l10n.retry,
            onRetry: () => ref.invalidate(homeSummaryProvider),
          ),
        ),
      ),
    );
  }
}

class _Frame extends StatelessWidget {
  const _Frame({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 840),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            VivSpacing.screenGutter,
            VivSpacing.lg,
            VivSpacing.screenGutter,
            VivSpacing.xxl,
          ),
          children: children,
        ),
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content({required this.summary});

  final HomeSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final now = ref.watch(clockProvider)();
    return _Frame(
      children: [
        HomeHeader(
          householdName: summary.householdName ?? l10n.demoHouseholdName,
          period: greetingPeriodOf(now),
          userName: ref.watch(myProfileProvider).value?.displayName,
        ),
        if (summary.isDemo) ...[
          const SizedBox(height: VivSpacing.md),
          Align(
            alignment: Alignment.centerLeft,
            child: VivBadge(
              label: l10n.showcaseDemoData,
              tone: VivBadgeTone.info,
            ),
          ),
        ],
        const SizedBox(height: VivSpacing.xl),
        TodaySummaryCard(summary: summary),
        const SizedBox(height: VivSpacing.xxl),
        VivSectionHeader(title: l10n.organizeYourHome),
        const SizedBox(height: VivSpacing.md),
        ModuleGrid(summary: summary),
        const SizedBox(height: VivSpacing.xl),
        const AssistantCard(),
      ],
    );
  }
}

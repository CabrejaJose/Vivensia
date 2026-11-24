import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../design_system/design_system.dart';
import '../../l10n/app_localizations.dart';

/// Catálogo de componentes del sistema de diseño.
///
/// Herramienta interna: solo se registra en builds que no son de release.
/// Los datos mostrados son ficticios y se identifican como tales.
class DesignSystemShowcaseScreen extends ConsumerStatefulWidget {
  const DesignSystemShowcaseScreen({super.key});

  @override
  ConsumerState<DesignSystemShowcaseScreen> createState() =>
      _DesignSystemShowcaseScreenState();
}

class _DesignSystemShowcaseScreenState
    extends ConsumerState<DesignSystemShowcaseScreen> {
  int _navIndex = 0;
  String _room = 'kitchen';
  String _period = 'week';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final viv = context.vivColors;
    final text = Theme.of(context).textTheme;
    final themeMode = ref.watch(themeModeProvider);

    Widget section(String title, Widget child) => Padding(
      padding: const EdgeInsets.only(top: VivSpacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VivSectionHeader(title: title),
          const SizedBox(height: VivSpacing.md),
          child,
        ],
      ),
    );

    Widget swatch(String label, Color color, Color onColor) => Container(
      width: 104,
      height: 72,
      padding: const EdgeInsets.all(VivSpacing.sm),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(color: color, borderRadius: VivRadius.lgAll),
      child: Text(label, style: text.labelMedium?.copyWith(color: onColor)),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.showcaseTitle)),
      bottomNavigationBar: VivNavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (i) => setState(() => _navIndex = i),
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
      body: SafeArea(
        top: false,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: VivSize.maxContentWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                VivSpacing.screenGutter,
                VivSpacing.sm,
                VivSpacing.screenGutter,
                VivSpacing.xxl,
              ),
              children: [
                VivPageHeader(
                  eyebrow: l10n.appName,
                  title: l10n.showcaseTitle,
                  subtitle: l10n.tagline,
                ),
                const SizedBox(height: VivSpacing.md),
                Align(
                  alignment: Alignment.centerLeft,
                  child: VivBadge(
                    label: l10n.showcaseDemoData,
                    tone: VivBadgeTone.info,
                    icon: LucideIcons.flaskConical,
                  ),
                ),
                section(
                  l10n.themeLabel,
                  VivSegmentedControl<ThemeMode>(
                    selected: themeMode,
                    onChanged: ref.read(themeModeProvider.notifier).set,
                    options: [
                      VivOption(
                        value: ThemeMode.light,
                        label: l10n.themeLight,
                        icon: LucideIcons.sun,
                      ),
                      VivOption(
                        value: ThemeMode.dark,
                        label: l10n.themeDark,
                        icon: LucideIcons.moon,
                      ),
                      VivOption(
                        value: ThemeMode.system,
                        label: l10n.themeSystem,
                        icon: LucideIcons.sunMoon,
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionColors,
                  Wrap(
                    spacing: VivSpacing.sm,
                    runSpacing: VivSpacing.sm,
                    children: [
                      swatch(
                        l10n.colorPrimary,
                        scheme.primary,
                        scheme.onPrimary,
                      ),
                      swatch(
                        l10n.colorSecondary,
                        scheme.secondary,
                        scheme.onSecondary,
                      ),
                      swatch(
                        l10n.colorTertiary,
                        scheme.tertiary,
                        scheme.onTertiary,
                      ),
                      swatch(l10n.colorGold, viv.gold, viv.onGold),
                      swatch(
                        l10n.colorSuccess,
                        viv.successContainer,
                        viv.onSuccessContainer,
                      ),
                      swatch(
                        l10n.colorWarning,
                        viv.warningContainer,
                        viv.onWarningContainer,
                      ),
                      swatch(
                        l10n.colorError,
                        scheme.errorContainer,
                        scheme.onErrorContainer,
                      ),
                      swatch(
                        l10n.colorInfo,
                        viv.infoContainer,
                        viv.onInfoContainer,
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionTypography,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.tagline, style: text.displaySmall),
                      Text(l10n.tagline, style: text.headlineMedium),
                      Text(l10n.tagline, style: text.titleLarge),
                      Text(l10n.emptyTasksMessage, style: text.bodyLarge),
                      Text(
                        l10n.errorGenericMessage,
                        style: text.bodyMedium?.copyWith(
                          color: viv.textSecondary,
                        ),
                      ),
                      Text(l10n.showcaseDemoData, style: text.labelSmall),
                    ],
                  ),
                ),
                section(
                  l10n.sectionButtons,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: VivSpacing.md,
                    children: [
                      VivButton(
                        label: l10n.buttonPrimary,
                        icon: LucideIcons.plus,
                        expand: true,
                        onPressed: () {},
                      ),
                      VivButton(
                        label: l10n.buttonSecondary,
                        variant: VivButtonVariant.secondary,
                        expand: true,
                        onPressed: () {},
                      ),
                      VivButton(
                        label: l10n.buttonTertiary,
                        variant: VivButtonVariant.tertiary,
                        expand: true,
                        onPressed: () {},
                      ),
                      VivButton(
                        label: l10n.delete,
                        icon: LucideIcons.trash2,
                        variant: VivButtonVariant.destructive,
                        expand: true,
                        onPressed: () {},
                      ),
                      VivButton(
                        label: l10n.buttonLoading,
                        isLoading: true,
                        expand: true,
                        onPressed: () {},
                      ),
                      VivButton(
                        label: l10n.buttonDisabled,
                        expand: true,
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionInputs,
                  Column(
                    spacing: VivSpacing.lg,
                    children: [
                      VivTextField(
                        label: l10n.fieldEmailLabel,
                        hint: l10n.fieldEmailHint,
                        helperText: l10n.fieldEmailHelper,
                        prefixIcon: LucideIcons.mail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      VivTextField(
                        label: l10n.fieldEmailLabel,
                        prefixIcon: LucideIcons.mail,
                        errorText: l10n.fieldEmailError,
                      ),
                      VivTextField.password(
                        label: l10n.fieldPasswordLabel,
                        showPasswordLabel: l10n.showPassword,
                        hidePasswordLabel: l10n.hidePassword,
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionCards,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: VivSpacing.md,
                    children: [
                      VivCard(
                        onTap: () {},
                        child: VivListTileContent(
                          icon: LucideIcons.sprayCan,
                          title: l10n.demoCleaningTitle,
                          subtitle: l10n.demoPendingTasks(3),
                        ),
                      ),
                      VivCard(
                        tone: VivCardTone.tonal,
                        child: VivProgressBar(
                          value: 0.62,
                          label: l10n.demoBudgetTitle,
                          valueLabel: l10n.demoPercentUsed(62),
                        ),
                      ),
                      VivCard(
                        tone: VivCardTone.accent,
                        child: VivListTileContent(
                          icon: LucideIcons.shoppingCart,
                          title: l10n.demoShoppingTitle,
                          subtitle: l10n.demoProducts(8),
                        ),
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionBadges,
                  Wrap(
                    spacing: VivSpacing.sm,
                    runSpacing: VivSpacing.sm,
                    children: [
                      VivBadge(
                        label: l10n.badgeDone,
                        tone: VivBadgeTone.success,
                        icon: LucideIcons.check,
                      ),
                      VivBadge(
                        label: l10n.badgeDueSoon,
                        tone: VivBadgeTone.warning,
                      ),
                      VivBadge(
                        label: l10n.badgeOverdue,
                        tone: VivBadgeTone.danger,
                      ),
                      VivBadge(
                        label: l10n.badgeNew,
                        tone: VivBadgeTone.primary,
                      ),
                      VivBadge(
                        label: l10n.badgeAchievement,
                        tone: VivBadgeTone.gold,
                        icon: LucideIcons.trophy,
                      ),
                      VivBadge(label: l10n.badgeInfo, tone: VivBadgeTone.info),
                      VivBadge(label: l10n.badgeShared),
                    ],
                  ),
                ),
                section(
                  l10n.sectionSelectors,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: VivSpacing.lg,
                    children: [
                      VivChoiceChips<String>(
                        selected: _room,
                        onSelected: (v) => setState(() => _room = v),
                        options: [
                          VivOption(value: 'kitchen', label: l10n.roomKitchen),
                          VivOption(
                            value: 'bathroom',
                            label: l10n.roomBathroom,
                          ),
                          VivOption(
                            value: 'living',
                            label: l10n.roomLivingRoom,
                          ),
                          VivOption(value: 'bedroom', label: l10n.roomBedroom),
                        ],
                      ),
                      VivSegmentedControl<String>(
                        selected: _period,
                        onChanged: (v) => setState(() => _period = v),
                        options: [
                          VivOption(value: 'day', label: l10n.periodDay),
                          VivOption(value: 'week', label: l10n.periodWeek),
                          VivOption(value: 'month', label: l10n.periodMonth),
                        ],
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionProgress,
                  Column(
                    spacing: VivSpacing.lg,
                    children: [
                      VivProgressBar(
                        value: 0.35,
                        label: l10n.demoBudgetTitle,
                        valueLabel: l10n.demoPercentUsed(35),
                      ),
                      VivLoader(semanticsLabel: l10n.loading),
                    ],
                  ),
                ),
                section(
                  l10n.sectionLists,
                  VivCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: VivSpacing.sm,
                    ),
                    child: Column(
                      children: [
                        VivListTile(
                          icon: LucideIcons.sprayCan,
                          title: l10n.demoCleaningTitle,
                          subtitle: l10n.demoPendingTasks(1),
                          showChevron: true,
                          onTap: () {},
                        ),
                        VivListTile(
                          icon: LucideIcons.wallet,
                          title: l10n.demoBudgetTitle,
                          subtitle: l10n.demoPercentUsed(62),
                          showChevron: true,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                section(
                  l10n.sectionOverlays,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: VivSpacing.md,
                    children: [
                      VivButton(
                        label: l10n.openDialog,
                        variant: VivButtonVariant.secondary,
                        onPressed: () => showVivConfirmDialog(
                          context,
                          title: l10n.dialogDeleteTaskTitle,
                          message: l10n.dialogDeleteTaskMessage,
                          confirmLabel: l10n.delete,
                          cancelLabel: l10n.cancel,
                          destructive: true,
                        ),
                      ),
                      VivButton(
                        label: l10n.openSheet,
                        variant: VivButtonVariant.secondary,
                        onPressed: () => showVivBottomSheet<void>(
                          context,
                          title: l10n.sheetNewTaskTitle,
                          builder: (context) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: VivSpacing.lg,
                            children: [
                              VivTextField(label: l10n.sheetTaskNameLabel),
                              VivButton(
                                label: l10n.save,
                                expand: true,
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionStates,
                  Column(
                    spacing: VivSpacing.md,
                    children: [
                      SizedBox(
                        height: 340,
                        child: VivCard(
                          child: VivEmptyState(
                            title: l10n.emptyTasksTitle,
                            message: l10n.emptyTasksMessage,
                            icon: LucideIcons.sparkles,
                            actionLabel: l10n.emptyTasksAction,
                            onAction: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 340,
                        child: VivCard(
                          child: VivErrorState(
                            title: l10n.errorGenericTitle,
                            message: l10n.errorGenericMessage,
                            retryLabel: l10n.retry,
                            onRetry: () {},
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 160,
                        child: VivCard(
                          child: VivLoadingState(label: l10n.loading),
                        ),
                      ),
                    ],
                  ),
                ),
                section(
                  l10n.sectionSkeleton,
                  const VivCard(
                    padding: EdgeInsets.symmetric(vertical: VivSpacing.sm),
                    child: Column(
                      children: [VivSkeletonListTile(), VivSkeletonListTile()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

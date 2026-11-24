import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../design_system/design_system.dart';
import '../../l10n/app_localizations.dart';
import '../router/app_routes.dart';
import 'app_module.dart';

/// Pestaña "Más": acceso a todas las funciones, apariencia y configuración.
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  static const _features = [
    ...AppModule.householdFeatures,
    AppModule.calendar,
    AppModule.assistant,
    AppModule.settings,
  ];

  void _open(BuildContext context, AppModule module) {
    if (module.tabRoute != null) {
      context.go(module.route);
    } else {
      context.push(module.route);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeModeProvider);

    Widget section(String title, Widget child) => Padding(
      padding: const EdgeInsets.only(top: VivSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VivSectionHeader(title: title),
          const SizedBox(height: VivSpacing.sm),
          child,
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMore)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: VivSize.maxContentWidth,
            ),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                VivSpacing.screenGutter,
                0,
                VivSpacing.screenGutter,
                VivSpacing.xxl,
              ),
              children: [
                section(
                  l10n.moreFeatures,
                  VivCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: VivSpacing.sm,
                    ),
                    child: Column(
                      children: [
                        for (final module in _features)
                          VivListTile(
                            icon: module.icon,
                            title: module.label(l10n),
                            showChevron: true,
                            onTap: () => _open(context, module),
                          ),
                      ],
                    ),
                  ),
                ),
                section(
                  l10n.moreAppearance,
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
                if (!kReleaseMode)
                  section(
                    l10n.moreDevelopment,
                    VivCard(
                      padding: const EdgeInsets.symmetric(
                        vertical: VivSpacing.sm,
                      ),
                      child: VivListTile(
                        icon: LucideIcons.palette,
                        title: l10n.openShowcase,
                        showChevron: true,
                        onTap: () => context.push(AppRoutes.designSystem),
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

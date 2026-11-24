import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/navigation/app_module.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/home_summary.dart';

/// Cuadrícula "Organiza tu hogar". Columnas según el ancho disponible;
/// las filas crecen con el texto para soportar escalado.
class ModuleGrid extends StatelessWidget {
  const ModuleGrid({required this.summary, super.key});

  final HomeSummary summary;

  String _subtitle(AppLocalizations l10n, AppModule m) => switch (m) {
    AppModule.cleaning => l10n.demoPendingTasks(summary.pendingTasks),
    AppModule.finances => l10n.demoBudgetTitle,
    AppModule.shopping => l10n.demoProducts(summary.shoppingItems),
    AppModule.pantry => l10n.demoProducts(summary.pantryItems),
    AppModule.recipes => l10n.recipesSubtitle,
    AppModule.maintenance => l10n.demoUpcomingMaintenance(
      summary.upcomingMaintenance,
    ),
    AppModule.documents => l10n.documentsSubtitle,
    AppModule.family => l10n.demoFamilyMembers(summary.familyMembers),
    AppModule.calendar => l10n.demoUpcomingEvents(summary.upcomingEvents),
    _ => '',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const modules = AppModule.householdFeatures;

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 560 ? 4 : 2;
        final rows = <Widget>[];
        for (var i = 0; i < modules.length; i += columns) {
          final slice = modules.skip(i).take(columns).toList();
          rows.add(
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (var j = 0; j < columns; j++) ...[
                    if (j > 0) const SizedBox(width: VivSpacing.md),
                    Expanded(
                      child: j < slice.length
                          ? _ModuleTile(
                              module: slice[j],
                              title: slice[j].label(l10n),
                              subtitle: _subtitle(l10n, slice[j]),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
        return Column(spacing: VivSpacing.md, children: rows);
      },
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.module,
    required this.title,
    required this.subtitle,
  });

  final AppModule module;
  final String title;
  final String subtitle;

  void _open(BuildContext context) {
    if (module.tabRoute != null) {
      context.go(module.route);
    } else {
      context.push(module.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return VivCard(
      onTap: () => _open(context),
      semanticLabel: '$title. $subtitle',
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: VivRadius.mdAll,
              ),
              child: Icon(
                module.icon,
                size: VivSize.iconMd,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: VivSpacing.md),
            Text(title, style: text.titleSmall),
            const SizedBox(height: VivSpacing.xs),
            Text(
              subtitle,
              style: text.bodySmall?.copyWith(
                color: context.vivColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

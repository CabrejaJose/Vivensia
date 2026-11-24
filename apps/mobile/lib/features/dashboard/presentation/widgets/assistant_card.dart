import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/navigation/app_module.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';

/// Acceso al asistente inteligente (Fase 15). Hoy abre "Próximamente".
class AssistantCard extends StatelessWidget {
  const AssistantCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return VivCard(
      tone: VivCardTone.accent,
      onTap: () => context.push(AppModule.assistant.route),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: VivRadius.lgAll,
            ),
            child: Icon(AppModule.assistant.icon, color: scheme.tertiary),
          ),
          const SizedBox(width: VivSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.moduleAssistant,
                  style: text.titleMedium?.copyWith(
                    color: scheme.onTertiaryContainer,
                  ),
                ),
                Text(
                  l10n.assistantPrompt,
                  style: text.bodyMedium?.copyWith(
                    color: scheme.onTertiaryContainer,
                  ),
                ),
                const SizedBox(height: VivSpacing.sm),
                VivBadge(label: l10n.comingSoon, tone: VivBadgeTone.neutral),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

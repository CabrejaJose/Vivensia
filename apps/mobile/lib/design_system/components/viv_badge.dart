import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';

enum VivBadgeTone { neutral, primary, success, warning, danger, info, gold }

/// Etiqueta compacta de estado. El color nunca es el único portador de
/// significado: siempre acompaña un texto.
class VivBadge extends StatelessWidget {
  const VivBadge({
    required this.label,
    super.key,
    this.tone = VivBadgeTone.neutral,
    this.icon,
  });

  final String label;
  final VivBadgeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final viv = context.vivColors;
    final (Color bg, Color fg) = switch (tone) {
      VivBadgeTone.neutral => (scheme.surfaceContainerHighest, viv.textPrimary),
      VivBadgeTone.primary => (
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      VivBadgeTone.success => (viv.successContainer, viv.onSuccessContainer),
      VivBadgeTone.warning => (viv.warningContainer, viv.onWarningContainer),
      VivBadgeTone.danger => (scheme.errorContainer, scheme.onErrorContainer),
      VivBadgeTone.info => (viv.infoContainer, viv.onInfoContainer),
      VivBadgeTone.gold => (viv.goldContainer, viv.onGoldContainer),
    };

    return DecoratedBox(
      decoration: BoxDecoration(color: bg, borderRadius: VivRadius.pillAll),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: VivSpacing.md,
          vertical: VivSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: VivSize.iconSm, color: fg),
              const SizedBox(width: VivSpacing.xs),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium
                    ?.copyWith(color: fg, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

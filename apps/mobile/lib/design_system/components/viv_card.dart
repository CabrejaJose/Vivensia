import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';

enum VivCardTone { surface, tonal, accent }

/// Tarjeta base de Vivensia. Plana, con borde sutil y esquinas amplias.
class VivCard extends StatelessWidget {
  const VivCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(VivSpacing.lg),
    this.tone = VivCardTone.surface,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final VivCardTone tone;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final viv = context.vivColors;
    final (Color background, Color border, Color foreground) = switch (tone) {
      VivCardTone.surface => (
        scheme.surface,
        scheme.outlineVariant,
        viv.textPrimary,
      ),
      VivCardTone.tonal => (
        scheme.primaryContainer,
        Colors.transparent,
        scheme.onPrimaryContainer,
      ),
      VivCardTone.accent => (
        scheme.tertiaryContainer,
        Colors.transparent,
        scheme.onTertiaryContainer,
      ),
    };

    return Semantics(
      container: true,
      button: onTap != null,
      label: semanticLabel,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: VivRadius.xlAll,
          side: BorderSide(color: border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: foreground),
            child: IconTheme.merge(
              data: IconThemeData(color: foreground),
              child: Padding(padding: padding, child: child),
            ),
          ),
        ),
      ),
    );
  }
}

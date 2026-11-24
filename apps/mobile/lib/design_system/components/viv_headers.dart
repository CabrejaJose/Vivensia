import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';

/// Encabezado de página: antetítulo, título grande y subtítulo.
class VivPageHeader extends StatelessWidget {
  const VivPageHeader({
    required this.title,
    super.key,
    this.eyebrow,
    this.subtitle,
    this.trailing,
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final viv = context.vivColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (eyebrow != null) ...[
                Text(
                  eyebrow!.toUpperCase(),
                  style: text.labelSmall?.copyWith(color: viv.link),
                ),
                const SizedBox(height: VivSpacing.xs),
              ],
              Semantics(
                header: true,
                child: Text(title, style: text.headlineLarge),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: VivSpacing.xs),
                Text(
                  subtitle!,
                  style: text.bodyLarge?.copyWith(color: viv.textSecondary),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: VivSpacing.md),
          trailing!,
        ],
      ],
    );
  }
}

/// Encabezado de sección con acción opcional ("Ver todo").
class VivSectionHeader extends StatelessWidget {
  const VivSectionHeader({
    required this.title,
    super.key,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Semantics(
            header: true,
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
        ),
        if (actionLabel != null && onAction != null)
          TextButton(onPressed: onAction, child: Text(actionLabel!)),
      ],
    );
  }
}

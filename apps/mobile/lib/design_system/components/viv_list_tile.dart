import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';

/// Elemento de lista con icono en contenedor tonal.
class VivListTile extends StatelessWidget {
  const VivListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
    this.showChevron = false,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      onTap: onTap,
      leading: icon == null
          ? null
          : Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: VivRadius.mdAll,
              ),
              child: Icon(
                icon,
                size: VivSize.iconMd,
                color: scheme.onPrimaryContainer,
              ),
            ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing:
          trailing ??
          (showChevron
              ? Icon(
                  LucideIcons.chevronRight,
                  size: VivSize.iconMd,
                  color: context.vivColors.textSecondary,
                )
              : null),
    );
  }
}

/// Contenido de fila (icono + título + subtítulo) para usar dentro de
/// tarjetas, sin el relleno ni la interacción propios de [ListTile].
class VivListTileContent extends StatelessWidget {
  const VivListTileContent({
    required this.title,
    super.key,
    this.subtitle,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = DefaultTextStyle.of(context).style.color;
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: VivSize.iconLg),
          const SizedBox(width: VivSpacing.md),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: text.titleMedium?.copyWith(color: color)),
              if (subtitle != null)
                Text(subtitle!, style: text.bodyMedium?.copyWith(color: color)),
            ],
          ),
        ),
      ],
    );
  }
}

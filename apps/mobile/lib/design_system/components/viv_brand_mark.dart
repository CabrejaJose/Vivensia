import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../tokens/tokens.dart';

/// Marca de Vivensia: símbolo + nombre. El nombre llega localizado.
class VivBrandMark extends StatelessWidget {
  const VivBrandMark({required this.label, super.key, this.large = false});

  final String label;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final size = large ? 72.0 : 48.0;
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: large ? VivRadius.xlAll : VivRadius.lgAll,
            ),
            child: Icon(
              LucideIcons.house,
              color: scheme.onPrimary,
              size: large ? VivSize.iconXl : VivSize.iconLg,
            ),
          ),
          const SizedBox(height: VivSpacing.md),
          Text(label, style: large ? text.headlineLarge : text.titleLarge),
        ],
      ),
    );
  }
}

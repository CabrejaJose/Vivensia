import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';

/// Barra de progreso con etiqueta y valor opcionales.
class VivProgressBar extends StatelessWidget {
  const VivProgressBar({
    required this.value,
    super.key,
    this.label,
    this.valueLabel,
  });

  /// Entre 0 y 1. `null` para progreso indeterminado.
  final double? value;
  final String? label;
  final String? valueLabel;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final viv = context.vivColors;
    return Semantics(
      label: label,
      value: valueLabel,
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label != null || valueLabel != null) ...[
              Row(
                children: [
                  if (label != null)
                    Expanded(
                      child: Text(
                        label!,
                        style: text.labelMedium?.copyWith(
                          color: viv.textSecondary,
                        ),
                      ),
                    ),
                  if (valueLabel != null)
                    Text(valueLabel!, style: text.labelLarge),
                ],
              ),
              const SizedBox(height: VivSpacing.sm),
            ],
            LinearProgressIndicator(value: value?.clamp(0, 1)),
          ],
        ),
      ),
    );
  }
}

/// Indicador circular de carga con etiqueta accesible.
class VivLoader extends StatelessWidget {
  const VivLoader({required this.semanticsLabel, super.key, this.size = 32});

  final String semanticsLabel;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        semanticsLabel: semanticsLabel,
      ),
    );
  }
}

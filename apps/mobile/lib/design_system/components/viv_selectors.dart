import 'package:material_ui/material_ui.dart';

import '../tokens/tokens.dart';

/// Opción de un selector.
@immutable
class VivOption<T> {
  const VivOption({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// Selección única mediante chips que se ajustan en varias líneas.
class VivChoiceChips<T> extends StatelessWidget {
  const VivChoiceChips({
    required this.options,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<VivOption<T>> options;
  final T? selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: VivSpacing.sm,
      runSpacing: VivSpacing.sm,
      children: [
        for (final option in options)
          ChoiceChip(
            label: Text(option.label),
            avatar: option.icon == null
                ? null
                : Icon(option.icon, size: VivSize.iconSm),
            selected: option.value == selected,
            onSelected: (_) => onSelected(option.value),
          ),
      ],
    );
  }
}

/// Control segmentado para 2–4 opciones excluyentes.
class VivSegmentedControl<T extends Object> extends StatelessWidget {
  const VivSegmentedControl({
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final List<VivOption<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<T>(
      showSelectedIcon: false,
      segments: [
        for (final option in options)
          ButtonSegment<T>(
            value: option.value,
            label: Text(
              option.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            icon: option.icon == null
                ? null
                : Icon(option.icon, size: VivSize.iconSm),
          ),
      ],
      selected: {selected},
      onSelectionChanged: (values) => onChanged(values.first),
    );
  }
}

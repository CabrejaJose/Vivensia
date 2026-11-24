import 'package:material_ui/material_ui.dart';

import '../tokens/tokens.dart';

enum VivButtonVariant { primary, secondary, tertiary, destructive }

/// Botón de Vivensia con variantes, icono opcional y estado de carga.
///
/// Mientras [isLoading] es `true`, el botón se deshabilita para evitar
/// envíos duplicados.
class VivButton extends StatelessWidget {
  const VivButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = VivButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final VivButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool expand;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final callback = isLoading ? null : onPressed;
    final height = compact ? VivSize.buttonHeightCompact : VivSize.buttonHeight;
    final sizeStyle = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(expand ? double.infinity : VivSize.minTouchTarget, height),
      ),
      padding: compact
          ? const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: VivSpacing.lg),
            )
          : null,
      tapTargetSize: MaterialTapTargetSize.padded,
    );

    final leading = isLoading
        ? const SizedBox.square(
            dimension: VivSize.iconMd,
            child: CircularProgressIndicator(strokeWidth: 2.5),
          )
        : (icon == null ? null : Icon(icon, size: VivSize.iconMd));

    final child = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (leading != null) ...[
          IconTheme.merge(
            data: const IconThemeData(size: VivSize.iconMd),
            child: _ProgressColor(child: leading),
          ),
          const SizedBox(width: VivSpacing.sm),
        ],
        Flexible(
          child: Text(label, overflow: TextOverflow.ellipsis, maxLines: 1),
        ),
      ],
    );

    final button = switch (variant) {
      VivButtonVariant.primary => FilledButton(
        onPressed: callback,
        style: sizeStyle,
        child: child,
      ),
      VivButtonVariant.secondary => OutlinedButton(
        onPressed: callback,
        style: sizeStyle,
        child: child,
      ),
      VivButtonVariant.tertiary => TextButton(
        onPressed: callback,
        style: sizeStyle,
        child: child,
      ),
      VivButtonVariant.destructive => FilledButton(
        onPressed: callback,
        style: FilledButton.styleFrom(
          backgroundColor: scheme.error,
          foregroundColor: scheme.onError,
        ).merge(sizeStyle),
        child: child,
      ),
    };

    return Semantics(
      button: true,
      enabled: callback != null,
      liveRegion: isLoading,
      child: button,
    );
  }
}

/// Hace que el indicador de progreso herede el color del texto del botón.
class _ProgressColor extends StatelessWidget {
  const _ProgressColor({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final color = DefaultTextStyle.of(context).style.color;
    return ProgressIndicatorTheme(
      data: ProgressIndicatorTheme.of(context).copyWith(color: color),
      child: child,
    );
  }
}

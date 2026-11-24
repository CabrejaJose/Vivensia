import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';
import 'viv_button.dart';
import 'viv_progress.dart';

/// Contenedor común de los estados vacío, error y carga.
class _StateLayout extends StatelessWidget {
  const _StateLayout({
    required this.illustration,
    required this.title,
    this.message,
    this.action,
  });

  final Widget illustration;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(VivSpacing.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              illustration,
              const SizedBox(height: VivSpacing.xl),
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: text.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              if (message != null) ...[
                const SizedBox(height: VivSpacing.sm),
                Text(
                  message!,
                  style: text.bodyMedium?.copyWith(
                    color: context.vivColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: VivSpacing.xl),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StateIcon extends StatelessWidget {
  const _StateIcon({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: VivSize.stateIllustration,
        height: VivSize.stateIllustration,
        decoration: BoxDecoration(
          color: background,
          borderRadius: VivRadius.xlAll,
        ),
        child: Icon(icon, size: VivSize.iconXl, color: foreground),
      ),
    );
  }
}

/// Estado vacío amable con acción opcional.
class VivEmptyState extends StatelessWidget {
  const VivEmptyState({
    required this.title,
    super.key,
    this.message,
    this.icon = LucideIcons.inbox,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _StateLayout(
      illustration: _StateIcon(
        icon: icon,
        background: scheme.primaryContainer,
        foreground: scheme.onPrimaryContainer,
      ),
      title: title,
      message: message,
      action: actionLabel == null || onAction == null
          ? null
          : VivButton(label: actionLabel!, onPressed: onAction),
    );
  }
}

/// Estado de error con reintento.
class VivErrorState extends StatelessWidget {
  const VivErrorState({
    required this.title,
    super.key,
    this.message,
    this.retryLabel,
    this.onRetry,
  });

  final String title;
  final String? message;
  final String? retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _StateLayout(
      illustration: _StateIcon(
        icon: LucideIcons.triangleAlert,
        background: scheme.errorContainer,
        foreground: scheme.onErrorContainer,
      ),
      title: title,
      message: message,
      action: retryLabel == null || onRetry == null
          ? null
          : VivButton(
              label: retryLabel!,
              icon: LucideIcons.refreshCw,
              variant: VivButtonVariant.secondary,
              onPressed: onRetry,
            ),
    );
  }
}

/// Estado de carga a pantalla completa.
class VivLoadingState extends StatelessWidget {
  const VivLoadingState({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VivLoader(semanticsLabel: label),
          const SizedBox(height: VivSpacing.lg),
          ExcludeSemantics(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: context.vivColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:material_ui/material_ui.dart';

import '../tokens/tokens.dart';
import 'viv_button.dart';

/// Diálogo de confirmación. Devuelve `true` solo si el usuario confirma.
Future<bool> showVivConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  bool destructive = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actionsPadding: const EdgeInsets.fromLTRB(
        VivSpacing.xl,
        0,
        VivSpacing.xl,
        VivSpacing.xl,
      ),
      actionsOverflowButtonSpacing: VivSpacing.sm,
      actions: [
        VivButton(
          label: cancelLabel,
          variant: VivButtonVariant.tertiary,
          compact: true,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        VivButton(
          label: confirmLabel,
          variant: destructive
              ? VivButtonVariant.destructive
              : VivButtonVariant.primary,
          compact: true,
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    ),
  );
  return result ?? false;
}

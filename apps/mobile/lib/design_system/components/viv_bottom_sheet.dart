import 'package:material_ui/material_ui.dart';

import '../tokens/tokens.dart';

/// Bottom sheet modal con título opcional, asa de arrastre y área segura.
Future<T?> showVivBottomSheet<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  String? title,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          VivSpacing.xl,
          0,
          VivSpacing.xl,
          VivSpacing.xl + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null) ...[
              Semantics(
                header: true,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: VivSpacing.lg),
            ],
            Flexible(child: builder(context)),
          ],
        ),
      ),
    ),
  );
}

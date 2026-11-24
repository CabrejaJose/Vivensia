import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../theme/vivensia_colors.dart';
import '../tokens/tokens.dart';

enum VivNoticeTone { info, success, warning, error }

/// Aviso en línea (errores de formulario, confirmaciones, información).
/// Se anuncia a lectores de pantalla como región viva.
class VivNotice extends StatelessWidget {
  const VivNotice({
    required this.message,
    super.key,
    this.title,
    this.tone = VivNoticeTone.info,
  });

  final String message;
  final String? title;
  final VivNoticeTone tone;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final viv = context.vivColors;
    final text = Theme.of(context).textTheme;
    final (Color bg, Color fg, IconData icon) = switch (tone) {
      VivNoticeTone.info => (
        viv.infoContainer,
        viv.onInfoContainer,
        LucideIcons.info,
      ),
      VivNoticeTone.success => (
        viv.successContainer,
        viv.onSuccessContainer,
        LucideIcons.circleCheck,
      ),
      VivNoticeTone.warning => (
        viv.warningContainer,
        viv.onWarningContainer,
        LucideIcons.triangleAlert,
      ),
      VivNoticeTone.error => (
        scheme.errorContainer,
        scheme.onErrorContainer,
        LucideIcons.circleAlert,
      ),
    };

    return Semantics(
      liveRegion: true,
      container: true,
      child: DecoratedBox(
        decoration: BoxDecoration(color: bg, borderRadius: VivRadius.lgAll),
        child: Padding(
          padding: const EdgeInsets.all(VivSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: fg, size: VivSize.iconMd),
              const SizedBox(width: VivSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null)
                      Text(title!, style: text.titleSmall?.copyWith(color: fg)),
                    Text(message, style: text.bodyMedium?.copyWith(color: fg)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

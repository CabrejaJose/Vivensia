import 'package:material_ui/material_ui.dart';

import '../../../../l10n/app_localizations.dart';

/// Pantalla de inicio provisional (Hito 3).
/// El dashboard conceptual se construye en el Hito 5.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l10n.appName, style: textTheme.displaySmall),
                const SizedBox(height: 8),
                Text(
                  l10n.tagline,
                  style: textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

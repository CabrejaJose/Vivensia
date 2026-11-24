import 'package:material_ui/material_ui.dart';

import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';

/// Se muestra mientras se restaura la sesión.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VivBrandMark(label: l10n.appName, large: true),
            const SizedBox(height: VivSpacing.xxl),
            VivLoader(semanticsLabel: l10n.loading),
          ],
        ),
      ),
    );
  }
}

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../design_system/design_system.dart';
import '../../../../l10n/app_localizations.dart';

/// Pantalla inicial sin sesión.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(VivSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VivBrandMark(label: l10n.appName, large: true),
                  const SizedBox(height: VivSpacing.xxl),
                  Semantics(
                    header: true,
                    child: Text(
                      l10n.welcomeTitle,
                      style: text.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: VivSpacing.sm),
                  Text(
                    l10n.welcomeSubtitle,
                    style: text.bodyLarge?.copyWith(
                      color: context.vivColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: VivSpacing.sm),
                  Text(
                    l10n.tagline,
                    style: text.titleSmall?.copyWith(
                      color: context.vivColors.link,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: VivSpacing.xxl),
                  VivButton(
                    label: l10n.createAccount,
                    expand: true,
                    onPressed: () => context.push(AppRoutes.signUp),
                  ),
                  const SizedBox(height: VivSpacing.md),
                  VivButton(
                    label: l10n.haveAccount,
                    variant: VivButtonVariant.secondary,
                    expand: true,
                    onPressed: () => context.push(AppRoutes.signIn),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

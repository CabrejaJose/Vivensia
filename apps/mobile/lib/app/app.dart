import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../design_system/design_system.dart';
import '../features/profile/application/profile_providers.dart';
import '../l10n/app_localizations.dart';
import 'router/app_router.dart';

class VivensiaApp extends ConsumerWidget {
  const VivensiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeModeProvider);
    final localeCode = ref.watch(preferredLocaleCodeProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // Con sesión, el idioma del perfil; si no, el del dispositivo.
      locale: localeCode == null ? null : Locale(localeCode),
      localeResolutionCallback: resolveLocale,
      themeMode: themeMode,
      theme: VivensiaTheme.light,
      darkTheme: VivensiaTheme.dark,
    );
  }
}

/// Usa el idioma del dispositivo si está soportado (es/en); si no, inglés.
Locale resolveLocale(Locale? deviceLocale, Iterable<Locale> supported) {
  if (deviceLocale != null) {
    for (final locale in supported) {
      if (locale.languageCode == deviceLocale.languageCode) return locale;
    }
  }
  return const Locale('en');
}

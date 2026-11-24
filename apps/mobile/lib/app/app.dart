import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../design_system/tokens/color_tokens.dart';
import '../l10n/app_localizations.dart';
import 'router/app_router.dart';

class VivensiaApp extends ConsumerWidget {
  const VivensiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appName,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: resolveLocale,
      // Temas provisionales; el sistema de diseño completo llega en el Hito 4.
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: VivensiaPalette.green600),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: VivensiaPalette.green600,
          brightness: Brightness.dark,
        ),
      ),
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

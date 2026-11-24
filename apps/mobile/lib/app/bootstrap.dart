import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/errors/error_reporter.dart';
import '../core/network/supabase_initializer.dart';
import '../features/auth/application/auth_providers.dart';
import '../features/auth/data/repositories/supabase_auth_repository.dart';
import 'app.dart';
import 'config/app_config.dart';

/// Inicializa la app: configuración, manejo global de errores y Riverpod.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  const reporter = ErrorReporter();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    reporter.report(
      details.exception,
      details.stack ?? StackTrace.current,
      context: 'flutter',
    );
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    reporter.report(error, stackTrace, context: 'platform');
    return true;
  };

  final supabase = await initializeSupabase(config);

  if (kReleaseMode) {
    // Evita la pantalla gris/roja de error en producción.
    ErrorWidget.builder = (_) => const SizedBox.shrink();
  }

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        errorReporterProvider.overrideWithValue(reporter),
        if (supabase != null)
          authRepositoryProvider.overrideWithValue(
            SupabaseAuthRepository(supabase.auth),
          ),
      ],
      child: const VivensiaApp(),
    ),
  );
}

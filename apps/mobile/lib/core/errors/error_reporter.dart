import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Punto único de reporte de errores no controlados.
///
/// Hoy solo registra localmente. Cuando se integre un servicio de crash
/// reporting, se conectará aquí. **No** incluir datos personales ni secretos
/// en [context]: solo identificadores técnicos.
class ErrorReporter {
  const ErrorReporter();

  void report(Object error, StackTrace stackTrace, {required String context}) {
    developer.log(
      'Unhandled error ($context): ${error.runtimeType}',
      name: 'vivensia',
      error: error,
      stackTrace: stackTrace,
      level: 1000,
    );
  }
}

final errorReporterProvider = Provider<ErrorReporter>(
  (ref) => const ErrorReporter(),
);

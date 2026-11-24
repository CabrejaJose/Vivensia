/// Errores de dominio/aplicación esperados, independientes de la capa de datos.
///
/// Los repositorios traducen excepciones técnicas (red, Supabase, SQLite) a
/// [Failure] para que la presentación no dependa de detalles de infraestructura.
sealed class Failure implements Exception {
  const Failure();
}

final class NetworkFailure extends Failure {
  const NetworkFailure();
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure();
}

final class ValidationFailure extends Failure {
  const ValidationFailure(this.field);

  /// Campo inválido (identificador técnico, no texto para el usuario).
  final String field;
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure();
}

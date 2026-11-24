import '../entities/home_summary.dart';

/// Contrato de acceso al resumen del hogar. Hoy lo implementa un repositorio
/// de demostración; en fases posteriores, uno basado en Supabase.
abstract interface class HomeSummaryRepository {
  Future<HomeSummary> fetchSummary();
}

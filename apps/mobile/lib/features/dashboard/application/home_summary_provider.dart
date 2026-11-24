import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/demo_home_summary_repository.dart';
import '../domain/entities/home_summary.dart';

/// Resumen del hogar activo. Sin reintentos automáticos: el usuario
/// reintenta desde el estado de error.
final homeSummaryProvider = FutureProvider<HomeSummary>(
  (ref) => ref.watch(homeSummaryRepositoryProvider).fetchSummary(),
  retry: (retryCount, error) => null,
);

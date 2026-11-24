import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/home_summary.dart';
import '../../domain/repositories/home_summary_repository.dart';

/// Datos ficticios para el dashboard conceptual. Siempre marcados `isDemo`.
class DemoHomeSummaryRepository implements HomeSummaryRepository {
  const DemoHomeSummaryRepository();

  @override
  Future<HomeSummary> fetchSummary() async => const HomeSummary(
    householdName: null,
    pendingTasks: 3,
    shoppingItems: 8,
    upcomingEvents: 2,
    pantryItems: 24,
    upcomingMaintenance: 1,
    familyMembers: 3,
    isDemo: true,
  );
}

final homeSummaryRepositoryProvider = Provider<HomeSummaryRepository>(
  (ref) => const DemoHomeSummaryRepository(),
);

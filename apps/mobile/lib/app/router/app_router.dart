import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../dev/design_system_showcase_screen.dart';
import 'app_routes.dart';
import 'route_error_screen.dart';

/// Router principal. La navegación con barra inferior (Inicio, Tareas,
/// Compras, Agenda, Más) se implementa en el Hito 5.
final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const DashboardScreen(),
      ),
      if (!kReleaseMode)
        GoRoute(
          path: AppRoutes.designSystem,
          builder: (context, state) => const DesignSystemShowcaseScreen(),
        ),
    ],
    errorBuilder: (context, state) => const RouteErrorScreen(),
  );
  ref.onDispose(router.dispose);
  return router;
});

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../dev/design_system_showcase_screen.dart';
import '../navigation/app_module.dart';
import '../navigation/app_shell.dart';
import '../navigation/coming_soon_screen.dart';
import '../navigation/more_screen.dart';
import '../navigation/tab_placeholders.dart';
import 'app_routes.dart';
import 'route_error_screen.dart';

/// Router principal con barra inferior persistente (StatefulShellRoute).
final appRouterProvider = Provider<GoRouter>((ref) {
  GoRoute tab(String path, Widget screen) =>
      GoRoute(path: path, builder: (context, state) => screen);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [tab(AppRoutes.home, const DashboardScreen())],
          ),
          StatefulShellBranch(
            routes: [tab(AppRoutes.tasks, const TasksTabScreen())],
          ),
          StatefulShellBranch(
            routes: [tab(AppRoutes.shopping, const ShoppingTabScreen())],
          ),
          StatefulShellBranch(
            routes: [tab(AppRoutes.agenda, const AgendaTabScreen())],
          ),
          StatefulShellBranch(
            routes: [tab(AppRoutes.more, const MoreScreen())],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.modulePattern,
        builder: (context, state) {
          final module = AppModule.fromId(state.pathParameters['id']);
          return module == null
              ? const RouteErrorScreen()
              : ComingSoonScreen(module: module);
        },
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

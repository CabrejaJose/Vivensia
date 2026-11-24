import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_providers.dart';
import '../../features/auth/domain/auth_status.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/welcome_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/profile/application/profile_providers.dart';
import '../../features/profile/domain/entities/user_profile.dart';
import '../../features/profile/presentation/screens/onboarding_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../dev/design_system_showcase_screen.dart';
import '../navigation/app_module.dart';
import '../navigation/app_shell.dart';
import '../navigation/coming_soon_screen.dart';
import '../navigation/more_screen.dart';
import '../navigation/tab_placeholders.dart';
import 'app_routes.dart';
import 'auth_redirect.dart';
import 'route_error_screen.dart';

/// Router principal con barra inferior persistente (StatefulShellRoute) y
/// guardia de autenticación.
final appRouterProvider = Provider<GoRouter>((ref) {
  GoRoute tab(String path, Widget screen) =>
      GoRoute(path: path, builder: (context, state) => screen);

  // Estado síncrono (sesión + perfil) para la guardia; notifica al router.
  final guard = ValueNotifier<(AuthStatus?, ProfileGate)>((
    null,
    ProfileGate.loading,
  ));
  ref.listen<AsyncValue<AuthStatus>>(authStatusProvider, (_, next) {
    final status = switch (next) {
      AsyncData(:final value) => value,
      AsyncError() => const AuthSignedOut(),
      _ => guard.value.$1,
    };
    guard.value = (status, guard.value.$2);
  }, fireImmediately: true);
  ref.listen<AsyncValue<UserProfile?>>(myProfileProvider, (_, next) {
    final gate = next.isLoading && !next.hasValue
        ? ProfileGate.loading
        // Ante un error no se bloquea el acceso (la app sigue usable).
        : next.hasError
        ? ProfileGate.ready
        : next.value?.isComplete == false
        ? ProfileGate.incomplete
        : ProfileGate.ready;
    guard.value = (guard.value.$1, gate);
  }, fireImmediately: true);
  ref.onDispose(guard.dispose);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: guard,
    redirect: (context, state) => authRedirect(
      guard.value.$1,
      state.matchedLocation,
      profile: guard.value.$2,
    ),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
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

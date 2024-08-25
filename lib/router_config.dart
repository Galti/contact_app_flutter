import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/dashboard/dashboard_screen.dart';
import 'features/splash/splash_screen.dart';

part 'router_config.g.dart';

// GoRouter configuration
final routerConfig = GoRouter(
  routes: $appRoutes,
  initialLocation: '/splash-screen',
  // errorBuilder: (BuildContext context, GoRouterState state) => const NotFoundScreen(),
);

@TypedGoRoute<SplashRoute>(path: '/splash-screen')
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(context, state) => const SplashScreen();
}

@TypedGoRoute<DashboardRoute>(path: '/')
class DashboardRoute extends GoRouteData {
  const DashboardRoute();

  @override
  Widget build(context, state) => const DashboardScreen();
}

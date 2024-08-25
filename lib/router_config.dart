import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/add_contact/add_contact_screen.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/splash/splash_screen.dart';
import 'local_database/models/contact_model.dart';

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

@TypedGoRoute<AddContactRoute>(path: '/add-contact')
class AddContactRoute extends GoRouteData {
  final Contact? $extra;

  const AddContactRoute({this.$extra});

  @override
  Widget build(context, state) {
    final contact = state.extra != null ? state.extra as Contact : null;

    return AddContactScreen(contact: contact);
  }
}

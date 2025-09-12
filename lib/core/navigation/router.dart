import 'package:flutter/material.dart';
import 'package:geny_test/core/navigation/app_route.dart';
import 'package:go_router/go_router.dart';

import '../../feature/businesses/ui/page/business_list_page.dart';

GoRouter getRouter() {
  return GoRouter(
    redirect: (context, state) {
      final path = state.fullPath ?? AppRoute.splash.path;

      if (path == AppRoute.splash.path) {
        // Don't redirect from splash page
        return null;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => Container(),
      ),
      GoRoute(
        path: AppRoute.businesses.path,
        name: AppRoute.businesses.name,
        builder: (context, state) => BusinessListPage(),
      ),
    ],
  );
}

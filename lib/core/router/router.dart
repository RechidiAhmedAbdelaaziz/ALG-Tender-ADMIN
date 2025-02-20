// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/features/auth/configs/auth.route.dart';
import 'package:tender_admin/features/auth/data/sources/auth.cache.dart';
import 'package:tender_admin/features/auth/module/login/ui/screen/login.screen.dart';
import 'package:tender_admin/features/home/configs/home.route.dart';
import 'package:tender_admin/features/tender/modules/tenderlist/view/tenders.screen.dart';

import '../di/locator.dart';

part 'route_base.dart';
part 'navigator_base.dart';

class AppRouter {
  final routerConfig = GoRouter(
    initialLocation: TendersScreen.route,
    routes: _generateRoutes(),
    debugLogDiagnostics: true,
    redirect: _handelRedirect,
  );

  void to(AppNavigatorBase navigator) => navigator._to();
  void off(AppNavigatorBase navigator) => navigator._off();
  void offAll(AppNavigatorBase navigator) => navigator._offAll();

  static List<RouteBase> _generateRoutes() {
    final bases = <AppRouteBase>[
      AuthRoute.login(),
      HomeRoute(),
    ];
    return bases.map((base) => base.route).toList();
  }

  static FutureOr<String?> _handelRedirect(context, state) async {
    final authCache = locator<AuthCache>();
    if (await authCache.isAuth) return null;
    return LoginScreen.route;
  }
}

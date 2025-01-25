// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../di/locator.dart';

part 'route_base.dart';
part 'navigator_base.dart';

class AppRouter {
  final routerConfig = GoRouter(
    routes: _generateRoutes(),
    debugLogDiagnostics: true,
    redirect: _handelRedirect,
  );

  void to(AppNavigatorBase navigator) => navigator._to();
  void off(AppNavigatorBase navigator) => navigator._off();
  void offAll(AppNavigatorBase navigator) => navigator._offAll();

  static List<RouteBase> _generateRoutes() {
    final bases = <AppRouteBase>[];
    return bases.map((base) => base.route).toList();
  }

  static FutureOr<String?> _handelRedirect(context, state) {
    //TODO implement redirect
    throw UnimplementedError();
  }
}

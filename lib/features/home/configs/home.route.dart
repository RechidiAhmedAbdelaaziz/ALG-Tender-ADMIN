import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/router/routes.dart';

import '../ui/screen/home.screen.dart';

class HomeRoute extends AppRouteBase {
  HomeRoute()
      : super(
          path: HomeScreen.route,
          name: AppRoutes.home,
        );

  Widget _homePageBuilder(
      BuildContext context, GoRouterState state, Widget child) {
    return HomeScreen(child);
  }

  @override
  RouteBase get route => ShellRoute(
        builder: _homePageBuilder,
        routes:[
          //TODO add nested routes here
        ],
      );
}

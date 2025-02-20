import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/router/routes.dart';
import 'package:tender_admin/features/result/config/result.route.dart';
import 'package:tender_admin/features/tender/config/tender.route.dart';

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
        routes: _buildRoutes(),
      );

  List<RouteBase> _buildRoutes() {
    return [
      //Tenders routes
      TenderRoute.tenders(),
      TenderRoute.createTender(),
      TenderRoute.updateTender(),

      //Results routes
      ResultRoute.results(),
      ResultRoute.createResult(),
      ResultRoute.updateResult(),
    ].map((e) => e.route).toList();
  }
}

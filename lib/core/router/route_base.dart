part of 'router.dart';

abstract class AppRouteBase {
  final String path;
  final String name;
  final Widget Function(BuildContext, GoRouterState)? builder;

  AppRouteBase({
    required this.path,
    required this.name,
    this.builder,
  });

  RouteBase get route => GoRoute(
        path: path,
        name: name,
        builder: builder,
      );
}

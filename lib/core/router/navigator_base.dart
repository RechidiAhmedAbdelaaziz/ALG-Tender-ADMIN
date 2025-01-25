part of 'router.dart';

abstract class AppNavigatorBase {
  final String name;
  final Map<String, String> pathParams;
  final Map<String, String> queryParams;

  AppNavigatorBase({
    required this.name,
    this.pathParams = const {},
    this.queryParams = const {},
  });

  void _to([BuildContext? context]) {
    context != null
        ? context.pushNamed(
            name,
            queryParameters: queryParams,
            pathParameters: pathParams,
          )
        : locator<AppRouter>().routerConfig.pushNamed(
              name,
              queryParameters: queryParams,
              pathParameters: pathParams,
            );
  }

  void _off([BuildContext? context]) {
    context != null
        ? context.pushReplacementNamed(
            name,
            queryParameters: queryParams,
            pathParameters: pathParams,
          )
        : locator<AppRouter>().routerConfig.pushReplacementNamed(
              name,
              queryParameters: queryParams,
              pathParameters: pathParams,
            );
  }

  void _offAll([BuildContext? context]) {
    context != null
        ? context.goNamed(
            name,
            queryParameters: queryParams,
            pathParameters: pathParams,
          )
        : locator<AppRouter>().routerConfig.goNamed(
              name,
              queryParameters: queryParams,
              pathParameters: pathParams,
            );
  }
}

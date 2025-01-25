import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/core/router/router.dart';

extension NavigatorExtension on BuildContext {
  Future<T?> to<T>(AppNavigatorBase route) async {
    return await pushNamed<T>(
      route.name,
      pathParameters: route.pathParams,
      queryParameters: route.queryParams,
    );
  }

  void off(AppNavigatorBase route) {
    pushReplacementNamed(
      route.name,
      pathParameters: route.pathParams,
      queryParameters: route.queryParams,
    );
  }

  void offAll(AppNavigatorBase route) {
    goNamed(
      route.name,
      pathParameters: route.pathParams,
      queryParameters: route.queryParams,
    );
  }

  void back<T>([T? result]) => pop(result); 
}

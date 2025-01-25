part of 'dio_interceptors.dart';

class _AuthTokenInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    // final accessToken = await authCacheHelper.accessToken;
    //       options.headers['Authorization'] = 'Bearer $accessToken';
    //       return handler.next(options);
  }

  _AuthTokenInterceptor._();

  static _AuthTokenInterceptor get instance =>
      _AuthTokenInterceptor._();
}

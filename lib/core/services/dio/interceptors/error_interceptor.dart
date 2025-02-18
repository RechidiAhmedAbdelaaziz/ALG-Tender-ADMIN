part of 'dio_interceptors.dart';

class DioErrorInterceptor extends InterceptorsWrapper {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    //       if (error.response?.statusCode == 401) {
    //         final refreshToken = await authCacheHelper.refreshToken;

    //         if (refreshToken != null) {
    //           final authCubit = locator<AuthCubit>();
    //           await authCubit.refreshToken(refreshToken);

    //           return handler
    //               .resolve(await _dio!.fetch(error.requestOptions));
    //         }
    //       }

    //       return handler.next(error);
    //     },
    //   );
    // }
    super.onError(err, handler);
  }

  DioErrorInterceptor._();

  static DioErrorInterceptor get instance => DioErrorInterceptor._();
}

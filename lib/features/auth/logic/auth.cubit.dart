import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/network/models/api_response.model.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/services/dio/interceptors/dio_interceptors.dart';

import '../configs/auth.navigator.dart';
import '../data/repositories/auth.repo.dart';
import '../data/sources/auth.cache.dart';

part 'auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _authCache = locator<AuthCache>();
  final _router = locator<AppRouter>();
  final _authRepo = locator<AuthRepo>();
  final _dio = locator<Dio>();

  AuthCubit() : super(AuthState()) {
    checkAuthentication();
  }

  bool get isAuthenticated => state.isAuthenticated;

  void checkAuthentication() async {
    final tokens = [
      await _authCache.accessToken,
      await _authCache.refreshToken,
    ];

    if (tokens.any((element) => element == null)) {
      emit(state.copyWith(isAuthenticated: false));
      return;
    }

    _dio.addAuthTokenInterceptor();
    emit(state.copyWith(isAuthenticated: true));
  }

  Future<void> authenticate(AuthTokens tokens) async {
    await _authCache.setTokens(tokens);
    _dio.addAuthTokenInterceptor();
    emit(state.copyWith(isAuthenticated: true));
  }

  void logout() async {
    await _authCache.clearTokens();
    _dio.removeAuthTokenInterceptor();
    emit(state.copyWith(isAuthenticated: false));
    _router.offAll(AuthNavigator.login());
  }

  Future<void> refreshToken(String refreshToken) async {
    final result = await _authRepo.refreshToken(refreshToken);
    result.when(
      success: (tokens) => authenticate(tokens),
      error: (error) => logout(),
    );
  }
}

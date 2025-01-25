// ignore_for_file: library_private_types_in_public_api

part of 'login.cubit.dart';

enum _LoginStatus {
  initial,
  loading,
  loaded,
  error,
}

class LoginState extends ErrorState {
  final _LoginStatus _status;
  final LoginDto params;
  final AuthTokens? _tokens;

  LoginState(
      {_LoginStatus status = _LoginStatus.initial,
      LoginDto? params,
      String? error,
      AuthTokens? tokens})
      : _tokens = tokens,
        _status = status,
        params = params ?? LoginDto(),
        super(error);

  factory LoginState.initial() => LoginState();

  LoginState loading() => _copyWith(status: _LoginStatus.loading);
  LoginState loaded(AuthTokens tokens) => _copyWith(
        status: _LoginStatus.loaded,
        tokens: tokens,
      );

  LoginState error(String error) =>
      _copyWith(error: error, status: _LoginStatus.error);

  LoginState _copyWith({
    _LoginStatus? status,
    LoginDto? params,
    String? error,
    AuthTokens? tokens,
  }) {
    return LoginState(
      tokens: tokens ?? _tokens,
      status: status ?? _status,
      params: params ?? this.params,
      error: error,
    );
  }

  bool get isLoading => _status == _LoginStatus.loading;

  void onLoginSuccess(Function(AuthTokens tokens) handler) {
    if (_tokens != null) handler(_tokens);
  }
}

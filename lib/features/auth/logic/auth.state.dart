part of 'auth.cubit.dart';

class AuthState {
  final bool isAuthenticated;

  AuthState({this.isAuthenticated = false});

  AuthState copyWith({bool? isAuthenticated}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
  
}
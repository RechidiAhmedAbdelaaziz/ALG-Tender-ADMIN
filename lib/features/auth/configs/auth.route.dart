import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/router/routes.dart';
import 'package:tender_admin/features/auth/module/login/logic/login.cubit.dart';

import '../module/login/ui/screen/login.screen.dart';

class AuthRoute extends AppRouteBase {
  AuthRoute.login()
      : super(
          builder: _loginPageBuilder,
          path: LoginScreen.route,
          name: AppRoutes.login,
        );

  static Widget _loginPageBuilder(context, state) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginScreen(),
    );
  }
}

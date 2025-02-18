import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/extension/snackbar.extension.dart';
import 'package:tender_admin/core/extension/validator.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/widgets/text_form_field.dart';
import 'package:tender_admin/features/tender/config/tender.navigator.dart';

import '../../../../logic/auth.cubit.dart';
import '../../logic/login.cubit.dart';

part '../widget/submit_button.dart';
part '../widget/login_form.dart';
part '../widget/header.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goToHome() => context.to(TenderNavigator.createTender());

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        state.onError(context.showErrorSnackbar);
        state.onLoginSuccess((tokens) async {
          await locator<AuthCubit>().authenticate(tokens);
          goToHome();
        });
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff8f8f8),
        body: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 274.w, vertical: 110.h),
          padding:
              EdgeInsets.symmetric(horizontal: 56.w, vertical: 172.h),
          color: Colors.white,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _Header(),
              const Spacer(),
              const _LoginForm(),
              heightSpace(40),
              const _SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

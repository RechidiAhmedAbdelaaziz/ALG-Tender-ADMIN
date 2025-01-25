part of '../screen/login.screen.dart';

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    final key = cubit.formKey;
    final emailController = cubit.state.params.email;
    final passwordController = cubit.state.params.password;
    return Form(
      key: key,
      child: Column(
        children: [
          AppTextFormField(
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email),
            validator: (value) =>
                value.isValidEmail ? null : 'Incorrect email',
          ),
          heightSpace(40),
          AppTextFormField(
            controller: passwordController,
            hintText: 'Password',
            prefixIcon: const Icon(Icons.lock),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) =>
                value.isValidPassword ? null : 'Incorrect password',
          ),
        ],
      ),
    );
  }
}

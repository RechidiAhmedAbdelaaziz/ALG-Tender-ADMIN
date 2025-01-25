part of '../screen/login.screen.dart';

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((LoginCubit cubit) => cubit.state.isLoading);
    return InkWell(
      onTap: () {
        context.read<LoginCubit>().login();
      },
      child: Stack(
        children: [
          Container(
            width: 780.w,
            height: 66.h,
            decoration: const BoxDecoration(
              color: Color(0xff005ce8),
            ),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.spMax,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

part of '../screen/login.screen.dart';

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Login with',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.spMax,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: ' DZtenders',
            style: TextStyle(
              color: const Color(0xff005ce8),
              fontSize: 24.spMax,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      style: TextStyle(
        color: Colors.black,
        fontSize: 24.spMax,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

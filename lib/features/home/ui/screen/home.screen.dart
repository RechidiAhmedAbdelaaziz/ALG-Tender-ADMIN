import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/router/routes.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/core/themes/icons.dart';
import 'package:tender_admin/features/auth/logic/auth.cubit.dart';


part '../widget/drawer.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/';
  const HomeScreen(this._child, {super.key});

  final Widget _child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [const _Drawer(), Expanded(child: _child)],
      ),
    );
  }
}

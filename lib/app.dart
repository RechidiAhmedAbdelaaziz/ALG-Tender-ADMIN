import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/locator.dart';
import 'core/router/router.dart';

class TenderApp extends StatelessWidget {
  const TenderApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        final AppRouter router = locator();
        return FlavorBanner(
          child: MaterialApp.router(
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            theme: ThemeData(
              fontFamily: 'Poppins',
            ),
            routerConfig: router.routerConfig,
          ),
        );
      },
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/features/announcer/modules/multiannouncers/logic/multi_announcer.cubit.dart';
import 'package:tender_admin/features/announcer/modules/multiannouncers/ui/announcers.dart';
import 'package:tender_admin/features/learn/learn.widget.dart';

void main() async {
  // ensure initializeApp is called
  WidgetsFlutterBinding.ensureInitialized();

  FlavorConfig(
    name: "TEST",
    color: Colors.red,
    location: BannerLocation.bottomEnd,
    variables: {
      "baseUrl": "http://localhost:3000",
    },
  );

  await ScreenUtil.ensureScreenSize();

  await setupLocator();

  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return FlavorBanner(
          child: MaterialApp(
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            theme: ThemeData(fontFamily: 'Poppins'),
            home: Scaffold(
              appBar: AppBar(
                title: const Text('Test App'),
              ),
              body: Builder(builder: (context) {
                return Center(
                  child: IconButton(
                      onPressed: () {
                        context.dialog(
                          child: BlocProvider(
                            create: (context) =>
                                MultiAnnouncerCubit()..load(),
                            child: Announcers(
                              onSelecte: (model) => print(model),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.add)),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

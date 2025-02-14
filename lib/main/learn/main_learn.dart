import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';
import 'package:tender_admin/features/sources/modules/sourceform/source_form.dart';

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
                  child: Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.dialogWith<SourceDTO>(
                            child: SizedBox(
                              height: 850.h,
                              width: 600.w,
                              child: SourceForm(
                                  // update: true,
                                  // source: UpdateSourceDto(
                                  //   SourceModel(
                                  //     images: [
                                  //       RemoteImageDTO(
                                  //           url:
                                  //               'https://i.pinimg.com/236x/de/6e/78/de6e787cb977a1a6882c83c38813e4a2.jpg')
                                  //     ],
                                  //     newspaper: NewsPaperModel(
                                  //       id: '1',
                                  //       name: 'Test',
                                  //       imageUri:
                                  //           'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWm7ZTeuzMAcQrsMg1hirVRWXdJQtIHiv_KA&s',
                                  //     ),
                                  //   ),
                                  // ),
                                  ),
                            ),
                            onResult: (dto) {
                              print(dto);
                            },
                          );
                        },
                        icon: Icon(Icons.ac_unit_sharp),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/services/dio/dio.service.dart';

part 'dependecy_base.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // SharedPreferences and FlutterSecureStorage
  locator.registerSingletonAsync(
      () async => await SharedPreferences.getInstance());
  locator.registerLazySingleton(() => FlutterSecureStorage());

  //Dio
  locator.registerLazySingleton(() => DioService.getDio());

  //Router
  locator.registerSingleton(AppRouter());

  await DependecyBase._init();

  locator.allowReassignment = true;
}

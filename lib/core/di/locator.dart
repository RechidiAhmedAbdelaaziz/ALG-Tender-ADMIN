import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/services/cloudstorage/cloud_storage.service.dart';
import 'package:tender_admin/core/services/cloudstorage/cloudinary/cloudinary.service.dart';
import 'package:tender_admin/core/services/dio/dio.service.dart';
import 'package:tender_admin/features/announcer/config/announcer.dependency.dart';
import 'package:tender_admin/features/auth/configs/auth.dependency.dart';

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

  //Cloud storage service
  locator.registerLazySingleton<CloudinaryService>(() =>
      kIsWeb ? WebCloudinaryService() : MobileCloudinaryService());
      
  locator.registerLazySingleton<CloudStorageService>(
      () => locator<CloudinaryService>());

  await DependecyBase._init();

  locator.allowReassignment = true;
}

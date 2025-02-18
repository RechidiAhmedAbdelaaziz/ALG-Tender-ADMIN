import 'package:flutter/foundation.dart';
import 'package:tender_admin/core/di/locator.dart';

import '../data/repositories/auth.repo.dart';
import '../data/sources/auth.api.dart';
import '../data/sources/auth.cache.dart';
import '../logic/auth.cubit.dart';

class AuthDependency extends FeaturesDependency {
  @override
  void init() async {
    locator.registerLazySingleton(() => AuthApi(locator()));
    locator.registerLazySingleton(() => AuthRepo());
    locator.registerLazySingleton(
        () => kIsWeb ? WebAuthCache() : SecureAuthCache());
    locator.registerSingleton(AuthCubit());
  }
}

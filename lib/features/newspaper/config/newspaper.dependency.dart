import 'package:dio/dio.dart';
import 'package:tender_admin/core/di/locator.dart';

import '../data/repository/newspaper.repo.dart';
import '../data/source/newspaper.api.dart';

class NewspaperDependency extends FeaturesDependency {
  @override
  void init() {
    locator.registerLazySingleton<NewsPaperApi>(
        () => NewsPaperApi(locator<Dio>()));
    locator
        .registerLazySingleton<NewsPaperRepo>(() => NewsPaperRepo());
  }
}

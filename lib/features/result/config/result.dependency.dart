import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/features/result/data/repository/result.repo.dart';
import 'package:tender_admin/features/result/data/source/result.api.dart';

class ResultDependency extends FeaturesDependency {
  @override
  void init() {
    locator
        .registerLazySingleton<ResultApi>(() => ResultApi(locator()));
    locator.registerLazySingleton<ResultRepo>(() => ResultRepo());
  }
}

import 'package:tender_admin/core/di/locator.dart';
import 'package:tender_admin/features/announcer/data/source/announcer.api.dart';

import '../data/repository/announcer.repo.dart';

class AnnouncerDependency extends FeaturesDependency {
  @override
  void init() {
    locator.registerLazySingleton(() => AnnouncerApi(locator()));
    locator.registerLazySingleton(() => AnnouncerRepo());
  }
}

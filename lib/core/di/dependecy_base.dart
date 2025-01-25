part of 'locator.dart';

abstract class DependecyBase {
  void init();

  static Future<void> _init() async {
    final dependencies = <DependecyBase>[
      AuthDependency(),
      AnnouncerDependency()
    ];

    for (final dependency in dependencies) {
      dependency.init();
    }
  }
}

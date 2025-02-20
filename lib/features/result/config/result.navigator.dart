import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/router/routes.dart';

class ResultNavigator extends AppNavigatorBase {
  ResultNavigator.results(String tenderId)
      : super(
          name: AppRoutes.result,
          pathParams: {'id': tenderId},
        );

  ResultNavigator.createResult()
      : super(
          name: AppRoutes.createResult,
        );

  ResultNavigator.updateResult(String resultId)
      : super(
          name: AppRoutes.updateResult,
          pathParams: {'id': resultId},
        );
}

import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/router/routes.dart';

class TenderNavigator extends AppNavigatorBase {
  TenderNavigator.tenders() : super(name: AppRoutes.tender);

  TenderNavigator.createTender()
      : super(name: AppRoutes.createTender);

  TenderNavigator.updateTender(String tenderId)
      : super(
          name: AppRoutes.updateTender,
          pathParams: {'id': tenderId},
        );
}

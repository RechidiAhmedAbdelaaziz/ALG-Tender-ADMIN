import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/router/routes.dart';
import 'package:tender_admin/features/tender/modules/tenderform/logic/tender.cubit.dart';
import 'package:tender_admin/features/tender/modules/tenderform/view/tender_form.dart';
import 'package:tender_admin/features/tender/modules/tenderlist/logic/tenders.cubit.dart';
import 'package:tender_admin/features/tender/modules/tenderlist/view/tenders.screen.dart';

class TenderRoute extends AppRouteBase {
  TenderRoute.tenders()
      : super(
          name: AppRoutes.tender,
          path: TendersScreen.route,
          builder: _buildTendersScreen,
        );

  TenderRoute.createTender()
      : super(
          name: AppRoutes.createTender,
          path: '/create-tender',
          builder: _createTenderPageBuilder,
        );
  TenderRoute.updateTender()
      : super(
          name: AppRoutes.updateTender,
          path: '/update-tender/:id',
          builder: _updateTenderPageBuilder,
        );

  static Widget _buildTendersScreen(
    BuildContext context,
    GoRouterState state,
  ) {
    return BlocProvider(
      create: (context) => TendersCubit()..loadTenders(),
      child: TendersScreen(),
    );
  }

  static Widget _createTenderPageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    return BlocProvider(
      create: (context) => TenderCubit()..loadTender(),
      child: TenderForm(),
    );
  }

  static Widget _updateTenderPageBuilder(
    BuildContext context,
    GoRouterState state,
  ) {
    final id = state.pathParameters['id'];
    return BlocProvider(
      create: (context) => TenderCubit()..loadTender(id),
      child: TenderForm(),
    );
  }
}

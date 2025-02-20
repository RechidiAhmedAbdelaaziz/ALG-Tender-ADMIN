import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/core/router/router.dart';
import 'package:tender_admin/core/router/routes.dart';
import 'package:tender_admin/features/result/module/multiresult/logic/multi_result.cubit.dart';
import 'package:tender_admin/features/result/module/multiresult/view/tender_results.dart';
import 'package:tender_admin/features/result/module/singleresult/logic/single_result.cubit.dart';
import 'package:tender_admin/features/result/module/singleresult/view/result_form.dart';

class ResultRoute extends AppRouteBase {
  ResultRoute.results()
      : super(
          path: TenderResults.route,
          name: AppRoutes.result,
          builder: _buildTenderResults,
        );

  ResultRoute.createResult()
      : super(
          path: '/create-result',
          name: AppRoutes.createResult,
          builder: _createResultPageBuilder,
        );

  ResultRoute.updateResult()
      : super(
          path: '/update-result/:id',
          name: AppRoutes.updateResult,
          builder: _updateResultPageBuilder,
        );

  static Widget _buildTenderResults(
      BuildContext context, GoRouterState state) {
    final tenderId = state.pathParameters['id'];
    return BlocProvider(
      create: (context) =>
          MultiResultCubit(tenderId!)..loadResults(13),
      child: const TenderResults(),
    );
  }

  static Widget _createResultPageBuilder(
      BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => SingleResultCubit()..loadResult(),
      child: const ResultForm(),
    );
  }

  static Widget _updateResultPageBuilder(
      BuildContext context, GoRouterState state) {
    final id = state.pathParameters['id'];
    return BlocProvider(
      create: (context) => SingleResultCubit()..loadResult(id),
      child: const ResultForm(),
    );
  }
}

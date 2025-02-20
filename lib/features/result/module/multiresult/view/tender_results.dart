import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/date_formatter.extension.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/widgets/list_items.dart';
import 'package:tender_admin/features/result/config/result.navigator.dart';
import 'package:tender_admin/features/result/data/models/result.model.dart';
import 'package:tender_admin/features/result/module/multiresult/logic/multi_result.cubit.dart';

class TenderResults extends StatelessWidget {
  static const route = '/tender/:id/results';
  const TenderResults({super.key});

  @override
  Widget build(BuildContext context) {
    return ListItems(
      items: context
          .select((MultiResultCubit cubit) => cubit.state.results),
      flexItems: flexItems,
      onAdd: () => context.to(ResultNavigator.createResult()),
      searchController:
          context.read<MultiResultCubit>().filters.keyword,
      onSearch: () =>
          context.read<MultiResultCubit>().filterResults(),
      onLoad: () => context.read<MultiResultCubit>().loadResults(),
      isLoading: context
          .select((MultiResultCubit cubit) => cubit.state.isLoading),
    );
  }

  List<FlexItem<ResultModel>> get flexItems => [
        FlexItem<ResultModel>(
          builder: (ResultModel result) => _buildTitle(result),
          header: _buildHeaderTitle('Titre'),
          flex: 4,
        ),
        FlexItem<ResultModel>(
          builder: (ResultModel result) => _buildInfo(result.region!),
          header: _buildHeaderTitle('Region'),
          flex: 2,
        ),
        FlexItem<ResultModel>(
          builder: (ResultModel result) => _buildInfo(result.type!),
          header: _buildHeaderTitle('Type'),
          flex: 2,
        ),
        FlexItem<ResultModel>(
          builder: (ResultModel result) =>
              _buildInfo(result.publishedDate!.toDayMonthYear()),
          header: _buildHeaderTitle('Date de publication'),
          flex: 2,
        ),
        FlexItem<ResultModel>(
          builder: (ResultModel tender) => Stack(
            children: [
              PopupMenuButton(
                itemBuilder: (context) =>
                    _optionsMenu(context, tender),
              ),
            ],
          ),
          header: _buildHeaderTitle(''),
        ),
      ];

  List<PopupMenuItem> _optionsMenu(
          BuildContext context, ResultModel result) =>
      [
        PopupMenuItem(
          child: Row(children: [Icon(Icons.edit), Text('Modifier')]),
          onTap: () =>
              context.to(ResultNavigator.updateResult(result.id!)),
        ),
        PopupMenuItem(
          child:
              Row(children: [Icon(Icons.delete), Text('Supprimer')]),
          onTap: () => context.alertDialog(
            title: 'Supprimer',
            content:
                'Voulez-vous vraiment supprimer ce appel d\'offre?',
            onConfirm: () =>
                context.read<MultiResultCubit>().deleteResult(result),
          ),
        ),
      ];

  Widget _buildHeaderTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.spMax,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildTitle(ResultModel result) {
    final tender = result.tender!;
    return Row(
      children: [
        Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            image: DecorationImage(
              image: NetworkImage(tender.announcer?.imageUri ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        widthSpace(10),
        Expanded(
          child: Text(
            result.title!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.spMax,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        if (tender.announcer?.isStartup == true)
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            margin: EdgeInsetsDirectional.only(end: 10.w),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 188, 243, 190),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'Startup',
              style: TextStyle(
                fontSize: 12.spMax,
                color: const Color.fromARGB(255, 1, 90, 6),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfo(String info) => Text(
        info,
        style: TextStyle(
          fontSize: 16.spMax,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      );
}

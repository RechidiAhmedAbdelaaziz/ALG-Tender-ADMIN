import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/date_formatter.extension.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/widgets/check_box.dart';
import 'package:tender_admin/core/shared/widgets/drop_down_menu.dart';
import 'package:tender_admin/core/shared/widgets/list_items.dart';
import 'package:tender_admin/core/shared/widgets/multi_drop_down_menu.dart';
import 'package:tender_admin/core/shared/widgets/submit_button.dart';
import 'package:tender_admin/features/announcer/modules/singleannouncer/ui/selected_announcer.dart';
import 'package:tender_admin/features/result/config/result.navigator.dart';
import 'package:tender_admin/features/tender/config/tender.navigator.dart';
import 'package:tender_admin/features/tender/data/dto/tender_filters.dto.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';

import '../logic/tenders.cubit.dart';

part '../widgets/tender_filter.dart';

class TendersScreen extends StatelessWidget {
  static const String route = '/tenders';
  const TendersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListItems(
      items:
          context.select((TendersCubit cubit) => cubit.state.tenders),
      flexItems: _flexItems(),
      onAdd: () async {
        final tender = await context
            .to<TenderModel>(TenderNavigator.createTender());
        if (tender != null) {
          // ignore: use_build_context_synchronously
          context.read<TendersCubit>().addTender(tender);
        }
      },
      searchController: context.read<TendersCubit>().filters.keyword,
      onSearch: () => context.read<TendersCubit>().filterTenders(),
      onLoad: () => context.read<TendersCubit>().loadTenders(),
      isLoading: context
          .select((TendersCubit cubit) => cubit.state.isLoading),
      showFilter: () {
        context.dialogWith<bool>(
          child: _Filters(context.read<TendersCubit>().filters),
          onResult: (_) =>
              context.read<TendersCubit>().filterTenders(),
          autoBack: false,
        );
      },
    );
  }

  List<FlexItem<TenderModel>> _flexItems() => [
        FlexItem<TenderModel>(
          builder: (TenderModel tender) => _buildTitle(tender),
          header: _buildHeaderTitle('Titre'),
          flex: 4,
        ),
        FlexItem<TenderModel>(
          builder: (TenderModel tender) => _buildInfo(tender.region!),
          header: _buildHeaderTitle('Region'),
          flex: 2,
        ),
        FlexItem<TenderModel>(
          builder: (TenderModel tender) =>
              _buildInfo(tender.industry!),
          header: _buildHeaderTitle('Secteur'),
          flex: 2,
        ),
        FlexItem<TenderModel>(
          builder: (TenderModel tender) =>
              _buildInfo(tender.marketType!),
          header: _buildHeaderTitle('Type de marché'),
          flex: 2,
        ),
        FlexItem<TenderModel>(
          builder: (TenderModel tender) =>
              _buildInfo(tender.closingDate!.toDayMonthYear()),
          header: _buildHeaderTitle('Échéance (*)'),
          flex: 2,
        ),
        FlexItem<TenderModel>(
          builder: (TenderModel tender) => Stack(
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
          BuildContext context, TenderModel tender) =>
      [
        PopupMenuItem(
          child: Row(children: [Icon(Icons.edit), Text('Modifier')]),
          onTap: () =>
              context.off(TenderNavigator.updateTender(tender.id!)),
        ),
        PopupMenuItem(
          child:
              Row(children: [Icon(Icons.delete), Text('Supprimer')]),
          onTap: () => context.alertDialog(
            title: 'Supprimer',
            content:
                'Voulez-vous vraiment supprimer ce appel d\'offre?',
            onConfirm: () =>
                context.read<TendersCubit>().deleteTender(tender),
          ),
        ),
        PopupMenuItem(
          child: Row(children: [
            Icon(Icons.info_outline),
            Text('Voir les résultats')
          ]),
          onTap: () =>
              context.off(ResultNavigator.results(tender.id!)),
        ),
      ];

  Widget _buildHeaderTitle(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16.spMax,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildTitle(TenderModel tender) => Row(
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
              tender.title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.spMax,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (tender.announcer?.isStartup == true)
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.w, vertical: 4.h),
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

  Widget _buildInfo(String info) => Text(
        info,
        style: TextStyle(
          fontSize: 16.spMax,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      );
}

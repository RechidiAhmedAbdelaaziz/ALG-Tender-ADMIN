import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/extension/snackbar.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/widgets/pagination_builder.dart';
import 'package:tender_admin/core/shared/widgets/search_bar.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/announcer/modules/singleannouncer/logic/announcer.cubit.dart';

import '../logic/multi_announcer.cubit.dart';
import '../../singleannouncer/ui/announcer.dart';

part 'announcers_list.dart';

class Announcers extends StatelessWidget {
  final ValueChanged<AnnouncerModel> onSelecte;
  const Announcers({super.key, required this.onSelecte});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MultiAnnouncerCubit>();
    return BlocListener<MultiAnnouncerCubit, MultiAnnouncerState>(
      listener: (context, state) {
        state.onError(context.showErrorSnackbar);
      },
      child: Container(
        width: 800.w,
        height: 800.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            _buildHeader(
              'Announcers',
              onAdd: () async {
                await context.dialogWith<AnnouncerModel>(
                  child: BlocProvider<AnnouncerCubit>(
                      create: (_) => CreateAnnouncerCubit()),
                  onResult: cubit.add,
                );
              },
            ),
            heightSpace(15),
            KSearchBar(
              controller: cubit.searchController,
              onSearch: cubit.search,
            ),
            heightSpace(20),
            Expanded(child: _AnnouncersList(onSelecte: onSelecte)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title, {VoidCallback? onAdd}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20.spMax,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (onAdd != null)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAdd,
          ),
      ],
    );
  }
}

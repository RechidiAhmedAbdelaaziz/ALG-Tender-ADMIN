import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/extension/snackbar.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/widgets/pagination_builder.dart';
import 'package:tender_admin/core/shared/widgets/search_bar.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';
import 'package:tender_admin/features/tender/modules/tenderlist/logic/tenders.cubit.dart';

class TendersSelector extends StatelessWidget {
  const TendersSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TendersCubit()..loadTenders(),
      child: Builder(builder: (context) {
        final cubit = context.read<TendersCubit>();
        return BlocListener<TendersCubit, TendersState>(
          listener: (context, state) {
            state.onError(context.showErrorSnackbar);
          },
          child: Container(
            width: 500.w,
            height: 800.h,
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Column(
              children: [
                _buildHeader('Announcers'),
                heightSpace(15),
                KSearchBar(
                  controller: cubit.filters.keyword,
                  onSearch: cubit.filterTenders,
                ),
                heightSpace(20),
                Expanded(child: _TendersList()),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 20.spMax,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _TendersList extends StatelessWidget {
  const _TendersList();

  @override
  Widget build(BuildContext context) {
    final tenders = context.watch<TendersCubit>().state.tenders;
    return PaginationBuilder(
      items: tenders,
      itemBuilder: (tender) =>
          _buildTender(tender, () => context.back(tender)),
      separator: heightSpace(10),
      onLoadMore: context.read<TendersCubit>().loadTenders,
      isLoading: context
          .select((TendersCubit cubit) => cubit.state.isLoading),
    );
  }

  Widget _buildTender(TenderModel tender, void Function() onSelecte) {
    return InkWell(
      onTap: onSelecte,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.r),
                image: DecorationImage(
                  image:
                      NetworkImage(tender.announcer?.imageUri ?? ''),
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
        ),
      ),
    );
  }
}

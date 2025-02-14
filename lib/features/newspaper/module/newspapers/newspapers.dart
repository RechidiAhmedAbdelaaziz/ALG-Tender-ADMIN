import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/widgets/pagination_builder.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/features/newspaper/data/dto/newspaper.dto.dart';
import 'package:tender_admin/features/newspaper/data/models/newspaper.model.dart';
import 'package:tender_admin/features/newspaper/module/newspaperform/newspaper_form.dart';

import '../../logic/newspaper.cubit.dart';

class NewsPapers extends StatelessWidget {
  const NewsPapers({super.key});

  @override
  Widget build(BuildContext context) {
    final newspapers =
        context.watch<NewsPaperCubit>().state.newspapers;

    return SizedBox(
      height: 110.h,
      child: PaginationBuilder(
        items: newspapers,
        isLoading: context
            .select((NewsPaperCubit cubit) => cubit.state.isLoading),
        scrollDirection: Axis.horizontal,
        onLoadMore: context.read<NewsPaperCubit>().getNewsPapers,
        itemBuilder: (newspaper) =>
            NewsPaper(newspaper, canSelect: true),
        separator: widthSpace(12),
        onAdd: () {
          context.dialogWith<CreateNewspaperDto>(
            child: NewspaperForm(),
            onResult: context.read<NewsPaperCubit>().createNewsPaper,
          );
        },
      ),
    );
  }
}

class NewsPaper extends StatelessWidget {
  final NewsPaperModel newspaper;
  final bool _canSelect;

  const NewsPaper(
    this.newspaper, {
    super.key,
    bool canSelect = false,
  }) : _canSelect = canSelect;

  @override
  Widget build(BuildContext context) {
    final isSelected = _canSelect &&
        context.select((NewsPaperCubit cubit) =>
                cubit.state.selectedNewspaper) ==
            newspaper;
    return InkWell(
      onTap: _canSelect
          ? () => context
              .read<NewsPaperCubit>()
              .selectNewsPaper(newspaper)
          : null,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? KColors.primary.withAlpha(150)
                  : Colors.white,
              border: Border.all(
                  color: isSelected ? KColors.primary : Colors.grey),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                      image: NetworkImage(newspaper.imageUri ?? ''),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: context
                          .watch<NewsPaperCubit>()
                          .state
                          .isUpdating(newspaper)
                      ? SizedBox(
                          height: 45.h,
                          child: LinearProgressIndicator(
                              color: KColors.primary),
                        )
                      : null,
                ),
                heightSpace(10),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color:
                            isSelected ? Colors.white : Colors.black,
                      ),
                      onPressed: () {
                        context.dialogWith<UpdateNewspaperDto>(
                          child: NewspaperForm(newspaper: newspaper),
                          onResult: context
                              .read<NewsPaperCubit>()
                              .updateNewsPaper,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => context.alertDialog(
                        title: 'Supprimer',
                        content:
                            'Voulez-vous vraiment supprimer ce journal ?',
                        onConfirm: () {
                          context
                              .read<NewsPaperCubit>()
                              .deleteNewsPaper(newspaper);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

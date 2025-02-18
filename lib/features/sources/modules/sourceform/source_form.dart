import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/module/images/multiimages/images.dart';
import 'package:tender_admin/core/shared/module/images/multiimages/logic/images.cubit.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/features/newspaper/logic/newspaper.cubit.dart';
import 'package:tender_admin/features/newspaper/module/newspapers/newspapers.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';

class SourceForm extends StatelessWidget {
  final SourceDTO source;
  final bool isNew;
  SourceForm({super.key, SourceDTO? source, bool update = false})
      : source = source ??
            (update ? UpdateSourceDto.empty() : CreateSourceDTO()),
        isNew = source?.newsPaper == null;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = NewsPaperCubit();
            isNew
                ? cubit.getNewsPapers()
                : cubit.selectNewsPaper(source.newsPaper!);
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) => ImagesCubit(source.images),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(20.w),
        width: 500.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            isNew ? NewsPapers() : NewsPaper(source.newsPaper!),
            ImagesWidget(
              dimensions: Dimensions(
                width: 300.w,
                height: 500.h,
                radius: 25.r,
              ),
            ),
            Builder(builder: (context) {
              final isValid = context
                  .select(
                      (ImagesCubit cubit) => cubit.state.imageCubits)
                  .isNotEmpty;
              return InkWell(
                onTap: () {
                  source.updateImages(
                      context.read<ImagesCubit>().state.images);

                  source.updateNewsPaper(
                    context
                        .read<NewsPaperCubit>()
                        .state
                        .selectedNewspaper,
                  );

                  Navigator.of(context).pop(source);
                },
                child: Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    color: !isValid ? Colors.grey : KColors.primary,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Center(
                    child: Text(
                      isNew ? 'Ajouter' : 'Modifier',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

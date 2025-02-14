import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/image.dart';
import 'package:tender_admin/core/shared/widgets/pagination_builder.dart';
import 'package:tender_admin/features/newspaper/module/newspapers/newspapers.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';
import 'package:tender_admin/features/sources/logic/source.cubit.dart';
import 'package:tender_admin/features/sources/modules/sourceform/source_form.dart';

class SourcesWidget extends StatelessWidget {
  final bool isNew;
  const SourcesWidget({super.key, this.isNew = false});

  @override
  Widget build(BuildContext context) {
    final sources =
        context.select((SourceCubit cubit) => cubit.state.sources);
    return SizedBox(
      height: 400.h,
      child: PaginationBuilder(
        items: sources,
        itemBuilder: (dto) => SourceWidget(source: dto),
        scrollDirection: Axis.horizontal,
        separator: widthSpace(8),
        onAdd: () {
          context.dialogWith<SourceDTO>(
            child: SourceForm(update: !isNew),
            onResult: context.read<SourceCubit>().addSource,
          );
        },
      ),
    );
  }
}

class SourceWidget extends StatelessWidget {
  final SourceDTO source;
  const SourceWidget({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  context.dialogWith<SourceDTO>(
                    child: SourceForm(source: source),
                    onResult:
                        context.watch<SourceCubit>().replaceSource,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context.watch<SourceCubit>().removeSource(source);
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          NewsPaper(source.newsPaper!),
          SizedBox(
            width: 200.w,
            height: 300.h,
            child: ListView.separated(
              itemCount: source.images.length,
              itemBuilder: (context, index) {
                final image = source.images[index];
                return ImageWidget(
                  height: 500.h,
                  width: 300.w,
                  radius: 25.r,
                  imageDTO: image,
                  canEdit: false,
                  canRemove: false,
                );
              },
              separatorBuilder: (context, index) => widthSpace(5),
            ),
          )
        ],
      ),
    );
  }
}

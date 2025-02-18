import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/image.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/logic/image.cubit.dart';
import 'package:tender_admin/core/shared/widgets/pagination_builder.dart';
import 'package:tender_admin/features/newspaper/logic/newspaper.cubit.dart';
import 'package:tender_admin/features/newspaper/module/newspapers/newspapers.dart';
import 'package:tender_admin/features/sources/data/dto/source.dto.dart';
import 'package:tender_admin/features/sources/logic/source.cubit.dart';
import 'package:tender_admin/features/sources/modules/sourceform/source_form.dart';

class SourcesWidget extends StatelessWidget {
  final bool isNew;
  final ValueChanged<SourceDTO>? onAdd;
  final ValueChanged<SourceDTO>? onEdit;
  final ValueChanged<SourceDTO>? onDelete;
  const SourcesWidget(
      {super.key,
      this.isNew = false,
      this.onAdd,
      this.onEdit,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    final sources = context.watch<SourceCubit>().state.sources;
    return SizedBox(
      height: 700.h,
      child: PaginationBuilder(
        items: sources,
        itemBuilder: (dto) => SourceWidget(source: dto),
        scrollDirection: Axis.horizontal,
        separator: widthSpace(8),
        onAdd: () {
          context.dialogWith<SourceDTO>(
            child: SourceForm(update: !isNew),
            onResult: (dto) {
              context.read<SourceCubit>().addSource(dto);
              onAdd?.call(dto);
            },
            autoBack: false,
          );
        },
      ),
    );
  }
}

class SourceWidget extends StatelessWidget {
  final SourceDTO source;
  final ValueChanged<SourceDTO>? onEdit;
  final ValueChanged<SourceDTO>? onDelete;
  const SourceWidget(
      {super.key, required this.source, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<SourceCubit>();
    return Container(
      width: 260.w,
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
                    onResult: (dto) {
                      cubit.replaceSource(dto);
                      onEdit?.call(dto);
                    },
                    autoBack: false,
                  );
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context.alertDialog(
                    title: 'Suppression',
                    content:
                        'Voulez-vous vraiment supprimer cette source?',
                    onConfirm: () {
                      cubit.removeSource(source);
                      onDelete?.call(source);
                    },
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          BlocProvider(
            create: (context) => NewsPaperCubit(),
            child: NewsPaper(source.newsPaper!,
                canDelete: false, canEdit: false),
          ),
          heightSpace(22),
          SizedBox(
            width: 200.w,
            height: 450.h,
            child: ListView.separated(
              itemCount: source.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final image = source.images[index];
                return BlocProvider(
                  create: (context) => ImageCubit(image),
                  child: ImageWidget(
                    height: 450.h,
                    width: 200.w,
                    radius: 25.r,
                    imageDTO: image,
                    canEdit: false,
                    canRemove: false,
                  ),
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

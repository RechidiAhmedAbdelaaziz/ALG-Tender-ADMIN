import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/image.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/logic/image.cubit.dart';
import 'package:tender_admin/core/shared/widgets/text_form_field.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/features/newspaper/data/dto/newspaper.dto.dart';
import 'package:tender_admin/features/newspaper/data/models/newspaper.model.dart';

class NewspaperForm extends StatelessWidget {
  final NewspaperDto dto;
  final bool _isEditing;
  NewspaperForm({super.key, NewsPaperModel? newspaper})
      : dto = newspaper == null
            ? CreateNewspaperDto()
            : UpdateNewspaperDto(newspaper),
        _isEditing = newspaper != null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(dto.image.value),
      child: Container(
        width: 500.w,
        padding:
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _isEditing
                  ? 'Modifier le journal'
                  : 'Ajouter un journal',
              style: TextStyle(
                color: KColors.primary,
                fontSize: 20.spMax,
                fontWeight: FontWeight.bold,
              ),
            ),
            heightSpace(20),
            ImageWidget(
              width: 120.w,
              height: 100.h,
              radius: 24.r,
              onImagePicked: dto.image.setImage,
              onImageRemoved: dto.image.removeImage,
              canRemove: false,
            ),
            heightSpace(20),
            AppTextFormField(
              controller: dto.name,
              hintText: 'Nom du journal',
              title: 'Nom',
            ),
            heightSpace(25),
            Builder(builder: (context) {
              final isValid = context.select(
                (ImageCubit cubit) => cubit.state.isPicked,
              );
              return InkWell(
                onTap: () => isValid ? context.back(dto) : null,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isValid
                        ? KColors.primary
                        : KColors.primary.withAlpha(100),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    _isEditing ? 'Modifier' : 'Ajouter',
                    style: TextStyle(color: Colors.white),
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

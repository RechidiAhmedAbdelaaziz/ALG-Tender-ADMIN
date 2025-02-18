import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/extension/validator.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/image.dart';
import 'package:tender_admin/core/shared/module/images/singleimage/logic/image.cubit.dart';
import 'package:tender_admin/core/shared/widgets/check_box.dart';
import 'package:tender_admin/core/shared/widgets/submit_button.dart';
import 'package:tender_admin/core/shared/widgets/text_form_field.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/features/announcer/modules/singleannouncer/logic/announcer.cubit.dart';

class AnnouncerForm extends StatelessWidget {
  const AnnouncerForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnnouncerCubit>();
    final dto = cubit.state.dto;
    return BlocListener<AnnouncerCubit, AnnouncerState>(
      listener: (context, state) {
        state.onSaved((announcer) => context.back(announcer));
      },
      child: Container(
        width: 500.w,
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10.h,
          children: [
            BlocProvider(
              create: (context) =>
                  ImageCubit(cubit.state.dto.image.value),
              child: ImageWidget(
                height: 120.r,
                width: 120.r,
                radius: 360,
                onImagePicked: (image) {
                  dto.image.setImage(image);
                },
                canRemove: false,
              ),
            ),
            AppTextFormField(
              controller: dto.name,
              title: 'Le nom de l\'annonceur',
              validator: (value) {
                return value.isValidName
                    ? 'Le nom de l\'annonceur est requis'
                    : null;
              },
            ),
            AppCheckBox(
              controller: dto.isStartup,
              title: 'Est une startup',
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SubmitButton(
                  title: 'Annuler',
                  onTap: () => context.back(),
                  color: Colors.white,
                  textColor: KColors.primary,
                ),
                widthSpace(12),
                Builder(
                  builder: (context) => SubmitButton(
                    title: cubit.isEdit ? 'Modifier' : 'Ajouter',
                    isLoading: context.select(
                      (AnnouncerCubit cubit) => cubit.state.isLoading,
                    ),
                    onTap: cubit.save,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/extension/snackbar.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/widgets/date_picker.dart';
import 'package:tender_admin/core/shared/widgets/drop_down_menu.dart';
import 'package:tender_admin/core/shared/widgets/forms.dart';
import 'package:tender_admin/core/shared/widgets/text_form_field.dart';
import 'package:tender_admin/features/result/config/result.navigator.dart';
import 'package:tender_admin/features/result/data/dto/result.dto.dart';
import 'package:tender_admin/features/result/module/singleresult/logic/single_result.cubit.dart';
import 'package:tender_admin/features/sources/logic/source.cubit.dart';
import 'package:tender_admin/features/sources/modules/sources/sources.dart';
import 'package:tender_admin/features/tender/modules/selectabletender/view/selectable_tender.dart';

part '../widget/form.dart';
part '../widget/attachments.dart';

class ResultForm extends StatelessWidget {
  const ResultForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SingleResultCubit, SingleResultState>(
      listener: _listener,
      child: AppForm(
        title: 'Result Form',
        infoForm: _Form(),
        attachmentForm: _Attachments(),
        onSave: context.read<SingleResultCubit>().saveResult,
        onCancel: () => context.pop(),
        isSaving: context.select(
            (SingleResultCubit cubit) => cubit.state.isSaving),
        isLoading: context.select(
            (SingleResultCubit cubit) => cubit.state.isLoading),
      ),
    );
  }

  void _listener(BuildContext context, SingleResultState state) {
    state.onError(context.showErrorSnackbar);
    state.onSave(
      (result) =>
          context.off(ResultNavigator.results(state.dto.tenderId)),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/extension/navigator.extension.dart';
import 'package:tender_admin/core/extension/snackbar.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/shared/widgets/date_picker.dart';
import 'package:tender_admin/core/shared/widgets/drop_down_menu.dart';
import 'package:tender_admin/core/shared/widgets/forms.dart';
import 'package:tender_admin/core/shared/widgets/text_form_field.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/announcer/modules/multiannouncers/logic/multi_announcer.cubit.dart';
import 'package:tender_admin/features/announcer/modules/multiannouncers/ui/announcers.dart';
import 'package:tender_admin/features/announcer/modules/singleannouncer/ui/announcer.dart';
import 'package:tender_admin/features/announcer/modules/singleannouncer/ui/selected_announcer.dart';
import 'package:tender_admin/features/sources/logic/source.cubit.dart';
import 'package:tender_admin/features/sources/modules/sources/sources.dart';
import 'package:tender_admin/features/tender/config/tender.navigator.dart';
import 'package:tender_admin/features/tender/data/dto/tender.dto.dart';
import 'package:tender_admin/features/tender/modules/tenderform/logic/tender.cubit.dart';

part '../widgets/form.dart';
part '../widgets/attachments.dart';
part '../widgets/announcer.dart';

class TenderForm extends StatelessWidget {
  const TenderForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TenderCubit, TenderState>(
      listener: (context, state) {
        state.onError(context.showErrorSnackbar);
      },
      child: AppForm(
        title: 'Tender Form',
        infoForm: _Form(),
        attachmentForm: _Attachments(),
        onSave: context.read<TenderCubit>().saveTender,
        onCancel: () => context.off(TenderNavigator.tenders()),
        isSaving: context
            .select((TenderCubit cubit) => cubit.state.isSaving),
        isLoading: context
            .select((TenderCubit cubit) => cubit.state.isLoading),
      ),
    );
  }
}

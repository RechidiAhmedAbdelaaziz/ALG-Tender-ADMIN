import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/announcer/modules/singleannouncer/logic/announcer.cubit.dart';

import 'announcer_form.dart';

class Announcer extends StatelessWidget {
  final AnnouncerModel announcer;
  final ValueChanged<AnnouncerModel>? onEdit;
  final ValueChanged<AnnouncerModel>? onDelete;
  const Announcer(this.announcer,
      {super.key, this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        children: [
          _buildAvatar(),
          widthSpace(10),
          Expanded(child: _buildName()),
          if (announcer.isStartup ?? false) _buildStartup(),
          widthSpace(10),
          if (onEdit != null)
            _buildEditButton(
              () async {
                await context.dialogWith<AnnouncerModel>(
                  child: BlocProvider<AnnouncerCubit>(
                    create: (_) => UpdateAnnouncerCubit(announcer),
                    child: AnnouncerForm(),
                  ),
                  onResult: onEdit!,
                );
              },
            ),
          if (onDelete != null)
            _buildDeleteButton(
              () {
                context.alertDialog(
                  title: 'Suppression',
                  content:
                      'Voulez-vous vraiment supprimer cet annonceur?',
                  onConfirm: () => onDelete!(announcer),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 45.r,
      backgroundImage: NetworkImage(announcer.imageUri ?? ''),
    );
  }

  Widget _buildName() {
    return Text(
      announcer.name ?? '',
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        fontSize: 18.spMax,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildStartup() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: KColors.primary,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        'Startup',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.spMax,
        ),
      ),
    );
  }

  Widget _buildEditButton(VoidCallback onEdit) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: onEdit,
    );
  }

  Widget _buildDeleteButton(VoidCallback onDelete) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: onDelete,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/features/announcer/data/models/announcer.model.dart';
import 'package:tender_admin/features/announcer/modules/multiannouncers/logic/multi_announcer.cubit.dart';

import '../../multiannouncers/ui/announcers.dart';
import 'announcer.dart';

class SelectableAnnouncer extends StatefulWidget {
  final EditingController<AnnouncerModel> controller;
  final bool isRequired;
  const SelectableAnnouncer(
      {super.key, required this.controller, this.isRequired = false});

  @override
  State<SelectableAnnouncer> createState() =>
      _SelectableAnnouncerState();
}

class _SelectableAnnouncerState extends State<SelectableAnnouncer> {
  AnnouncerModel? announcer;

  @override
  void initState() {
    announcer = widget.controller.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (announcer != null)
          Row(
            children: [
              Expanded(
                child: Announcer(
                  announcer!,
                  onEdit: (announcer) {
                    widget.controller.setValue(announcer);
                    setState(() => this.announcer = announcer);
                  },
                ),
              ),
              if (!widget.isRequired)
                IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    setState(() => announcer = null);
                  },
                  icon: Icon(Icons.cancel),
                ),
            ],
          ),
        InkWell(
          onTap: () {
            context.dialog(
              child: BlocProvider(
                create: (context) => MultiAnnouncerCubit()..load(),
                child: Announcers(
                  onSelecte: (announcer) {
                    widget.controller.setValue(announcer);
                    setState(() => this.announcer = announcer);
                  },
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              announcer == null
                  ? 'Select Announcer'
                  : 'Change Announcer',
            ),
          ),
        ),
      ],
    );
  }
}

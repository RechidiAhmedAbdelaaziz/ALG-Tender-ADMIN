import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/extension/dialog.extension.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';
import 'package:tender_admin/core/themes/colors.dart';
import 'package:tender_admin/features/tender/data/models/tender.model.dart';
import 'package:tender_admin/features/tender/modules/tenderlist/view/tenders_select.dart';

class SelectableTender extends StatefulWidget {
  final EditingController<TenderModel> controller;
  final bool isRequired;
  const SelectableTender(
      {super.key, required this.controller, this.isRequired = false});

  @override
  State<SelectableTender> createState() => _SelectableTenderState();
}

class _SelectableTenderState extends State<SelectableTender> {
  TenderModel? tender;

  @override
  void initState() {
    tender = widget.controller.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (tender != null)
          Row(
            children: [
              Expanded(
                child: _buildTender(tender!),
              ),
              if (!widget.isRequired)
                IconButton(
                  onPressed: () {
                    widget.controller.clear();
                    setState(() => tender = null);
                  },
                  icon: Icon(Icons.cancel),
                ),
            ],
          ),
        if (tender != null) heightSpace(10),
        InkWell(
          onTap: () {
            context.dialogWith<TenderModel>(
              child: TendersSelector(),
              onResult: (tender) {
                widget.controller.setValue(tender);
                setState(() => this.tender = tender);
              },
              autoBack: false,
            );
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: KColors.primary,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              tender == null
                  ? 'Sélectionner un appel d\'offre'
                  : 'Changer l\'appel d\'offre',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTender(TenderModel tender) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              image: DecorationImage(
                image: NetworkImage(tender.announcer?.imageUri ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace(10),
          Expanded(
            child: Text(
              tender.title!,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.spMax,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (tender.announcer?.isStartup == true)
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.w, vertical: 4.h),
              margin: EdgeInsetsDirectional.only(end: 10.w),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 188, 243, 190),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'Startup',
                style: TextStyle(
                  fontSize: 12.spMax,
                  color: const Color.fromARGB(255, 1, 90, 6),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

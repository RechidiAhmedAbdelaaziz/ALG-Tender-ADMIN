import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/list_generic_editingcontroller.dart';

class MultiDropDownMenu extends StatelessWidget {
  final List<String> items;
  final ListEditingcontroller<String> controller;
  final String? title;
  final bool initalized;
  const MultiDropDownMenu({
    super.key,
    required this.items,
    required this.controller,
    this.title,
    this.initalized = true,
  });

  @override
  Widget build(BuildContext context) {
    if (initalized) {
      controller.setList(
          controller.value.isEmpty ? items : controller.value);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10.h,
      children: [
        if (title != null)
          Text(
            title!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.spMax,
              fontWeight: FontWeight.w600,
            ),
          ),
        CustomDropdown.multiSelectSearch(
          decoration: CustomDropdownDecoration(
            closedBorder: Border.all(color: Colors.grey),
          ),
          items: items,
          onListChanged: controller.setList,
          initialItems: controller.value,
        ),
      ],
    );
  }
}

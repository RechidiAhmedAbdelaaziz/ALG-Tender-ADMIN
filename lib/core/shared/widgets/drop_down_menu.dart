import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KDropDownMenu extends StatelessWidget {
  final List<String> items;
  final TextEditingController controller;
  final String? title;
  final bool initalized;

  const KDropDownMenu({
    super.key,
    this.title,
    required this.items,
    required this.controller,
    this.initalized = true,
  });

  @override
  Widget build(BuildContext context) {
    if (initalized) {
      controller.text =
          controller.text.isEmpty ? items.first : controller.text;
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
        CustomDropdown.search(
          decoration: CustomDropdownDecoration(
            closedBorder: Border.all(color: Colors.grey),
          ),
          items: items,
          initialItem: items.contains(controller.text)
              ? controller.text
              : initalized
                  ? items.first
                  : null,
          onChanged: (value) {
            if (value != null) controller.text = value;
          },
        ),
      ],
    );
  }
}

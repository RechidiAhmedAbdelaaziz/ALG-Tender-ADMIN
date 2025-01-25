import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KDropDownMenu extends StatelessWidget {
  final List<String> items;
  final TextEditingController controller;
  final String? title;

  const KDropDownMenu({
    super.key,
    this.title,
    required this.items,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
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
          items: items,
          initialItem: items.contains(controller.text)
              ? controller.text
              : items.first,
          onChanged: (value) {
            if (value != null) controller.text = value;
          },
        ),
      ],
    );
  }
}

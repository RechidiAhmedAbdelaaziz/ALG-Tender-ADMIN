import 'package:flutter/material.dart';
import 'package:tender_admin/core/shared/widgets/drop_down_menu.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return KDropDownMenu(
      title: 'Test',
      items: ['RECHIDI AHMED', "RECHIDI AHMED2", "RECHIDI AHMED3"],
      controller: TextEditingController(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/boolean_editigcontroller.dart';

class AppCheckBox extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final BooleanEditingController? controller;
  final String title;
  const AppCheckBox({
    super.key,
    this.onChanged,
    this.controller,
    required this.title,
  });

  @override
  State<AppCheckBox> createState() => AppCheckBoxState();
}

class AppCheckBoxState extends State<AppCheckBox> {
  late bool _value;

  @override
  void initState() {
    _value = widget.controller?.value ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10.w,
      children: [
        Checkbox(
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value ?? false;
              widget.controller?.setValue(_value);
            });
            widget.onChanged?.call(value ?? false);
          },
        ),
        Text(widget.title),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/shared/classes/dimensions.dart';
import 'package:tender_admin/core/shared/classes/editioncontollers/generic_editingcontroller.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.controller,
    this.firstDate,
    this.lastDate,
    this.title,
  });

  final EditingController<DateTime> controller;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? title;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late DateTime date;

  @override
  void initState() {
    widget.controller
        .setValue(widget.controller.value ?? DateTime.now());
    date = widget.controller.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: widget.firstDate ?? DateTime(2000),
          lastDate:
              widget.lastDate ?? DateTime(DateTime.now().year + 5),
        );

        if (selectedDate != null) {
          widget.controller.setValue(selectedDate);
          setState(() => date = selectedDate);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: 16.spMax,
                color: Colors.black,
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 10.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today),
                widthSpace(12),
                Expanded(
                  child: Text(
                    _formatDate(date),
                    style: TextStyle(
                      fontSize: 16.spMax,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

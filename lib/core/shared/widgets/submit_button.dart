import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tender_admin/core/themes/colors.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final void Function() onTap;
  final String title;
  final Color color;
  final Color textColor;

  const SubmitButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.color = KColors.primary,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 66.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(25.r)),
              border: Border.all(color: textColor),
            ),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20.spMax,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitButton extends StatelessWidget {
  final bool isLoading;
  final void Function() onTap;
  final String title;

  const SubmitButton({
    super.key,
     required this.title,
      required this.onTap,
     this.isLoading = false,
   
   
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
            decoration: const BoxDecoration(
              color: Color(0xff005ce8),
            ),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.white,
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

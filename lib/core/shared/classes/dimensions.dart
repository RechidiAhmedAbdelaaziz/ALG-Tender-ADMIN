import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Dimensions {
  final double width;
  final double height;
  final double radius;

  const Dimensions({
    required this.width,
    required this.height,
    required this.radius,
  });
}


SizedBox heightSpace(double height) => SizedBox(height: height.h);
SizedBox widthSpace(double width) => SizedBox(width: width.w);

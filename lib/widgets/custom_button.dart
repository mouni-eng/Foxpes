import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final Color? background;
  final bool isUpperCase;
  final double? radius;
  final Function()? function;
  final String? text;

  CustomButton({
    this.width = double.infinity,
    this.background = kPrimaryColor,
    this.radius = 6.0,
    required this.isUpperCase,
    required this.function,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height(46),
      child: MaterialButton(
        onPressed: function,
        child: CustomText(
          text: isUpperCase ? text!.toUpperCase() : text!,
          color: Colors.white,
          fontsize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius!,
        ),
        color: background,
      ),
    );
  }
}

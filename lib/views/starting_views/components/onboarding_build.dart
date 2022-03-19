import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/onboarding_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/widgets/custom_text.dart';

class OnBoardingBuild extends StatelessWidget {
  final OnBoardingModel model;
  OnBoardingBuild({required this.model});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          model.image!,
          height: height(272),
        ),
        SizedBox(
          height: height(32),
        ),
        CustomText(
          text: model.title!,
          fontsize: 20.sp,
          height: 1.1,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        SizedBox(
          height: height(16),
        ),
        CustomText(
          text: model.subtitle!,
          textAlign: TextAlign.center,
          height: 1,
          fontsize: 16.sp,
          fontWeight: FontWeight.normal,
          color: kOnBoardingTextColor,
        ),
      ],
    );
  }
}

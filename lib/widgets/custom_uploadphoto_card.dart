import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/widgets/custom_text.dart';

class CustomUploadPhotosCard extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  CustomUploadPhotosCard({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          height: height(8),
        ),
        DottedBorder(
          dashPattern: [8, 5],
          borderType: BorderType.RRect,
          radius: Radius.circular(12),
          color: kPrimaryColor,
          strokeWidth: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: onPressed,
              child: Container(
                height: height(120),
                margin: EdgeInsets.symmetric(
                    horizontal: width(3), vertical: height(3)),
                width: double.infinity,
                color: Color(0xFFF1EFFE),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/upload.svg"),
                    SizedBox(
                      height: height(16),
                    ),
                    CustomText(
                      text: "Choose from Mobile",
                      fontsize: 10.sp,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

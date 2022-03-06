import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/widgets/custom_text.dart';

class CategoryBox extends StatelessWidget {
  final CategoryModel categoryModel;
  CategoryBox({required this.categoryModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(101),
      height: height(101),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Color(0xFFF7F7F9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {},
            child: SvgPicture.asset(
              categoryModel.image,
              width: width(40),
              height: height(40),
            ),
          ),
          CustomText(
              text: categoryModel.title,
              fontsize: 12.sp,
              color: kSecondaryColor),
        ],
      ),
    );
  }
}
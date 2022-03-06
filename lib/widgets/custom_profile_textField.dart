import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/widgets/custom_text.dart';

class ProfileFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validate;
  ProfileFormField({required this.controller, required this.label, required this.validate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height(46),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 0.1, //spread radius
            blurRadius: 5, // blur radius
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width(16)),
            child: CustomText(
                text: label, fontsize: 13.sp, color: kSecondaryColor),
          ),
          Container(
            width: width(206),
            child: TextFormField(
              controller: controller,
              validator: validate,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                errorStyle: TextStyle(
                  height: 0,
                ),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: width(16), vertical: height(40)),
                counterText: "",
                alignLabelWithHint: false,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(6)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(6)),
              ),
              style: TextStyle(
                  fontSize: 13.sp,
                  color: kHintTextColor,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}

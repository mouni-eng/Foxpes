import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';

class ChatFormField extends StatelessWidget {
  const ChatFormField({
    Key? key,
    required this.messageController,
    required this.onPressed,
  }) : super(key: key);

  final TextEditingController messageController;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(86),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 3, //spread radius
            blurRadius: 5, // blur radius
            offset: Offset(3, 3), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width(16), vertical: height(16)),
            child: Container(
              height: height(38),
              width: width(306),
              child: TextFormField(
                controller: messageController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "";
                  } else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  errorStyle: TextStyle(
                    height: 0,
                  ),
                  filled: true,
                  fillColor: Color(0xFFF3F3F3),
                  hintText: "Type a message",
                  hintStyle: TextStyle(
                    fontSize: 13.sp,
                    color: kHintTextColor,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: width(16),
                  ),
                  counterText: "",
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                ),
                style: TextStyle(
                    fontSize: 13.sp,
                    color: kHintTextColor,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          IconButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.zero,
              onPressed: onPressed,
              icon: SvgPicture.asset(
                "assets/icons/send.svg",
                width: width(20),
                height: height(20),
              )),
        ],
      ),
    );
  }
}
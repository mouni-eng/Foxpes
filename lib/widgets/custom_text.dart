import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? height;
  final double? fontsize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final TextOverflow? textOverflow;

  CustomText(
      {required this.text,
      this.height,
      required this.fontsize,
      this.textOverflow = TextOverflow.ellipsis,
      this.fontWeight,
      this.textAlign,
      required this.color});
  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: 2,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        fontSize: fontsize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Cairo",
      ),
    );
  }
}

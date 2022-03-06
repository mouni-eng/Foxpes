import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final void Function(String)? onSubmit;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final isPassword;
  final String? Function(String?)? validate;
  final String? label;
  final int? maxLines;
  final String? hintText;
  final int? maxLength;
  final Widget? prefix;
  final bool? isAboutMe;
  final BuildContext context;
  final Widget? suffix;
  final bool isClickable;

  CustomFormField({
    required this.context,
    this.hintText,
    this.controller,
    this.isClickable = true,
    this.isPassword = false,
    this.label,
    this.maxLength,
    this.isAboutMe = false,
    this.maxLines = 1,
    this.onChange,
    this.onSubmit,
    this.onTap,
    this.prefix,
    this.suffix,
    this.type,
    this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isAboutMe == false ? height(52) : height(132),
      child: TextFormField(
        maxLength: maxLength,
        maxLines: maxLines,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        validator: validate,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          hintText: hintText,
          errorStyle: TextStyle(
            height: 0,
          ),
          counterText: "",
          contentPadding: EdgeInsets.symmetric(
              horizontal: width(15),
              vertical: isAboutMe == false ? height(10) : height(25)),
          hintStyle: Theme.of(context).textTheme.bodyText2,
          labelStyle: Theme.of(context).textTheme.subtitle2,
          alignLabelWithHint: false,
          floatingLabelStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                color: kPrimaryColor,
              ),
          prefixIcon: prefix != null ? prefix : null,
          suffixIcon: suffix != null ? suffix : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kTextFieldColor,
              ),
              borderRadius: BorderRadius.circular(6)),
        ),
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}

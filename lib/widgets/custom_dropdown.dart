import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';

class CustomDropDownBox extends StatelessWidget {
  final List<DropdownMenuItem<String>> dropItems;
  final BuildContext context;
  final String label;
  final String hint;
  final void Function(String?)? onChange;
  final String? Function(String?)? validate;

  CustomDropDownBox({
    required this.context,
    required this.hint,
    required this.dropItems,
    required this.label,
    required this.onChange,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(52),
      child: DropdownButtonFormField<String>(
        items: dropItems,
        onChanged: onChange,
        validator: validate,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: label,
          hintText: hint,
          floatingLabelStyle: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: kPrimaryColor),
          counterText: "",
          errorStyle: TextStyle(
            height: 0,
          ),
          contentPadding: EdgeInsets.only(
            left: width(15),
            right: width(13),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kTextFieldColor,
              ),
              borderRadius: BorderRadius.circular(6)),
          hintStyle: Theme.of(context).textTheme.bodyText2,
          labelStyle: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}

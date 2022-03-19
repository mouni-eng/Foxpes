import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';

class CustomDatePicker extends StatelessWidget {

  final void Function(String?)? onChange;
  final String? Function(String?)? validate; 

  CustomDatePicker({required this.onChange, required this.validate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(52),
      child: DateTimePicker(
        initialValue: '',
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelText: LocaleKeys.birthdate.tr(),
          hintText: "21/02/1995",
          suffixIcon: Padding(
            padding: EdgeInsets.all(13),
            child: SvgPicture.asset("assets/icons/calender.svg"),
          ),
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
            right: width(20),
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
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        dateLabelText: 'Date',
        onChanged: onChange,
        validator: validate,
        onSaved: (val) => print(val),
      ),
    );
  }
}

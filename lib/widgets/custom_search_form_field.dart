import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController searchEditingController;
  final void Function(String)? onChange;
  final String hint;

  SearchFormField(
      {required this.searchEditingController, required this.onChange, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(42),
      child: TextFormField(
        controller: searchEditingController,
        keyboardType: TextInputType.text,
        onChanged: onChange,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hint,
          errorStyle: TextStyle(
            height: 0,
          ),
          counterText: "",
          contentPadding: EdgeInsets.symmetric(
            horizontal: width(15),
          ),
          hintStyle: Theme.of(context).textTheme.bodyText2,
          alignLabelWithHint: false,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(12),
              vertical: height(12),
            ),
            child: SvgPicture.asset(
              "assets/icons/search.svg",
            ),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kTextFieldColor,
              ),
              borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(
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

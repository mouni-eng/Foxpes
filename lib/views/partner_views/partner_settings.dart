import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/views/client_views/settings_view.dart';

class PartnerSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          constraints: BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(
            "assets/icons/arrow-right.svg",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: width(16), left: width(16)),
        child: ClientSettingsView(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/baby_sitter_views/babysitter_signup_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_button.dart';

class UploadProfilePictureView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Photo", style: Theme.of(context).textTheme.headline1),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height(157),
            ),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                SvgPicture.asset(
                  "assets/images/profile-circle.svg",
                  width: width(203),
                  height: height(203),
                ),
                Positioned(
                  bottom: height(10),
                  right: width(20),
                  child: Material(
                    color: Colors.white,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      width: width(49),
                      height: height(49),
                      padding: EdgeInsets.all(width(12)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: SvgPicture.asset(
                              "assets/images/camera-icon.svg")),
                    ),
                  ),
                )
              ],
            ),
            Text("Add Your Photo To Let People Knows You",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: kHintTextColor,
                    )),
            SizedBox(
              height: height(85),
            ),
            CustomButton(
              radius: 6,
              function: () {
                
              },
              text: "upload photo",
              isUpperCase: true,
            ),
            SizedBox(
              height: height(10),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "SKIP",
                style: Theme.of(context).textTheme.subtitle2!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

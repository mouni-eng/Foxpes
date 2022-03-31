import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/views/auth_views/login_view.dart';
import 'package:movies_app/widgets/custom_text.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: double.infinity,
          height: height(150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(
                left: width(25),
                top: height(25),
                right: width(25),
                bottom: height(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "Log Out", fontsize: 14.sp, color: kSecondaryColor),
                CustomText(
                    text: "Are you sure you want to log out?",
                    fontsize: 12.sp,
                    color: kHintTextColor),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          CacheHelper.removeData(
                            key: 'uid',
                          ).then((value) {
                            CacheHelper.removeData(key: 'categories')
                                .then((value) {
                              if (value) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()),
                                    (route) => false);
                              }
                            });
                          });
                        },
                        child: CustomText(
                            text: "Yes",
                            fontsize: 14.sp,
                            color: kPrimaryColor)),
                    SizedBox(
                      width: width(25),
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                            text: "No", fontsize: 14.sp, color: kPrimaryColor)),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

bool isEnglish = false;

bool isArabic = false;

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          width: double.infinity,
          height: height(170),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(25),
              vertical: height(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: "Change Language",
                    fontsize: 14.sp,
                    color: kSecondaryColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "English",
                        fontsize: 14.sp,
                        color: kSecondaryColor),
                    SizedBox(
                      width: width(25),
                      height: height(25),
                      child: Checkbox(
                        value: isEnglish,
                        onChanged: (value) async {
                          setState(() {
                            isEnglish = true;
                            isArabic = false;
                          });
                          await context
                              .setLocale(Locale('en'))
                              .then((value) => Navigator.pop(context));
                        },
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 0.8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: "العربيه",
                        fontsize: 14.sp,
                        color: kSecondaryColor),
                    SizedBox(
                      width: width(25),
                      height: height(25),
                      child: Checkbox(
                        value: isArabic,
                        onChanged: (value) async {
                          setState(() {
                            isArabic = true;
                            isEnglish = false;
                          });
                          await context
                              .setLocale(Locale('ar'))
                              .then((value) => Navigator.pop(context));
                        },
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}

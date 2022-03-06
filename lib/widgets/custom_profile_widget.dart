import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
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
                    left: width(25), top: height(25)),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    CustomText(
                        text: "Log Out",
                        fontsize: 14.sp,
                        color: kSecondaryColor),
                    CustomText(
                        text:
                            "Are you sure you want to log out?",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                    Spacer(),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () async {
                              await FirebaseAuth
                                  .instance
                                  .signOut();
                              CacheHelper.removeData(
                                key: 'uId',
                              ).then((value) {
                                CacheHelper.removeData(
                                        key:
                                            'categorie')
                                    .then((value) {
                                  if (value) {
                                    navigateToAndFinish(
                                      context,
                                      Foxpes(),
                                    );
                                  }
                                });
                              });
                            },
                            child: CustomText(
                                text: "Yes",
                                fontsize: 14.sp,
                                color: kPrimaryColor)),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: CustomText(
                                text: "No",
                                fontsize: 14.sp,
                                color: kPrimaryColor)),
                      ],
                    )
                  ],
                ),
              )),
        );
  }
}

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
          child: Container(
              width: double.infinity,
              height: height(170),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width(25),
                  vertical: height(25),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center,
                  children: [
                    CustomText(
                        text: "Change Language",
                        fontsize: 14.sp,
                        color: kSecondaryColor),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        CustomText(
                            text: "English",
                            fontsize: 14.sp,
                            color:
                                kSecondaryColor),
                        SizedBox(
                          width: width(25),
                          height: height(25),
                          child: Checkbox(
                            value: false,
                            onChanged: (value) {},
                            shape: CircleBorder(),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 0.8,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                      children: [
                        CustomText(
                            text: "العربيه",
                            fontsize: 14.sp,
                            color:
                                kSecondaryColor),
                        SizedBox(
                          width: width(25),
                          height: height(25),
                          child: Checkbox(
                            value: true,
                            onChanged: (value) {},
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
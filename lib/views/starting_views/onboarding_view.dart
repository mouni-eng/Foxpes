import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/onboarding_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/views/auth_views/login_view.dart';
import 'package:movies_app/views/starting_views/components/onboarding_build.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_profile_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

PageController controller = PageController();
bool isLast = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<OnBoardingModel> onBoardingList = [
      OnBoardingModel(
          title: LocaleKeys.discoverTeachers.tr(),
          image: "assets/images/Mask Group 46.png",
          subtitle: LocaleKeys.youcanfindteachers.tr()),
      OnBoardingModel(
          title: LocaleKeys.findBabySitter.tr(),
          image: "assets/images/Mask Group 43.png",
          subtitle: LocaleKeys.findthebestsitter.tr()),
      OnBoardingModel(
          title: LocaleKeys.dealWithDriver.tr(),
          image: "assets/images/Mask Group 44.png",
          subtitle: LocaleKeys.discoverthebestdriver.tr()),
    ];
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width(16)),
        child: Column(
          children: [
            SizedBox(
              height: height(37),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Material(
                  color: Colors.white,
                  elevation: 3,
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    height: height(36),
                    width: width(60),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                            barrierColor: Colors.black.withOpacity(0.8),
                            context: context,
                            builder: (context) => ChangeLanguageWidget());

                        // TODO: change language
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "العربيه",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: "Cairo",
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height(21),
            ),
            Container(
              height: height(390),
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == onBoardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: controller,
                physics: BouncingScrollPhysics(),
                itemCount: onBoardingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return OnBoardingBuild(
                    model: onBoardingList[index],
                  );
                },
              ),
            ),
            SizedBox(
              height: height(136),
            ),
            SmoothPageIndicator(
              controller: controller,
              count: onBoardingList.length,
              effect: ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: kPrimaryColor,
                dotHeight: 7.h,
                expansionFactor: 2,
                dotWidth: 7.h,
                spacing: 5.0,
              ),
            ),
            SizedBox(
              height: height(70),
            ),
            if (isLast == true)
              CustomButton(
                function: () {
                  CacheHelper.saveData(
                    key: 'onBoardings',
                    value: true,
                  ).then((value) {
                    if (value) {
                      navigateToAndFinish(context, LoginView());
                    }
                  });
                },
                text: LocaleKeys.getStarted.tr(),
                isUpperCase: true,
              ),
            if (isLast != true)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        CacheHelper.saveData(
                          key: 'onBoardings',
                          value: true,
                        ).then((value) {
                          if (value) {
                            navigateToAndFinish(context, LoginView());
                          }
                        });
                      },
                      child: Text(
                        LocaleKeys.sKIP.tr(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      )),
                  CustomButton(
                    text: LocaleKeys.next.tr(),
                    radius: 6,
                    width: width(89),
                    function: () {
                      if (isLast) {
                        CacheHelper.saveData(
                          key: 'onBoardings',
                          value: true,
                        ).then((value) {
                          if (value) {
                            navigateToAndFinish(context, LoginView());
                          }
                        });
                      }
                      controller.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    isUpperCase: true,
                  ),
                ],
              ),
          ],
        ),
      ),
    ));
  }
}

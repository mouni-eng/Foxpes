import 'package:flutter/material.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/onboarding_model.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/views/auth_views/login_view.dart';
import 'package:movies_app/widgets.dart';
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
    List<OnBoardingModel> onBoardingList = [
      OnBoardingModel(
          title: "Welcome to Tutors, Discover our Teachers all over the country",
          image: "assets/images/pic1.svg"),
      OnBoardingModel(
          title: "Also you can apply to be a teacher on our App",
          image: "assets/images/pic4.svg"),
      OnBoardingModel(
          title: "Chat with your future teacher and discuss your thoughts with each other",
          image: "assets/images/chating.svg"),
    ];
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(onPressed: () {
              CacheHelper.saveData(
                key: 'onBoarding',
                value: true,
              ).then((value)
              {
                if (value) {
                  navigateToAndFinish(context, LoginView());
                }
              });
            }, child: Text("SKIP")),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
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
                    return onBoardingBuild(onBoardingList[index]);
                  },
                ),
              ),
              SizedBox(
                height: 90.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onBoardingList.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: kPrimaryColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast) {
                        CacheHelper.saveData(
                          key: 'onBoarding',
                          value: true,
                        ).then((value)
                        {
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
                    child: Icon(IconBroken.Arrow___Right_2, size: 30.0,),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

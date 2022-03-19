import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/views/client_views/chat_details_view.dart';
import 'package:movies_app/widgets/custom_button.dart';
import 'package:movies_app/widgets/custom_rating_dialog.dart';
import 'package:movies_app/widgets/custom_text.dart';

class PartnerDetailsView extends StatelessWidget {
  final LogInModel logInModel;
  final String rating;
  PartnerDetailsView({required this.logInModel, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: SizeConfig.screenHeight!,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width(width(16))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  logInModel.image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: CachedNetworkImage(
                                            imageUrl: logInModel.image!,
                                            width: width(68),
                                            height: height(68),
                                            fit: BoxFit.cover,
                                          ))
                                      : SvgPicture.asset(
                                          "assets/images/profile-circle.svg",
                                          width: width(68),
                                          height: height(68),
                                          fit: BoxFit.cover,
                                        ),
                                  SizedBox(
                                    width: width(16),
                                  ),
                                  Flexible(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: CustomText(
                                                  text:
                                                      "${logInModel.firstName} ${logInModel.lastName}",
                                                  fontsize: 14.sp,
                                                  height: 1.2,
                                                  maxLines: 2,
                                                  fontWeight: FontWeight.w600,
                                                  color: kSecondaryColor),
                                            ),
                                            Flexible(
                                              child: CustomText(
                                                text:
                                                    "KWD ${logInModel.price}/${logInModel.duration!.split(" ").last}",
                                                fontsize: 12.sp,
                                                color: kPrimaryColor,
                                                height: 1.2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(10),
                                        ),
                                        if (logInModel.category == "Teacher")
                                          CustomText(
                                              text:
                                                  "${logInModel.teachIn} Teacher",
                                              fontsize: 14.sp,
                                              maxLines: 2,
                                              height: 1,
                                              color: kPrimaryColor),
                                        if (logInModel.category == "Driver")
                                          CustomText(
                                              text: logInModel.careType,
                                              fontsize: 14.sp,
                                              height: 1,
                                              color: kHintTextColor),
                                        if (logInModel.category ==
                                            "Baby Sitter")
                                          CustomText(
                                              text: logInModel.degree,
                                              fontsize: 14.sp,
                                              height: 1,
                                              color: kHintTextColor),
                                      ],
                                    ),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: height(16),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icons/exp.png",
                                  width: width(16),
                                  height: height(16),
                                ),
                                CustomText(
                                    text:
                                        "  ${logInModel.experience} experience",
                                    fontsize: 12.sp,
                                    color: kHintTextColor),
                                SizedBox(
                                  width: width(30),
                                ),
                                VerticalDivider(
                                  thickness: 1,
                                ),
                                SizedBox(
                                  width: width(30),
                                ),
                                SvgPicture.asset(
                                  "assets/icons/location.svg",
                                  width: width(14),
                                  height: height(13),
                                ),
                                CustomText(
                                    text: "  ${logInModel.country}",
                                    fontsize: 12.sp,
                                    color: kHintTextColor),
                                SizedBox(
                                  width: width(30),
                                ),
                                VerticalDivider(
                                  thickness: 1,
                                ),
                                SizedBox(
                                  width: width(30),
                                ),
                                SvgPicture.asset(
                                  "assets/icons/rating.svg",
                                  width: width(14),
                                  height: height(13),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CustomRatingDialog(
                                                logInModel: logInModel));
                                  },
                                  child: CustomText(
                                      text: " $rating",
                                      fontsize: 12.sp,
                                      color: kHintTextColor),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height(40),
                          ),
                          CustomText(
                              text: "About ${logInModel.category}",
                              fontsize: 14.sp,
                              color: kSecondaryColor),
                          SizedBox(
                            height: height(10),
                          ),
                          CustomText(
                              text: "${logInModel.aboutYou}",
                              fontsize: 12.sp,
                              maxLines: 10,
                              color: kHintTextColor),
                          if (logInModel.category == "Teacher")
                            TeacherDetailsWidget(
                              logInModel: logInModel,
                            ),
                          if (logInModel.category == "Driver")
                            DriverDetailsWidget(
                              logInModel: logInModel,
                            ),
                          if (logInModel.category == "Baby Sitter")
                            BabySitterDetailsWidget(
                              logInModel: logInModel,
                            ),
                        ]),
                  ),
                  SizedBox(
                    height: height(100),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width(16),
                  vertical: height(16),
                ),
                child: CustomButton(
                    isUpperCase: true,
                    function: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChatDetailsView(logInModel: logInModel)))
                          .then((value) =>
                              ClientCubit.get(context).changeBottomNav(1));
                    },
                    text: LocaleKeys.sendMessage.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DriverDetailsWidget extends StatelessWidget {
  final LogInModel logInModel;

  DriverDetailsWidget({
    required this.logInModel,
  });

  @override
  Widget build(BuildContext context) {
    String datePattern = "yyyy-MM-dd";
    DateTime birthDate = DateFormat(datePattern).parse(logInModel.birthDate!);
    DateTime today = DateTime.now();
    int yearDiff = today.year - birthDate.year;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height(40),
        ),
        CustomText(
            text: "More Details", fontsize: 14.sp, color: kSecondaryColor),
        SizedBox(
          height: height(16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/birth.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: "  $yearDiff year",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                  ],
                ),
                SizedBox(
                  height: height(25),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/car-type.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: "  ${logInModel.careType}",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/car-no.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: "  ${logInModel.carNumber}",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                  ],
                ),
                SizedBox(
                  height: height(25),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/phone1.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: "  965 ${logInModel.phone}",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: height(40),
        ),
        CustomText(
            text: "Pictures of car", fontsize: 14.sp, color: kSecondaryColor),
        SizedBox(height: height(16)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            children: [
              Container(
                height: height(132),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                              width: width(134),
                              height: height(132),
                              child: CachedNetworkImage(
                                imageUrl: logInModel.carImages![index],
                                fit: BoxFit.cover,
                              )),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          width: width(10),
                        ),
                    itemCount: logInModel.carImages!.length),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SkillsWidget extends StatelessWidget {
  final String title;
  final String image;
  SkillsWidget({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width(50),
          height: height(50),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xFFF1F1FF),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width(10),
              vertical: height(10),
            ),
            child: Image.asset(
              image,
            ),
          ),
        ),
        CustomText(text: title, fontsize: 12.sp, color: kHintTextColor),
      ],
    );
  }
}

class TeacherDetailsWidget extends StatelessWidget {
  final LogInModel logInModel;
  TeacherDetailsWidget({
    required this.logInModel,
  });

  @override
  Widget build(BuildContext context) {
    String datePattern = "yyyy-MM-dd";
    DateTime birthDate = DateFormat(datePattern).parse(logInModel.birthDate!);
    DateTime today = DateTime.now();
    int yearDiff = today.year - birthDate.year;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height(40),
        ),
        CustomText(text: "Skills", fontsize: 14.sp, color: kSecondaryColor),
        SizedBox(
          height: height(16),
        ),
        Row(
          children: [
            SkillsWidget(
              image: "assets/icons/grammer.png",
              title: "Grammer",
            ),
            SizedBox(
              width: width(50),
            ),
            SkillsWidget(
              image: "assets/icons/speaking.png",
              title: "Speaking",
            ),
            SizedBox(
              width: width(50),
            ),
            SkillsWidget(
              image: "assets/icons/Listening.png",
              title: "Listening",
            ),
          ],
        ),
        SizedBox(
          height: height(40),
        ),
        CustomText(
            text: "More Details", fontsize: 14.sp, color: kSecondaryColor),
        SizedBox(
          height: height(16),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/birth.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: "  $yearDiff year",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                  ],
                ),
                SizedBox(
                  height: height(25),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/faculty1.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: "  Faculty of ${logInModel.faculty}",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/teachs.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: " Teach in ${logInModel.teachIn}",
                        fontsize: 12.sp,
                        textOverflow: TextOverflow.ellipsis,
                        color: kHintTextColor),
                  ],
                ),
                SizedBox(
                  height: height(25),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/phone1.png",
                      width: width(15),
                      height: height(15),
                    ),
                    CustomText(
                        text: "  965 ${logInModel.phone}",
                        fontsize: 12.sp,
                        color: kHintTextColor),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}

class BabySitterDetailsWidget extends StatelessWidget {
  final LogInModel logInModel;
  BabySitterDetailsWidget({
    required this.logInModel,
  });

  @override
  Widget build(BuildContext context) {
    String datePattern = "yyyy-MM-dd";
    DateTime birthDate = DateFormat(datePattern).parse(logInModel.birthDate!);
    DateTime today = DateTime.now();
    int yearDiff = today.year - birthDate.year;

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height(40),
            ),
            CustomText(
                text: "More Details", fontsize: 14.sp, color: kSecondaryColor),
            SizedBox(
              height: height(16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/birth.png",
                          width: width(15),
                          height: height(15),
                        ),
                        CustomText(
                            text: "  $yearDiff year",
                            fontsize: 12.sp,
                            color: kHintTextColor),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/faculty1.png",
                          width: width(15),
                          height: height(15),
                        ),
                        CustomText(
                            text: "  ${logInModel.degree}",
                            fontsize: 12.sp,
                            color: kHintTextColor),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/religion.png",
                          width: width(15),
                          height: height(15),
                        ),
                        CustomText(
                            text: "  ${logInModel.religion}",
                            fontsize: 12.sp,
                            color: kHintTextColor),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/global.png",
                          width: width(15),
                          height: height(15),
                        ),
                        CustomText(
                            text: " Speak ${logInModel.speaks}",
                            fontsize: 12.sp,
                            color: kHintTextColor),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/phone1.png",
                          width: width(15),
                          height: height(15),
                        ),
                        CustomText(
                            text: "  965 ${logInModel.phone}",
                            fontsize: 12.sp,
                            color: kHintTextColor),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          "assets/icons/status.png",
                          width: width(15),
                          height: height(15),
                        ),
                        CustomText(
                            text: "  ${logInModel.status}",
                            fontsize: 12.sp,
                            color: kHintTextColor),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

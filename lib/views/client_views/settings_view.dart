import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
import 'package:movies_app/views/client_views/profile_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_profile_widget.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientSettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientCubit, ClientStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ClientCubit cubit = ClientCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetUserDataLoadingState,
          builder: (context) => Padding(
            padding: EdgeInsets.only(top: height(16)),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: width(34),
                          height: height(34),
                          child: cubit.logInModel!.image != null
                              ? CachedNetworkImage(
                                  imageUrl: cubit.logInModel!.image!,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  "assets/images/profile-circle.svg",
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(
                          width: width(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text:
                                  "${cubit.logInModel!.firstName} ${cubit.logInModel!.lastName}",
                              fontsize: 15.sp,
                              height: 1.2,
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: height(3),
                            ),
                            CustomText(
                                text: cubit.logInModel!.email,
                                fontsize: 11.sp,
                                height: 1,
                                color: kPrimaryColor),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/user.svg",
                          width: width(24),
                          height: height(24),
                        ),
                        SizedBox(
                          width: width(28),
                        ),
                        CustomText(
                            text: LocaleKeys.profile.tr(),
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            navigateTo(context, ClientProfileView());
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/arrow-left.svg",
                            width: width(24),
                            height: height(24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/secuirty.svg",
                          width: width(24),
                          height: height(24),
                        ),
                        SizedBox(
                          width: width(28),
                        ),
                        CustomText(
                            text: LocaleKeys.privacy.tr(),
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            launchURL("http://foxpes.com/#/");
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/arrow-left.svg",
                            width: width(24),
                            height: height(24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/support.svg",
                          width: width(24),
                          height: height(24),
                        ),
                        SizedBox(
                          width: width(28),
                        ),
                        CustomText(
                            text: LocaleKeys.support.tr(),
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            launchURL("http://foxpes.com/#/");
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/arrow-left.svg",
                            width: width(24),
                            height: height(24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(25),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/info.svg",
                          width: width(24),
                          height: height(24),
                        ),
                        SizedBox(
                          width: width(28),
                        ),
                        CustomText(
                            text: LocaleKeys.aboutUs.tr(),
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            launchURL("http://foxpes.com/#/");
                          },
                          icon: SvgPicture.asset(
                            "assets/icons/arrow-left.svg",
                            width: width(24),
                            height: height(24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(15),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: height(15),
                    ),
                    if (cubit.logInModel!.category == "Student")
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/notifications.svg",
                            width: width(24),
                            height: height(24),
                          ),
                          SizedBox(
                            width: width(28),
                          ),
                          CustomText(
                              text: LocaleKeys.notifications.tr(),
                              fontsize: 14.sp,
                              color: kSecondaryColor),
                          Spacer(),
                          SizedBox(
                            width: width(40),
                            height: height(22),
                            child: Switch(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                value: cubit.notificationValue,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  cubit.changeNotificationValue(value);
                                }),
                          )
                        ],
                      ),
                    SizedBox(
                      height: height(15),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/icons/lang.svg",
                          width: width(24),
                          height: height(24),
                        ),
                        SizedBox(
                          width: width(28),
                        ),
                        CustomText(
                            text: LocaleKeys.language.tr(),
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        InkWell(
                            onTap: () {
                              showDialog(
                                  barrierColor: Colors.black.withOpacity(0.8),
                                  context: context,
                                  builder: (context) => ChangeLanguageWidget());
                            },
                            child: CustomText(
                                text: "English",
                                fontsize: 12.sp,
                                color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(
                      height: height(15),
                    ),
                    if (cubit.logInModel!.country != null)
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/locate.svg",
                            width: width(24),
                            height: height(24),
                          ),
                          SizedBox(
                            width: width(28),
                          ),
                          CustomText(
                              text: LocaleKeys.country.tr(),
                              fontsize: 14.sp,
                              color: kSecondaryColor),
                          Spacer(),
                          CustomText(
                              text: cubit.logInModel!.country,
                              fontsize: 12.sp,
                              color: kPrimaryColor),
                        ],
                      ),
                    SizedBox(
                      height: height(5),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: height(15),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            barrierColor: Colors.black.withOpacity(0.8),
                            context: context,
                            builder: (context) => LogOutWidget());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/log-out.svg",
                            width: width(24),
                            height: height(24),
                          ),
                          SizedBox(
                            width: width(28),
                          ),
                          CustomText(
                              text: LocaleKeys.logOut.tr(),
                              fontsize: 14.sp,
                              color: kSecondaryColor),
                        ],
                      ),
                    ),
                    /*if (cubit.logInModel!.category != "Student")
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            SizedBox(
                              height: height(50),
                            ),
                            Container(
                              width: width(162),
                              height: height(41),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: kPrimaryColor,
                                ),
                              ),
                              child: Center(
                                child: CustomText(
                                    text: "Switch to Student",
                                    fontsize: 13.sp,
                                    textAlign: TextAlign.center,
                                    color: kPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),*/
                    SizedBox(
                      height: height(15),
                    ),
                  ]),
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: false);
  } else {
    throw 'Could not launch $url';
  }
}

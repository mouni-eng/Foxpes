import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
import 'package:movies_app/views/client_views/profile_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_profile_widget.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                          children: [
                            CustomText(
                              text:
                                  "${cubit.logInModel!.firstName} ${cubit.logInModel!.lastName}",
                              fontsize: 15.sp,
                              height: height(1.4),
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            CustomText(
                                text: cubit.logInModel!.email,
                                fontsize: 11.sp,
                                height: height(1.6),
                                color: kPrimaryColor),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(22),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: height(5),
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
                            text: "Profile",
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
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
                      height: height(5),
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
                            text: "Privacy",
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/arrow-left.svg",
                            width: width(24),
                            height: height(24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(5),
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
                            text: "Support",
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/arrow-left.svg",
                            width: width(24),
                            height: height(24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(5),
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
                            text: "About Us",
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            "assets/icons/arrow-left.svg",
                            width: width(24),
                            height: height(24),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(5),
                    ),
                    Divider(
                      thickness: 0.5,
                    ),
                    SizedBox(
                      height: height(5),
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
                              text: "Notifications",
                              fontsize: 14.sp,
                              color: kSecondaryColor),
                          Spacer(),
                          Switch(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: cubit.notificationValue,
                              activeColor: kPrimaryColor,
                              onChanged: (value) {
                                cubit.changeNotificationValue(value);
                              })
                        ],
                      ),
                    SizedBox(
                      height: height(5),
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
                            text: "Language",
                            fontsize: 14.sp,
                            color: kSecondaryColor),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  barrierColor: Colors.black.withOpacity(0.8),
                                  context: context,
                                  builder: (context) => ChangeLanguageWidget());
                            },
                            style: TextButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: CustomText(
                                text: "English",
                                fontsize: 12.sp,
                                color: kPrimaryColor)),
                      ],
                    ),
                    SizedBox(
                      height: height(5),
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
                              text: "Country",
                              fontsize: 14.sp,
                              color: kSecondaryColor),
                          Spacer(),
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: CustomText(
                                  text: cubit.logInModel!.country,
                                  fontsize: 12.sp,
                                  color: kPrimaryColor)),
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
                              text: "LogOut",
                              fontsize: 14.sp,
                              color: kSecondaryColor),
                        ],
                      ),
                    ),
                    if (cubit.logInModel!.category != "Student")
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
                      ),
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

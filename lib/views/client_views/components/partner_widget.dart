import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/find_partner_cubit/cubit.dart';
import 'package:movies_app/views/client_views/partner_details_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_text.dart';

class PartnerCard extends StatelessWidget {
  final LogInModel logInModel;
  final int index;
  PartnerCard({required this.logInModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            PartnerDetailsView(
                logInModel: logInModel,
                rating: FindPartnerCubit.get(context)
                    .allPartnersRating[index]
                    .toString()));
      },
      child: Container(
        width: double.infinity,
        height: height(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 0.1, //spread radius
              blurRadius: 5, // blur radius
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: width(16),
            right: width(16),
            top: height(16),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            logInModel.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(6),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                            text:
                                "${logInModel.firstName} ${logInModel.lastName}",
                            fontsize: 14.sp,
                            height: 1.2,
                            maxLines: 1,
                            fontWeight: FontWeight.w500,
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
                    height: height(5),
                  ),
                  if (logInModel.category == "Teacher")
                    CustomText(
                        text: logInModel.teachIn,
                        fontsize: 14.sp,
                        height: 1,
                        color: kHintTextColor),
                  if (logInModel.category == "Driver")
                    CustomText(
                        text: logInModel.careType,
                        fontsize: 14.sp,
                        height: 1,
                        color: kHintTextColor),
                  if (logInModel.category == "Baby Sitter")
                    CustomText(
                        text: logInModel.degree,
                        fontsize: 14.sp,
                        height: 1,
                        color: kHintTextColor),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/rating.svg",
                        width: width(14),
                        height: height(13),
                      ),
                      CustomText(
                          text:
                              " ${FindPartnerCubit.get(context).allPartnersRating[index] ?? 0}",
                          fontsize: 12.sp,
                          color: kHintTextColor),
                      SizedBox(
                        width: width(22),
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
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

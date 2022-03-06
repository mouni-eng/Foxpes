import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/views/client_views/partner_details_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_text.dart';

class PopularTeachersCard extends StatelessWidget {
  final LogInModel logInModel;
  final int index;
  PopularTeachersCard({required this.logInModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateTo(
            context,
            PartnerDetailsView(
                logInModel: logInModel,
                rating: ClientCubit.get(context)
                    .popularTeachersRating![index]
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
                    fit: BoxFit.cover,
                  ),
            SizedBox(
              width: width(16),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "${logInModel.firstName} ${logInModel.lastName}",
                    fontsize: 14.sp,
                    height: height(1.6),
                    fontWeight: FontWeight.w500,
                    color: kSecondaryColor),
                CustomText(
                    text: logInModel.teachIn,
                    fontsize: 14.sp,
                    height: height(1.8),
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
                            " ${ClientCubit.get(context).popularTeachersRating![index] ?? 0}",
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
            Spacer(),
            CustomText(
              text:
                  "KWD ${logInModel.price}/${logInModel.duration!.split(" ").last}",
              fontsize: 12.sp,
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ]),
        ),
      ),
    );
  }
}

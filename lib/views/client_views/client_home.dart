import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/category_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
import 'package:movies_app/views/client_views/components/category_widget.dart';
import 'package:movies_app/views/client_views/components/popularTeacher_widget.dart';
import 'package:movies_app/views/client_views/components/slider_widget.dart';
import 'package:movies_app/views/client_views/find_partner_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_text.dart';

class ClientHomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categoryListTr = [
      CategoryModel(
          title: LocaleKeys.teacher.tr(),
          image: "assets/images/teacher-cat.svg"),
      CategoryModel(
          title: LocaleKeys.driver.tr(), image: "assets/images/driver-cat.svg"),
      CategoryModel(
          title: LocaleKeys.babySitter.tr(),
          image: "assets/images/baby-sitter-cat.svg"),
    ];
    return BlocConsumer<ClientCubit, ClientStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ClientCubit cubit = ClientCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetUserDataLoadingState,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            text: LocaleKeys.hello.tr(),
                            fontsize: 11.sp,
                            height: 1.1,
                            color: kHintTextColor),
                        SizedBox(
                          height: height(3),
                        ),
                        CustomText(
                          text:
                              "${cubit.logInModel!.firstName} ${cubit.logInModel!.lastName}",
                          fontsize: 15.sp,
                          height: 1,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Spacer(),
                    Stack(
                      children: [
                        if (cubit.notificationList.length != 0)
                          Positioned(
                            right: 2.0,
                            top: 2.0,
                            child: Container(
                              width: width(10),
                              height: height(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: height(20.5),
                          width: width(20.5),
                          child: GestureDetector(
                            onTap: () {
                              cubit.changeBottomNav(1);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/notification.svg",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: height(25),
                ),
                SliderWidget(
                  currentIndex: cubit.carouselIndex,
                  onChanged: (index, reason) {
                    cubit.changeIndicatorIndex(index);
                  },
                ),
                SizedBox(
                  height: height(14),
                ),
                CustomText(
                    text: LocaleKeys.services.tr(),
                    fontsize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: kSecondaryColor),
                SizedBox(
                  height: height(18),
                ),
                Container(
                  height: height(101),
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  FindPartnerView(
                                      category: categoryList[index].title));
                            },
                            child: CategoryBox(
                              categoryModel: categoryListTr[index],
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            width: width(20),
                          ),
                      itemCount: categoryList.length),
                ),
                SizedBox(
                  height: height(30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: LocaleKeys.info.tr(),
                        fontsize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryColor),
                    InkWell(
                      onTap: () {
                        navigateTo(
                            context, FindPartnerView(category: "Teacher"));
                      },
                      child: CustomText(
                          text: LocaleKeys.infoBar.tr(),
                          fontsize: 12.sp,
                          color: kPrimaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: height(18),
                ),
                ConditionalBuilder(
                  condition: state is! GetPopularTeacherDataLoadingState,
                  builder: (context) => cubit.popularTeachers!.length != 0
                      ? ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: width(2)),
                                child: PopularTeachersCard(
                                  logInModel: cubit.popularTeachers![index],
                                  index: index,
                                ),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: height(15),
                              ),
                          itemCount: cubit.popularTeachers!.length)
                      : Column(
                          children: [
                            SizedBox(
                              height: height(45),
                            ),
                            Center(
                              child: CustomText(
                                  text: "No current Teachers",
                                  fontsize: 14.sp,
                                  color: kHintTextColor),
                            ),
                          ],
                        ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                SizedBox(
                  height: height(16),
                ),
              ],
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

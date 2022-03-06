import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
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
                      children: [
                        CustomText(
                            text: "Hello",
                            fontsize: 11.sp,
                            height: height(1.6),
                            color: kHintTextColor),
                        CustomText(
                          text:
                              "${cubit.logInModel!.firstName} ${cubit.logInModel!.lastName}",
                          fontsize: 15.sp,
                          height: height(1.4),
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          "assets/icons/notification.svg",
                          height: height(20.5),
                        )),
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
                    text: "Services",
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
                              categoryModel: categoryList[index],
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
                        text: "Popular Teachers",
                        fontsize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryColor),
                    InkWell(
                      onTap: () {
                        navigateTo(
                            context, FindPartnerView(category: "Teacher"));
                      },
                      child: CustomText(
                          text: "See All",
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
                  builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => PopularTeachersCard(
                            logInModel: cubit.popularTeachers![index],
                            index: index,
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: height(15),
                          ),
                      itemCount: cubit.popularTeachers!.length),
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

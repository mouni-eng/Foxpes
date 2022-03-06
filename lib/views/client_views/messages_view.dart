import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
import 'package:movies_app/views/client_views/chat_details_view.dart';
import 'package:movies_app/views/partner_views/partner_settings.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_search_form_field.dart';
import 'package:movies_app/widgets/custom_text.dart';

class ClientMessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _searchEditingController = TextEditingController();
    return Builder(builder: (BuildContext context) {
      ClientCubit.get(context).getUserChats();
      return BlocConsumer<ClientCubit, ClientStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ClientCubit cubit = ClientCubit.get(context);
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: height(16),
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (cubit.logInModel!.category != "Student")
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
                            onPressed: () {
                              navigateTo(context, PartnerSettingsView());
                            },
                            icon: SvgPicture.asset(
                              "assets/icons/partner_setting.svg",
                              height: height(20.5),
                            )),
                      ],
                    ),
                  if (cubit.logInModel!.category == "Student")
                    Column(
                      children: [
                        CustomText(
                            text: "Chats",
                            fontsize: 18.sp,
                            color: kSecondaryColor),
                        SizedBox(
                          height: height(24),
                        ),
                      ],
                    ),
                  if (cubit.logInModel!.category != "Student")
                    SizedBox(
                      height: height(16),
                    ),
                  SearchFormField(
                      searchEditingController: _searchEditingController,
                      onChange: (value) {
                        cubit.searchChatsData(name: value);
                      },
                      hint: "Search for chats & messages"),
                  ConditionalBuilder(
                    condition: state is! GetUserChatsDataLoadingState,
                    builder: (context) => cubit.chatsList.length == 0
                        ? SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: height(125),
                                ),
                                Image.asset(
                                  "assets/images/no-chat.png",
                                  width: width(201),
                                  height: height(185),
                                ),
                                SizedBox(
                                  height: height(26),
                                ),
                                CustomText(
                                    text: "There is no messages here yet",
                                    fontsize: 13.sp,
                                    color: kHintTextColor),
                              ],
                            ),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatDetailsView(
                                                  logInModel:
                                                      cubit.chatsList[index],
                                                ))).then((value) {
                                      cubit.getUserChats();
                                    });
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: height(90),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: height(25)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: width(25),
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: NetworkImage(
                                                      cubit.chatsList[index]
                                                                  .image ==
                                                              null
                                                          ? "https://firebasestorage.googleapis.com/v0/b/movies-app-fe023.appspot.com/o/users%2Fvuesax-linear-profile-circle.png?alt=media&token=e81580b4-85d6-4fe1-8f5c-0814a260a52b"
                                                          : cubit
                                                              .chatsList[index]
                                                              .image!),
                                                ),
                                                SizedBox(
                                                  width: width(16),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: width(10)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                            text:
                                                                "${cubit.chatsList[index].firstName} ${cubit.chatsList[index].lastName}",
                                                            fontsize: 16.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                kSecondaryColor),
                                                        cubit
                                                                    .lastMessagesList[
                                                                        index]
                                                                    .senderId ==
                                                                cubit
                                                                    .chatsList[
                                                                        index]
                                                                    .uid
                                                            ? CustomText(
                                                                text: cubit
                                                                    .lastMessagesList[
                                                                        index]
                                                                    .text,
                                                                fontsize: 14.sp,
                                                                height:
                                                                    height(1.6),
                                                                color: cubit
                                                                            .lastMessagesList[
                                                                                index]
                                                                            .isOpened ==
                                                                        false
                                                                    ? kPrimaryColor
                                                                    : kHintTextColor)
                                                            : CustomText(
                                                                text: cubit
                                                                    .lastMessagesList[
                                                                        index]
                                                                    .text,
                                                                fontsize: 14.sp,
                                                                height:
                                                                    height(1.6),
                                                                color:
                                                                    kHintTextColor),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              CustomText(
                                                  text: DateFormat('hh:mm')
                                                      .format(DateTime.parse(cubit
                                                              .lastMessagesList[
                                                                  index]
                                                              .dateTime!)
                                                          .toLocal()),
                                                  fontsize: 10.sp,
                                                  height: height(3),
                                                  color: kHintTextColor),
                                              NotOpenedDataWidget(
                                                index: index,
                                              ),
                                              /*SizedBox(
                    height: height(10),
                  ),
                  cubit.notOpenedMessages[index].toString() != "null"
                      ? CircleAvatar(
                          radius: width(10),
                          backgroundColor: kPrimaryColor,
                          child: CustomText(
                              text: cubit.notOpenedMessages[index].toString(),
                              fontsize: 10.sp,
                              color: Colors.white),
                        )
                      : Container(),*/
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => Divider(
                                  thickness: 0.8,
                                ),
                            itemCount: cubit.chatsList.length),
                    fallback: (context) => Column(
                      children: [
                        SizedBox(
                          height: height(150),
                        ),
                        Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
        },
      );
    });
  }
}

class NotOpenedDataWidget extends StatelessWidget {
  final int index;

  NotOpenedDataWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientCubit, ClientStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ClientCubit cubit = ClientCubit.get(context);
        return ConditionalBuilder(
            condition: state is! GetUserNotOpenedDataLoadingState,
            builder: (context) => cubit
                        .notOpenedMessages[cubit.chatsList[index].uid]
                        .toString() !=
                    "0"
                ? CircleAvatar(
                    radius: width(10),
                    backgroundColor: kPrimaryColor,
                    child: CustomText(
                        text: cubit
                            .notOpenedMessages[cubit.chatsList[index].uid]
                            .toString(),
                        fontsize: 10.sp,
                        color: Colors.white),
                  )
                : Container(),
            fallback: (context) => Container());
      },
    );
  }
}

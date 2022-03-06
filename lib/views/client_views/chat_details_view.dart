import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/message_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
import 'package:movies_app/widgets/custom_chat_form_field.dart';
import 'package:movies_app/widgets/custom_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatDetailsView extends StatelessWidget {
  final LogInModel logInModel;

  ChatDetailsView({required this.logInModel});

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    var messageController = TextEditingController();
    return Builder(builder: (BuildContext context) {
      ClientCubit.get(context).getUserMessages(
        receiverId: logInModel.uid!,
      );
      return BlocConsumer<ClientCubit, ClientStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ClientCubit cubit = ClientCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 4,
              shadowColor: Colors.grey.withOpacity(0.3),
              title: Row(
                children: [
                  CircleAvatar(
                    radius: width(20),
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(logInModel.image == null
                        ? "https://firebasestorage.googleapis.com/v0/b/movies-app-fe023.appspot.com/o/users%2Fvuesax-linear-profile-circle.png?alt=media&token=e81580b4-85d6-4fe1-8f5c-0814a260a52b"
                        : logInModel.image!),
                  ),
                  SizedBox(
                    width: width(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                          text:
                              "${logInModel.firstName} ${logInModel.lastName}",
                          fontsize: 16.sp,
                          fontWeight: FontWeight.bold,
                          height: height(1.8),
                          color: kSecondaryColor),
                    ],
                  )
                ],
              ),
              centerTitle: false,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/call.svg",
                      width: width(20),
                      height: height(20),
                    )),
                IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/icons/video.svg",
                      width: width(20),
                      height: height(20),
                    )),
              ],
            ),
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width(16), vertical: height(16)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ConditionalBuilder(
                          condition:
                              state is! GetAllUserMessagesDataLoadingState,
                          builder: (context) => cubit.userMessages.length != 0
                              ? ScrollablePositionedList.separated(
                                  itemScrollController: cubit.itemController,
                                  physics: BouncingScrollPhysics(),
                                  initialAlignment: 0.0,
                                  initialScrollIndex: cubit.userMessages.length,
                                  itemCount: cubit.userMessages.length,
                                  itemBuilder: (context, index) {
                                    var message = cubit.userMessages[index];
                                    if (cubit.logInModel!.uid ==
                                        message.senderId)
                                      return MyMessage(
                                        message: message,
                                      );

                                    return Message(
                                      message: message,
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: height(16),
                                  ),
                                )
                              : Center(
                                  child: CustomText(
                                      text: "No Current Messages",
                                      fontsize: 18.sp,
                                      color: kHintTextColor),
                                ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height(80),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: ChatFormField(
                        messageController: messageController,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            cubit.sendUserMessage(
                                receiverId: logInModel.uid!,
                                dateTime: DateTime.now().toUtc().toString(),
                                text: messageController.text);
                            FocusScope.of(context).unfocus();
                            messageController.clear();
                          }
                        },
                      )),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

class Message extends StatelessWidget {
  final MessageModel message;
  Message({required this.message});
  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(message.dateTime!).toLocal();
    final format = DateFormat('hh:mm');
    final clockString = format.format(dateTime);
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        width: width(261),
        decoration: BoxDecoration(
          color: Color(0xFFF3F3F3),
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              20.0,
            ),
            topStart: Radius.circular(
              20.0,
            ),
            topEnd: Radius.circular(
              20.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: height(5),
          horizontal: width(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomText(
                  text: message.text,
                  fontsize: 14.sp,
                  height: height(2),
                  color: kSecondaryColor),
            ),
            CustomText(
                text: clockString,
                fontsize: 10.sp,
                height: height(1.4),
                textAlign: TextAlign.right,
                color: kSecondaryColor),
          ],
        ),
      ),
    );
  }
}

class MyMessage extends StatelessWidget {
  final MessageModel message;

  MyMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(message.dateTime!).toLocal();
    final format = DateFormat('hh:mm');
    final clockString = format.format(dateTime);
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        width: width(159),
        decoration: BoxDecoration(
          color: Color(0xFF735FF2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
              20.0,
            ),
            topStart: Radius.circular(
              20.0,
            ),
            topEnd: Radius.circular(
              20.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: width(16),
          vertical: height(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomText(
                  text: message.text,
                  fontsize: 14.sp,
                  height: height(2),
                  color: Colors.white),
            ),
            CustomText(
                text: clockString,
                fontsize: 10.sp,
                height: height(1.4),
                textAlign: TextAlign.right,
                color: Colors.white),
          ],
        ),
      ),
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TeacherDetailsChatView extends StatelessWidget {
  final LogInModel userModel;
  TeacherDetailsChatView({required this.userModel});

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(
      builder: (BuildContext context) {
        ServicesCubit.get(context).getMessages(
          receiverId: userModel.uid!,
        );
        return BlocConsumer<ServicesCubit, ServicesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ServicesCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        userModel.image!,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      userModel.firstName!,
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: state is! GetMessagesLoadingState,
                builder: (context) => cubit.messages.length > 0 ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: ScrollablePositionedList.separated(
                          physics: BouncingScrollPhysics(),
                          itemScrollController: cubit.itemController,
                          initialAlignment: 0.0,
                          initialScrollIndex: cubit.messages.length,

                          itemBuilder: (context, index)
                          {
                            var message = cubit.messages[index];

                            if(cubit.teacherModel!.uid == message.senderId)
                              return buildMyMessage(message);

                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: cubit.messages.length,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[300]!,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your message here ...',
                                    hintStyle: Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 70.0,
                              color: kPrimaryColor,
                              child: MaterialButton(
                                onPressed: () async{
                                  cubit.sendMessage(
                                    receiverId: userModel.uid!,
                                    user: userModel,
                                    dateTime: DateTime.now().toString(),
                                    text: messageController.text,
                                  );
                                  messageController.clear();
                                  FocusScope.of(context).unfocus();
                                },
                                minWidth: 1.0,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ) : Center(
                  child: Text(
                    'No current messages',
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator(),),
              ),
            );
          },
        );
      },
    );
  }
  }

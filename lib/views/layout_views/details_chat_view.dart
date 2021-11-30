// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/view_models/explore_cubit/cubit.dart';
import 'package:movies_app/view_models/explore_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DetailsChatView extends StatelessWidget {
  final TeacherModel teacherModel;
  DetailsChatView({required this.teacherModel});

  @override
  Widget build(BuildContext context) {
    var messageController = TextEditingController();
    return Builder(
      builder: (BuildContext context) {
        ExploreCubit.get(context).getUserMessages(
          receiverId: teacherModel.uid!,
        );

        return BlocConsumer<ExploreCubit, ExploreStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = ExploreCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        teacherModel.image!,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      teacherModel.name!,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: state is! GetUserMessagesLoadingState,
                        builder: (context) => cubit.userMessages.length > 0 ? ScrollablePositionedList.separated(
                          itemScrollController: cubit.itemController,
                          physics: BouncingScrollPhysics(),
                          initialAlignment: 0.0,
                          initialScrollIndex: cubit.userMessages.length,
                          itemBuilder: (context, index)
                          {

                            var message = cubit.userMessages[index];
                            if(cubit.userModel!.uid == message.senderId)
                              return buildMyMessage(message);

                            return buildMessage(message);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 15.0,
                          ),
                          itemCount: cubit.userMessages.length,
                        ) : Center(
                          child: Text(
                            'No current messages',
                          ),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator(),),
                      ),
                    ),
                    SizedBox(height: 10.0,),
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
                                cubit.sendUserMessage(
                                  receiverId: teacherModel.uid!,
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
              ),

            );
          },
        );
      },
    );
  }
}
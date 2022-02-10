import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/message_model.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/models/subject_model.dart';
import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/view_models/find_teacher_cubit/cubit.dart';
import 'package:movies_app/views/layout_views/details_chat_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_details_chat_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:rating_dialog/rating_dialog.dart';



Widget buildSuggestionList(context, SubjectsModel subjectsModel) => Card(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Image(
              image: AssetImage(
                subjectsModel.image!,
              ),
              width: 60,
              height: 60,
            ),
            Text(
              subjectsModel.title!,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 18.0,
                  ),
            ),
          ],
        ),
      ),
    );

Widget decoratedTextButton({
  required String text,
  required void Function()? onPressed,
  required context,
}) =>
    Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
              color: kPrimaryColor,
            )),
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
            )),
      ),
    );

Widget ratingCard(context, ServicesModel model, dynamic id, String getRating) =>
    InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => dialog(context, model, id),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kSecondaryColor.withOpacity(0.3),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        width: MediaQuery.of(context).size.width / 6,
        child: Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 20.0,
            ),
            SizedBox(
              width: 3.0,
            ),
            Expanded(
                child: Text(
              getRating,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: kPrimaryColor),
            )),
          ],
        ),
      ),
    );

Widget teacherRatingCard(context, ServicesModel model, String rating) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kSecondaryColor.withOpacity(0.3),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      width: MediaQuery.of(context).size.width / 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20.0,
          ),
          Expanded(
              child: Text(
            rating,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: kPrimaryColor),
          )),
        ],
      ),
    );

Widget buildMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          model.text!,
        ),
      ),
    );

Widget buildMyMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(
            .2,
          ),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          model.text!,
        ),
      ),
    );

Widget buildTeacherChatItem(LogInModel model, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          TeacherDetailsChatView(
            userModel: model,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              '${model.firstName}',
              style: TextStyle(
                height: 1.4,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );

Widget buildUserChatItem(TeacherModel model, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          DetailsChatView(
            teacherModel: model,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            Text(
              '${model.name}',
              style: TextStyle(
                height: 1.4,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );

Widget dialog(context, ServicesModel model, dynamic id) => RatingDialog(
  enableComment: false,
  // your app's name?
  title: Text(model.name!),
  // encourage your user to leave a high rating?
  message: Text('Feel free to give this service a rate upon your experience'),
  // your app's logo?
  image: Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
      child: Image.network(model.image!, width: 100, height: 100,)),
  onCancelled: () => print('cancelled'),
  onSubmitted: (response) {
    FindTeachersCubit.get(context).updateRating(id, response.rating.toInt());
  }, submitButtonText: 'Submit',
);
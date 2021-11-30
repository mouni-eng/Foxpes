import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/message_model.dart';
import 'package:movies_app/models/onboarding_model.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/models/subject_model.dart';
import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/find_teacher_cubit/cubit.dart';
import 'package:movies_app/views/layout_views/details_chat_view.dart';
import 'package:movies_app/views/layout_views/find_teacher_view.dart';
import 'package:movies_app/views/layout_views/user_service_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_details_chat_view.dart';
import 'views/teacher_layout_views/service_details_view.dart';
import 'package:movies_app/views/layout_views/subjects_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';

void navigateTo(context, Widget screen) {
  // Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeftWithFade, child: screen, duration: const Duration(milliseconds: 700), reverseDuration: const Duration(milliseconds: 700)));
}

void navigateToAndFinish(context, Widget screen) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String? label,
  int? maxLines = 1,
  String? hintText,
  int? maxLength,
  required IconData? prefix,
  required BuildContext context,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        labelStyle: Theme.of(context).textTheme.bodyText2,
        prefixIcon: Icon(
          prefix,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(20)
        ),
      ),
      style: Theme.of(context).textTheme.bodyText2,
    );

Widget defaultTextField({
  FontWeight fontWeight = FontWeight.normal,
  required double size,
  required String text,
  required Color color,
  TextAlign? aligment,
  double? height = 1,
  int? maxLines = 1,
  TextDecoration? decoration,
  TextOverflow? overflow,
}) =>
    Text(text,
        maxLines: maxLines,
        overflow: overflow ?? null,
        textAlign: aligment,
        style: TextStyle(
          fontSize: size,
          fontWeight: fontWeight,
          color: color,
          height: height,
          decoration: decoration ?? null,
        ));

Widget defaultButton({
  double width = double.infinity,
  Color background = kPrimaryColor,
  bool isUpperCase = true,
  double height = 50.0,
  double radius = 20.0,
  required Function()? function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColor(state: state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { SUCCESS, WARNING, ERROR }

Color chooseColor({required ToastState state}) {
  Color color;

  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}

Widget buildServicesList(context) => Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    InkWell(
      onTap: () {
        navigateTo(context, SubjectsView());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(IconBroken.Profile, size: 30.0,),
              SizedBox(
                width: 15.0,
              ),
              Text(
                LocaleKeys.service1.tr(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 18.0,
                    ),
              ),
            ],
          ),
        ),
      ),
    ),
    InkWell(
      onTap: () {
        navigateTo(context, SubjectsView());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(IconBroken.Document, size: 30.0,),
              SizedBox(
                width: 15.0,
              ),
              Text(
                LocaleKeys.service2.tr(),
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);

Widget buildSuggestionList(context, SubjectsModel subjectsModel) => Card(
  child: Padding(
    padding: const EdgeInsets.all(25.0),
    child: Column(
      children: [
        Image(image: AssetImage(subjectsModel.image!,), width: 60, height: 60,),
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

Widget buildSubjectsList(context, SubjectsModel subjectsModel, String key) => InkWell(
  onTap: () {
    FindTeachersCubit.get(context).getAllTeacherData(key: key);
    navigateTo(context, FindTeacherView(teacherKey: subjectsModel.title!,));
  },
  child: Padding(
    padding: const EdgeInsets.all(25.0),
    child: Row(
      children: [
        Image(image: AssetImage(subjectsModel.image!,), width: 40, height: 40,),
        SizedBox(
          width: 25.0,
        ),
        Text(
          subjectsModel.title!,
          style: Theme.of(context).textTheme.bodyText2!.copyWith(
            fontSize: 17.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    ),
  ),
);


Widget onBoardingBuild(OnBoardingModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: SvgPicture.asset('${model.image}')),
      SizedBox(
        height: 30.0,
      ),
      Text(
        "${model.title}",
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    ],
  );
}


DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
    value: item, child: defaultTextField(
    text: item,
      size: 14.0,
      color: Colors.grey,
  ),
  );
}

Widget decoratedTextButton({
  required String text,
  required void Function()? onPressed,
  required context,
}) => Expanded(
  child:   Container(
    margin: EdgeInsets.symmetric(horizontal: 2.w),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25.0),
    border: Border.all(
    color: kPrimaryColor,
    )
    ),
    child: TextButton(onPressed: onPressed, child: Text(text, style: Theme.of(context).textTheme.caption!.copyWith(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    ),)),
    ),
);



Widget buildServiceCard(context, ServicesModel model, dynamic id,) => Card(

  elevation: 3.0,

  child: Column(

    crossAxisAlignment: CrossAxisAlignment.end,

    children: [

      Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Padding(

            padding: const EdgeInsets.all(10.0),

            child: CircleAvatar(

                radius: 40.0,

                foregroundColor: Colors.white,

                backgroundColor: kPrimaryColor,

                backgroundImage: NetworkImage(model.image!)),

          ),

          SizedBox(

            width: 10.0,

          ),

          Expanded(child:

          Padding(

            padding: const EdgeInsets.only(top: 8.0),

            child: RichText(

              text: TextSpan(

                style: Theme.of(context).textTheme.bodyText1,

                children: <TextSpan>[

                  TextSpan(text: model.name!.split(" ").first.toUpperCase(),),

                  TextSpan(text: "   ${model.age} years old \n ", style: Theme.of(context).textTheme.bodyText2),

                  TextSpan(text: "${model.nationality}\n", style: Theme.of(context).textTheme.bodyText2),

                  TextSpan(text: model.education, style: Theme.of(context).textTheme.bodyText2),

                ],

              ),

            ),

          )),

          SizedBox(width: 12.0,)

        ],

      ),

      Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Expanded(

            child: Padding(

              padding: const EdgeInsets.all(8.0),

              child: Text('KWD ${model.hourRate!}/hour', style: Theme.of(context).textTheme.bodyText1!.copyWith(

                color: kPrimaryColor,

                fontSize: 16.0,

              ),),

            ),

          ),

          Padding(

            padding: const EdgeInsets.all(8.0),

            child: defaultButton(function: () {
              FindTeachersCubit.get(context).getRating(id);
              navigateTo(context, ServiceDetailsView(servicesModel: model, id: id,));
            }, height: 35.0, isUpperCase: false, text: 'Select Profile', width: MediaQuery.of(context).size.width / 2.5),

          ),

        ],

      ),

    ],

  ),

);

Widget buildTeacherCard(context, ServicesModel model) => Card(

  elevation: 3.0,

  child: Column(

    crossAxisAlignment: CrossAxisAlignment.end,

    children: [

      Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Padding(

            padding: EdgeInsets.all(3.w),

            child: CircleAvatar(

                radius: 40,

                foregroundColor: Colors.white,

                backgroundColor: kPrimaryColor,

                backgroundImage: NetworkImage(model.image!)),

          ),

          SizedBox(

            width: 2.w,

          ),

          Expanded(child:

          Padding(

            padding: EdgeInsets.only(top: 2.h),

            child: RichText(

              text: TextSpan(

                style: Theme.of(context).textTheme.bodyText1,

                children: <TextSpan>[

                  TextSpan(text: model.name!.split(" ").first.toUpperCase(),),

                  TextSpan(text: "   ${model.age} years old \n ", style: Theme.of(context).textTheme.bodyText2),

                  TextSpan(text: "${model.nationality}\n", style: Theme.of(context).textTheme.bodyText2),

                  TextSpan(text: model.education, style: Theme.of(context).textTheme.bodyText2),

                ],

              ),

            ),

          )),

        ],

      ),

      Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          Expanded(

            child: Padding(

              padding: EdgeInsets.all(2.w),

              child: Text('KWD ${model.hourRate!}/hour', style: Theme.of(context).textTheme.bodyText1!.copyWith(

                color: kPrimaryColor,

                fontSize: 14.sp,

              ),),

            ),

          ),

          Padding(

            padding: EdgeInsets.all(2.w),

            child: defaultButton(function: () {
              ServicesCubit.get(context).getServiceRating(model.uid);
              navigateTo(context, TeacherServiceDetailsView(servicesModel: model,));
            }, height: 6.h, isUpperCase: false, text: 'Preview Service', width: 40.w),

          ),

        ],

      ),

    ],

  ),

);

Widget ratingCard(context, ServicesModel model, dynamic id, String getRating) => InkWell(
  onTap: () {
    showDialog(
      context: context,
      builder: (context) => dialog(context, model, id),
    );
  },
  child:   Container(

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(10),

      color: kSecondaryColor.withOpacity(0.3),

    ),

    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),

    width: MediaQuery.of(context).size.width / 6,

    child: Row(

      children: [

        Icon(Icons.star, color: Colors.yellow, size: 20.0,),
        SizedBox(width: 3.0,),
        Expanded(child: Text(getRating, overflow: TextOverflow.ellipsis, style: TextStyle(color: kPrimaryColor),)),

      ],

    ),

  ),
);

Widget teacherRatingCard(context, ServicesModel model, String rating) => Container(
  decoration: BoxDecoration(

    borderRadius: BorderRadius.circular(10),

    color: kSecondaryColor.withOpacity(0.3),

  ),

  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),

  width: MediaQuery.of(context).size.width / 6,

  child: Row(

    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [

      Icon(Icons.star, color: Colors.yellow, size: 20.0,),

      Expanded(child: Text(rating, overflow: TextOverflow.ellipsis, style: TextStyle(color: kPrimaryColor),)),

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
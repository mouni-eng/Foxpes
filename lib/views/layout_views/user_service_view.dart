// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/view_models/find_teacher_cubit/cubit.dart';
import 'package:movies_app/view_models/find_teacher_cubit/states.dart';
import 'package:movies_app/views/layout_views/details_chat_view.dart';
import 'package:movies_app/widgets.dart';
import 'package:sizer/sizer.dart';

class ServiceDetailsView extends StatelessWidget {
  final ServicesModel servicesModel;
  final dynamic id;
  ServiceDetailsView({required this.servicesModel, required this.id,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindTeachersCubit, FindTeachersStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = FindTeachersCubit.get(context);
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 10,
                child: Stack(alignment: Alignment.topCenter, children: [
                  Stack(children: [
                    Image.network(
                      servicesModel.image!,
                      width: double.infinity,
                      height: 37.h,
                      fit: BoxFit.fill,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 30.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: InkWell( onTap: () {Navigator.pop(context);}, child: Icon(IconBroken.Arrow___Left_2)),
                        )),
                  ]),
                  Container(
                    margin: EdgeInsets.only(top: 34.h),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    padding: const EdgeInsets.all(20.0),
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    servicesModel.name!.split(" ").first.toUpperCase(),
                                    style:
                                    Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  Text(
                                    "KWD ${servicesModel.hourRate}/hour",
                                    style:
                                    Theme.of(context).textTheme.bodyText2!.copyWith(
                                      height: 1.1,
                                    ),
                                  ),
                                ],
                              ),
                              ConditionalBuilder(
                                  condition: cubit.allTeachersRating!.length > 0,
                                  builder: (context) => ratingCard(context, servicesModel, id, cubit.allTeachersRating!.last.toString()),
                                  fallback: (context) => ratingCard(context, servicesModel, id, "NA"),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('About Me',
                                  style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(height: 1.h,),
                              Text(servicesModel.aboutMe!,
                                  style: Theme.of(context).textTheme.bodyText2),
                              SizedBox(height: 1.h,),
                              Row(
                                children: [
                                  Text("${servicesModel.age!} years old",
                                      style: Theme.of(context).textTheme.bodyText2),
                                  SizedBox(width: 5.w,),
                                  Text(servicesModel.nationality!,
                                      style: Theme.of(context).textTheme.bodyText2),
                                  SizedBox(width: 2.w,),
                                  Image.asset(
                                    servicesModel.flag!,
                                    package: 'country_code_picker',
                                    width: 8.w,
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.5.h,),
                              Divider(thickness: 0.8,),
                              SizedBox(height: 1.5.h,),
                              Text('Education',
                                  style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(height: 1.5.h,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(IconBroken.Bookmark),
                                  SizedBox(width: 2.5.w,),
                                  Expanded(
                                    child: Text(servicesModel.education!,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(height: 1.5.h,),
                              Divider(thickness: 0.8,),
                              SizedBox(height: 1.5.h,),
                              Text('Experience',
                                  style: Theme.of(context).textTheme.bodyText1),
                              SizedBox(height: 1.5.h,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(IconBroken.Paper),
                                  SizedBox(width: 2.5.w,),
                                  Expanded(
                                    child: Text(servicesModel.experience!,
                                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("Let ${servicesModel.name!.split(" ").first} Know what you need help with",),
                        SizedBox(height: 1.h,),
                        defaultButton(function: (){
                          navigateTo(context, DetailsChatView(teacherModel: TeacherModel(name: servicesModel.name, uid: servicesModel.uid, image: servicesModel.image)));
                        }, text: "Send Message", height: 6.h, isUpperCase: false),
                      ],
                    ),
                  ),
                ),),
            ],
          ),
        );
      },
    );
  }
}

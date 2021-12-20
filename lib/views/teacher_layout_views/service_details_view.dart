// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import 'package:sizer/sizer.dart';

class TeacherServiceDetailsView extends StatelessWidget {
  final ServicesModel servicesModel;
  TeacherServiceDetailsView({required this.servicesModel});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ServicesCubit cubit = ServicesCubit.get(context);
        return Scaffold(
          body: Stack(alignment: Alignment.topCenter, children: [
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
              padding: EdgeInsets.all(2.h),
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
                            condition: cubit.allTeachersRating.length > 0,
                            builder: (context) => teacherRatingCard(context, servicesModel, cubit.allTeachersRating.last.toString()),
                            fallback: (context) => teacherRatingCard(context, servicesModel, "NA"),
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
        );
      },
    );
  }
}

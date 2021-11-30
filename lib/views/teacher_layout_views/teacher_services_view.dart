// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/widgets.dart';
import 'package:sizer/sizer.dart';


class TeacherServicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesStates>(
        listener: (context, states) {},
        builder: (context, states) {
          ServicesCubit cubit = ServicesCubit.get(context);
          return
            ConditionalBuilder(
            condition: states is! GetTeacherLoadingState && states is! GetServiceLoadingState && states is! GetChatDataLoadingState,
            builder: (context) => cubit.teacherServices!.length != 0 ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildTeacherCard(context, cubit.teacherServices![index]),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 2.h,
                        ),
                        itemCount: cubit.teacherServices!.length
                    ),
                  ),
                ],
              ),
            ) : Center(
              child: Text('No current services', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                fontSize: 18.sp,
              ),),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
        },
    );
  }
}

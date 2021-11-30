// ignore: import_of_legacy_library_into_null_safe
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/view_models/find_teacher_cubit/cubit.dart';
import 'package:movies_app/view_models/find_teacher_cubit/states.dart';
import 'package:movies_app/widgets.dart';

class FindTeacherView extends StatelessWidget {
  final String teacherKey;
  FindTeacherView({required this.teacherKey});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$teacherKey Tutors", style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontSize: 20.0,
        ),),
        leading: IconButton(icon: Icon(IconBroken.Close_Square, color: Colors.red,), onPressed: () {Navigator.pop(context);},),
      ),
      body: BlocConsumer<FindTeachersCubit, FindTeachersStates>(
        listener: (context, state) {},
        builder: (context, state) {
          FindTeachersCubit cubit = FindTeachersCubit.get(context);
          return ConditionalBuilder(
            condition: state is! GetAllTeacherLoadingState,
            builder: (context) => cubit.allTeachersServices!.length != 0 ?  SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildServiceCard(context, cubit.allTeachersServices![index], cubit.allTeachersServicesId![index],),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 20.0,
                        ),
                        itemCount: cubit.allTeachersServices!.length
                    ),
                  ],
                ),
              ),
            ) : Center(child: Text('No current services', style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 18.0,
            ),),),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          );
        },
      ),
    );
  }
}

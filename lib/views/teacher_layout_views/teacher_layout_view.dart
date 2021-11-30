import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/App_Cubit/states.dart';
import 'package:easy_localization/easy_localization.dart';

class TeacherLayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> teacherTitles = [
      LocaleKeys.teacherAppBar1.tr(),
      LocaleKeys.teacherAppBar2.tr(),
      LocaleKeys.teacherAppBar3.tr(),
      LocaleKeys.teacherAppBar4.tr(),
    ];
    List<BottomNavigationBarItem> teacherBottomNavigationBarItem = [
      BottomNavigationBarItem(
          label: teacherTitles[0],
          icon: Icon(IconBroken.Document)
      ),
      BottomNavigationBarItem(
        label: teacherTitles[1],
        icon: Icon(IconBroken.Upload),
      ),
      BottomNavigationBarItem(
          label: teacherTitles[2],
          icon: Icon(IconBroken.Message)
      ),
      BottomNavigationBarItem(
          label: teacherTitles[3],
          icon: Icon(IconBroken.Profile)
      ),
    ];
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(teacherTitles[cubit.teacherCurrentIndex]),
          ),
          body: cubit.teacherScreens[cubit.teacherCurrentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.teacherCurrentIndex,
            onTap: (index) {
              cubit.teacherChangeBottomNav(index);
            },
            items: teacherBottomNavigationBarItem,
          ),
        );
      },
    );
  }
}


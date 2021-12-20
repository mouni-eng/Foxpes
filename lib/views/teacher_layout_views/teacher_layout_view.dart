import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/App_Cubit/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:sizer/sizer.dart';


class TeacherLayoutView extends StatefulWidget {
  @override
  State<TeacherLayoutView> createState() => _TeacherLayoutViewState();
}

class _TeacherLayoutViewState extends State<TeacherLayoutView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ServicesCubit.get(context).teacherNotificationHandler(context);
  }

  @override
  Widget build(BuildContext context) {

    ServicesCubit cubit = ServicesCubit.get(context);

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
          icon: Stack(
              overflow: Overflow.visible,
              children: [
                Icon(IconBroken.Message),
                  if(cubit.teacherMessages.length > 0)
                  Positioned(
                    top: -6,
                    right: -3,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0.6.w),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(cubit.teacherMessages.length.toString(), style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp
                      ),),
                    ),
                  )
              ]),
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


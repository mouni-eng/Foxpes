import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/services/helper/icon_broken.dart';
import 'package:movies_app/translate/locale_keys.g.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/App_Cubit/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:movies_app/view_models/explore_cubit/cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutView extends StatefulWidget {

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ExploreCubit.get(context).notificationHandler(context);
  }

  @override
  Widget build(BuildContext context) {

    List<String> titles = [
      LocaleKeys.appBar1.tr(),
      LocaleKeys.appBar2.tr(),
      LocaleKeys.appBar3.tr(),
    ];
    List<BottomNavigationBarItem> bottomNavigationBarItem = [
      BottomNavigationBarItem(
          label: titles[0],
          icon: Icon(IconBroken.Home)
      ),
      BottomNavigationBarItem(
        label: titles[1],
        icon: Stack(
            overflow: Overflow.visible,
            children: [
              Icon(IconBroken.Message),
              if(ExploreCubit.get(context).messages.length != 0)
                Positioned(
                  top: -6,
                  right: -3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0.6.w),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(ExploreCubit.get(context).messages.length.toString(), style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp
                    ),),
                  ),
                )
            ]),
      ),
      BottomNavigationBarItem(
          label: titles[2],
          icon: Icon(IconBroken.Profile)
      ),
    ];
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, states) {},
      builder: (context, states) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(titles[cubit.currentIndex]),
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {cubit.changeBottomNav(index);},
            items: bottomNavigationBarItem,
          ),
        );
      },
    );
  }
}
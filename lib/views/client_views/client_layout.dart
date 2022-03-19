import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/translations/locale_keys.g.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
class ClientLayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
      List<BottomNavigationBarItem> bottomNavBarList = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/icons/home.svg",
        width: width(20.1),
        height: height(20.1),
      ),
      activeIcon: SvgPicture.asset(
        "assets/icons/home-2.svg",
        width: width(20.1),
        height: height(20.1),
      ),
      label: LocaleKeys.home.tr(),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/icons/sms.svg",
        width: width(20.1),
        height: height(20.1),
      ),
      activeIcon: SvgPicture.asset(
        "assets/icons/sms-2.svg",
        width: width(20.1),
        height: height(20.1),
      ),
      label: LocaleKeys.messages.tr(),
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        "assets/icons/profile.svg",
        width: width(20.1),
        height: height(20.1),
      ),
      activeIcon: SvgPicture.asset(
        "assets/icons/profile-2.svg",
        width: width(20.1),
        height: height(20.1),
      ),
      label: LocaleKeys.settings.tr(),
    ),
  ];
    return BlocConsumer<ClientCubit, ClientStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ClientCubit cubit = ClientCubit.get(context);
        return Scaffold(
          backgroundColor: Color(0xFFFEFEFE),
          body: SafeArea(
              child: Padding(
            padding: EdgeInsets.only(
              left: width(16),
              right: width(16),
              top: height(16),
            ),
            child: cubit.screens[cubit.currentIndex],
          )),
          bottomNavigationBar: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 3, //spread radius
                  blurRadius: 5, // blur radius
                  offset: Offset(3, 3), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: BottomNavigationBar(
                items: bottomNavBarList,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeBottomNav(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

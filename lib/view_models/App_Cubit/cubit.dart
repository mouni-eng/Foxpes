import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/view_models/App_Cubit/states.dart';
import 'package:movies_app/views/auth_views/login_view.dart';
import 'package:movies_app/views/layout_views/explore_view.dart';
import 'package:movies_app/views/layout_views/layout_view.dart';
import 'package:movies_app/views/layout_views/messages_view.dart';
import 'package:movies_app/views/layout_views/settings_view.dart';
import 'package:movies_app/views/starting_views/onboarding_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_addServices_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_layout_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_messages_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_services_view.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_settings_view.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  String? myUid, myCategorie;
  bool? isBoarding;
  bool isDark = false;

  void getCacheData() {
    isBoarding = CacheHelper.getData(key: "onBoarding");
    myUid = CacheHelper.getData(key: "uId");
    myCategorie = CacheHelper.getData(key: "categorie");
    categorie = myCategorie;
    uId = myUid;
    print(categorie);
    print(uId);
    emit(AppInitialPageState());
  }

  Widget chooseInitialPage() {
    if(isBoarding != null) {
      if(uId == null || categorie == null) {
        return LoginView();
      }else if(categorie == "teacher") {
        return TeacherLayoutView();
      }else {
        return LayoutView();
      }
    }else return OnBoardingScreen();
  }

  // section handling the Bottom Nav Bar

  List<Widget> screens = [
    ExploreView(),
    MessagesView(),
    SettingsView(),
  ];

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  // section handling the bottomNavBar for teacher app

  List<Widget> teacherScreens = [
    TeacherServicesView(),
    AddServicesView(),
    TeacherMessagesView(),
    TeacherSettingsView(),
  ];

  int teacherCurrentIndex = 0;

  void teacherChangeBottomNav(int index) {
    teacherCurrentIndex = index;
    emit(TeacherAppBottomNavBarState());
  }


  void getToken() async {
      var token = await FirebaseMessaging.instance.getToken();
      tokenMessages = token;
    }

  }
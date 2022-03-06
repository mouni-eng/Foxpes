import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/view_models/App_Cubit/states.dart';
import 'package:movies_app/views/auth_views/login_view.dart';
import 'package:movies_app/views/client_views/client_layout.dart';
import 'package:movies_app/views/partner_views/partner_home.dart';
import 'package:movies_app/views/starting_views/onboarding_view.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppStates());

  static AppCubit get(context) => BlocProvider.of(context);

  String? myUid, myCategorie;
  bool? isBoarding;

  void getCacheData() {
    isBoarding = CacheHelper.getData(key: "onBoarding");
    myUid = CacheHelper.getData(key: "uId");
    myCategorie = CacheHelper.getData(key: "categorie");
    uId = myUid;
    categorie = myCategorie;
    emit(AppInitialPageState());
  }

  Widget chooseInitialPage() {
    if (isBoarding != null) {
      if (uId == null || categorie == null) {
        return LoginView();
      } else if (categorie == "Student") {
        return ClientLayoutView();
      } else {
        return PartnerHomeView();
      }
    } else
      return OnBoardingScreen();
  }

  void getToken() async {
    var token = await FirebaseMessaging.instance.getToken();
    tokenMessages = token;
  }
}

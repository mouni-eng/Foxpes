import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/translate/codegen_loader.g.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/App_Cubit/states.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Services_cubit/cubit.dart';
import 'package:movies_app/view_models/bloc_observer.dart';
import 'package:movies_app/view_models/explore_cubit/cubit.dart';
import 'package:movies_app/view_models/find_teacher_cubit/cubit.dart';
import 'package:movies_app/views/starting_views/onboarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations/',
      assetLoader:
          CodegenLoader(), // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: Foxpes()));
}

class Foxpes extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..getCacheData()
              ..getToken()),
        BlocProvider(
            create: (BuildContext context) => ExploreCubit()
              ..getUserData()
              ..getUserChats()),
        BlocProvider(
            create: (BuildContext context) => ServicesCubit()
              ..getTeacherData()
              ..getService()
              ..getChats()),
        BlocProvider(create: (BuildContext context) => FindTeachersCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          AppCubit cubit = AppCubit.get(context);
          return ScreenUtilInit(
              designSize: Size(375, 812),
              minTextAdapt: false,
              builder: () => MaterialApp(
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    debugShowCheckedModeBanner: false,
                    title: 'Foxpes',
                    theme: lightTheme,
                    home: OnBoardingScreen(),
                  ));
        },
      ),
    );
  }
}

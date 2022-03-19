import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/notification_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/services/network/notfications.dart';
import 'package:movies_app/translations/codegen_loader.g.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/App_Cubit/states.dart';
import 'package:movies_app/view_models/Auth_Cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/cubit.dart';
import 'package:movies_app/view_models/bloc_observer.dart';
import 'package:movies_app/view_models/find_partner_cubit/cubit.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  if (message.data['type'] == "chat") {
    ClientCubit.get(Foxpes.navigatorKey.currentContext).changeBottomNav(1);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationCenter().initNotification();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification!;
    if (message.data['type'] == "chat") {
      if (ClientCubit.get(Foxpes.navigatorKey.currentContext).currentIndex !=
          1) {
        NotificationCenter.showNotification(
            title: notification.title!, body: notification.body!);
        ClientCubit.get(Foxpes.navigatorKey.currentContext).addNotificationList(
            NotificationMessage(
                text: notification.body, title: notification.title));
      } else {
        ClientCubit.get(Foxpes.navigatorKey.currentContext).getUserChats();
      }
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(message.data['type']);
    if (message.data['type'] == "chat") {
      ClientCubit.get(Foxpes.navigatorKey.currentContext).changeBottomNav(1);
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
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
            create: (BuildContext context) => ClientCubit()..getUserData()),
        BlocProvider(create: (BuildContext context) => FindPartnerCubit()),
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
                    navigatorKey: navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: 'Foxpes',
                    theme: lightTheme,
                    home: cubit.chooseInitialPage(),
                  ));
        },
      ),
    );
  }
}

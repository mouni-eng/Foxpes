import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/models/subject_model.dart';
import 'package:movies_app/view_models/find_teacher_cubit/cubit.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:sizer/sizer.dart';

ThemeData lightTheme = ThemeData(
    accentColor: kPrimaryColor,
    iconTheme: IconThemeData(
      color: kPrimaryColor,
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Color(0xFFEEFAFA),
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFEEFAFA),
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
          color: kPrimaryColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          fontFamily: "Jannah",
        ),
        iconTheme: IconThemeData(
          color: kPrimaryColor,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFFEEFAFA),
      elevation: 30.0,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 16.sp,
        color: kSecondaryColor,
        fontWeight: FontWeight.w700,
        fontFamily: "Jannah",
      ),
      bodyText2: TextStyle(
        fontSize: 12.sp,
        color: Colors.grey,
        fontFamily: "Jannah",
      ),
      subtitle1: TextStyle(
        fontSize: 20.sp,
        color: kSecondaryColor,
        fontWeight: FontWeight.w700,
        fontFamily: "Jannah",
      ),
    ));

/*ThemeData darkTheme = ThemeData(
    accentColor: Colors.red,
    iconTheme: IconThemeData(
      color: Colors.red,
    ),
    cardTheme: CardTheme(
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFF171821),
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF171821),
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF171821),
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Jannah",
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red,
      backgroundColor: Color(0xFF171821),
      unselectedItemColor: Colors.grey,
      elevation: 30.0,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontFamily: "Jannah",

      ),
      bodyText2: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
        fontFamily: "Jannah",
      ),
    ));*/

const kPrimaryColor = Color(0xFF735FF2);

const kSecondaryColor = Colors.blueGrey;

String? uId;
String? tokenMessages;
String? categorie;

List<String> fields = [
  "Arabic",
  "Art ",
  "Biology",
  "Chemistry",
  "English",
  "French",
  "General",
  "Geology",
  "German",
  "History",
  "Italian",
  "Math",
  "Philosophy",
  "Physics",
  "Programming",
  "Quran",
  "Religion",
  "Science",
  "Spanish",
  "Social Studies",
];

List<SubjectsModel> subjectsList = [
  SubjectsModel(
      title: "Arabic",
      image: "assets/images/arabic.png"),
  SubjectsModel(
      title: "Art",
      image: "assets/images/tools.png"),
  SubjectsModel(
      title: "Biology",
      image: "assets/images/bio.png"),
  SubjectsModel(
      title: "Chemistry",
      image: "assets/images/chemistry.png"),
  SubjectsModel(
      title: "English",
      image: "assets/images/english.png"),
  SubjectsModel(
      title: "French",
      image: "assets/images/french.png"),
  SubjectsModel(
      title: "General",
      image: "assets/images/general.png"),
  SubjectsModel(
      title: "Geography",
      image: "assets/images/geo.png"),
  SubjectsModel(
      title: "German",
      image: "assets/images/germany.png"),
  SubjectsModel(
      title: "History",
      image: "assets/images/history.png"),
  SubjectsModel(
      title: "Italian",
      image: "assets/images/italy.png"),
  SubjectsModel(
      title: "Math",
      image: "assets/images/math.png"),
  SubjectsModel(
      title: "Philosophy",
      image: "assets/images/philo.png"),
  SubjectsModel(
      title: "Physics",
      image: "assets/images/physics.png"),
  SubjectsModel(
      title: "Programming",
      image: "assets/images/coding.png"),
  SubjectsModel(
      title: "Quran",
      image: "assets/images/quran.png"),
  SubjectsModel(
      title: "Religion",
      image: "assets/images/pray.png"),
  SubjectsModel(
      title: "Science",
      image: "assets/images/science.png"),
  SubjectsModel(
      title: "Spanish",
      image: "assets/images/spain.png"),
  SubjectsModel(
      title: "Social Studies",
      image: "assets/images/ss.png"),
];

Widget dialog(context, ServicesModel model, dynamic id) => RatingDialog(
  enableComment: false,
  // your app's name?
  title: model.name!,
  // encourage your user to leave a high rating?
  message:
  'Feel free to give this service a rate upon your experience',
  // your app's logo?
  image: Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
      child: Image.network(model.image!, width: 100, height: 100,)),
  submitButton: 'Submit',
  onCancelled: () => print('cancelled'),
  onSubmitted: (response) {
    FindTeachersCubit.get(context).updateRating(id, response.rating);
  },
);

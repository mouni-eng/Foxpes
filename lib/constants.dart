import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/models/country_model.dart';
import 'package:movies_app/models/onboarding_model.dart';
import 'package:movies_app/models/subject_model.dart';
import 'package:movies_app/services/helper/country_list.dart';

ThemeData lightTheme = ThemeData(
    accentColor: kPrimaryColor,
    cardTheme: CardTheme(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleSpacing: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle: TextStyle(
        color: kPrimaryColor,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        fontFamily: "Cairo",
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFFEEFAFA),
      elevation: 30.0,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.sp,
        color: kSecondaryColor,
        fontWeight: FontWeight.w700,
        fontFamily: "Cairo",
      ),
      bodyText2: TextStyle(
        fontSize: 13.sp,
        color: kHintTextColor,
        fontFamily: "Cairo",
      ),
      subtitle2: TextStyle(
        fontSize: 15.sp,
        color: kSecondaryColor,
        fontFamily: "Cairo",
        fontWeight: FontWeight.w500,
      ),
      subtitle1: TextStyle(
        fontSize: 18.sp,
        color: kSecondaryColor,
        fontWeight: FontWeight.w600,
        fontFamily: "Cairo",
      ),
      headline1: TextStyle(
        fontSize: 18.sp,
        color: kSecondaryColor,
        fontWeight: FontWeight.w600,
        fontFamily: "Cairo",
      ),
    ));

const kPrimaryColor = Color(0xFF735FF2);

const kSecondaryColor = Colors.black;

const kTextFieldColor = Color(0xFFE4E4E4);

const kHintTextColor = Color(0xFF7A7A7A);

const kOnBoardingTextColor = Color(0xFFB5B5B5);

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

List<CountryModel> elements =
    codes.map((json) => CountryModel.fromJson(json)).toList();

List<String> faculties = [
  "Computer science",
  "Engineering",
  "Law",
  "Art",
  "Buissniss",
  "Pharmacy",
  "Medecine",
  "Dentistry",
  "Other",
];

List<String> skills = [
  "grammer",
  "speaking",
  "listening",
];

List<String> experience = [
  "2 years",
  "4 years",
  "6 years",
  "8 years",
  "10 years",
  "More than 10 years",
];

List<String> education = [
  "Bachelor's Degree",
  "High School",
  "Not educated",
];

List<String> status = [
  "Single",
  "Taken",
];

List<String> 

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
  SubjectsModel(title: "Arabic", image: "assets/images/arabic.png"),
  SubjectsModel(title: "Art", image: "assets/images/tools.png"),
  SubjectsModel(title: "Biology", image: "assets/images/bio.png"),
  SubjectsModel(title: "Chemistry", image: "assets/images/chemistry.png"),
  SubjectsModel(title: "English", image: "assets/images/english.png"),
  SubjectsModel(title: "French", image: "assets/images/french.png"),
  SubjectsModel(title: "General", image: "assets/images/general.png"),
  SubjectsModel(title: "Geography", image: "assets/images/geo.png"),
  SubjectsModel(title: "German", image: "assets/images/germany.png"),
  SubjectsModel(title: "History", image: "assets/images/history.png"),
  SubjectsModel(title: "Italian", image: "assets/images/italy.png"),
  SubjectsModel(title: "Math", image: "assets/images/math.png"),
  SubjectsModel(title: "Philosophy", image: "assets/images/philo.png"),
  SubjectsModel(title: "Physics", image: "assets/images/physics.png"),
  SubjectsModel(title: "Programming", image: "assets/images/coding.png"),
  SubjectsModel(title: "Quran", image: "assets/images/quran.png"),
  SubjectsModel(title: "Religion", image: "assets/images/pray.png"),
  SubjectsModel(title: "Science", image: "assets/images/science.png"),
  SubjectsModel(title: "Spanish", image: "assets/images/spain.png"),
  SubjectsModel(title: "Social Studies", image: "assets/images/ss.png"),
];

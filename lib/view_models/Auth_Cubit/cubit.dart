import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/baby_sitter_views/babysitter_signup_view.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/drivers_views/driver_signup_view.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/teacher_views/teacher_signup_view.dart';
import 'package:movies_app/views/auth_views/upload_pic_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());
  static AuthCubit get(context) => BlocProvider.of(context);

  String suffix = "assets/images/icon-off.svg";
  bool isPassword = false;
  String? gender;
  String? category;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void chooseGender(String genders) {
    gender = genders;
    emit(SignUpChangeGenderState());
  }

  void chooseCategories(String categories) {
    category = categories;
    emit(SignUpChangeCategoryState());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? "assets/images/icon-on.svg" : "assets/images/icon-off.svg";
    emit(LogInChangePasswordVisibilityState());
  }
  // method for handling sign in for users

  void signIn({required String email, password}) {
    emit(LogInLoadingState());
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(value.user!.uid)
          .update({"token": tokenMessages});
      emit(LogInSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      emit(LogInErrorState(error: error.toString()));
    });
  }

  // method for handling sign up for users

  void signUp(
      {required String email,
      password,
      phone,
      firstName,
      lastName,
      country,
      gender,
      category}) {
    emit(SignUpLoadingState());
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      LogInModel logInModel = LogInModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        country: country,
        uid: value.user!.uid,
        phone: phone,
        image: "assets/images/profile-circle.svg",
        token: tokenMessages,
        gender: gender,
        category: category,
      );
      createUser(logInModel: logInModel);
      emit(SignUpSuccessState());
    }).catchError((error) {
      emit(SignUpErrorState(error: error.toString()));
    });
  }

  void createUser({required LogInModel logInModel}) {
    emit(CreateUserLoadingState());
    _firestore
        .collection("user")
        .doc(logInModel.uid)
        .set(logInModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState(logInModel: logInModel));
    }).catchError((error) {
      emit(CreateUserErrorState(error: error.toString()));
    });
  }

  // methods handling editing the user profile

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> uploadProfileImage(
      {required String email, password, phone, name, field, uid}) async {
    /*emit(TeacherUploadLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        teacherModel = TeacherModel(
          email: email,
          name: name,
          uid: uid,
          phone: phone,
          image: value,
          field: field,
          status: "Pending",
          token: tokenMessages,
        );
        emit(TeacherUploadProfileImageSuccessState());
        createTeacher();
      }).catchError((error) {
        emit(TeacherUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(TeacherUploadProfileImageErrorState());
    });
    */
  }

  nextSignUpScreen({required context, required LogInModel logInModel}) {
    if (category == "student") {
      navigateTo(context, UploadProfilePictureView());
    } else if (category == "Teacher") {
      navigateTo(
          context,
          TeacherSignUpView(
            logInModel: logInModel,
          ));
    } else if (category == "Driver") {
      navigateTo(
          context,
          DriverSignUpView(
            logInModel: logInModel,
          ));
    } else {
      navigateTo(
          context,
          BabySitterSignUpView(
            logInModel: logInModel,
          ));
    }
  }
}

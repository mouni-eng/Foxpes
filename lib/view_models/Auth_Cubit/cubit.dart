import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());
  static AuthCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LogInChangePasswordVisibilityState());
  }
  // method for handling sign in for users

  void signIn({required String email, password}) {
    emit(LogInLoadingState());
    _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      FirebaseFirestore.instance.collection("users").doc(value.user!.uid).update(
          {"token": tokenMessages});
      emit(LogInSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      emit(LogInErrorState(error: error.toString()));
    });
  }

  // method for handling sign up for users

  void signUp({required String email, password, phone, name, gender}) {
    emit(SignUpLoadingState());
    _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      LogInModel logInModel = LogInModel(
        email: email,
        name: name,
        uid: value.user!.uid,
        phone: phone,
        image: gender == "Male" ? "https://image.freepik.com/free-photo/bearded-young-self-confident-male-with-pleasant-appearance-dressed-blue-shirt-looks-directly-isolated-white-wall-handsome-man-freelancer-thinks-about-work-indoor_273609-16089.jpg" : "https://image.freepik.com/free-photo/happy-arab-woman-hijab-portrait-smiling-girl-posing-red-studio-background-young-emotional-woman-human-emotions-facial-expression-concept-front-view_155003-22795.jpg",
        token: tokenMessages,
        gender: gender,
      );
      createUser(logInModel: logInModel);
      emit(SignUpSuccessState());
    }).catchError((error) {
      emit(SignUpErrorState(error: error.toString()));
    });
  }

  void createUser({required LogInModel logInModel}) {
    emit(CreateUserLoadingState());
    _firestore.collection("users").doc(logInModel.uid).set(logInModel.toMap()).then((value) {
      emit(CreateUserSuccessState(logInModel: logInModel));
    }).catchError((error) {
      emit(CreateUserErrorState(error: error.toString()));
    });
  }

  // Teacher registration methods

  void teacherSignIn({required String email, password}) {
    emit(TeacherLogInLoadingState());
    _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
      FirebaseFirestore.instance.collection("teachers").doc(value.user!.uid).update(
          {"token": tokenMessages});
      emit(TeacherLogInSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      emit(TeacherLogInErrorState(error: error.toString()));
    });
  }
  TeacherModel? teacherModel;
  void teacherSignUp({required String email, password, phone, name, field, gender}) {
    emit(TeacherSignUpLoadingState());
    _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      teacherModel = TeacherModel(
        email: email,
        name: name,
        uid: value.user!.uid,
        image: gender == "Male" ? "https://image.freepik.com/free-photo/bearded-young-self-confident-male-with-pleasant-appearance-dressed-blue-shirt-looks-directly-isolated-white-wall-handsome-man-freelancer-thinks-about-work-indoor_273609-16089.jpg" : "https://image.freepik.com/free-photo/happy-arab-woman-hijab-portrait-smiling-girl-posing-red-studio-background-young-emotional-woman-human-emotions-facial-expression-concept-front-view_155003-22795.jpg",
        phone: phone,
        field: field,
        gender: gender,
        status: "Pending",
        token: tokenMessages,
      );
      if(profileImage != null) {
        uploadProfileImage(
          email: email,
          name: name,
          uid: value.user!.uid,
          phone: phone,
          field: field,
        );
        emit(TeacherSignUpSuccessState());
      }else{
        createTeacher();
      }
    }).catchError((error) {
      emit(TeacherSignUpErrorState(error: error.toString()));
    });
  }

  void createTeacher() {
    emit(CreateTeacherLoadingState());
    _firestore.collection("teachers").doc(teacherModel!.uid).set(teacherModel!.toMap()).then((value) {
      emit(CreateTeacherSuccessState(teacherModel: teacherModel));
    }).catchError((error) {
      emit(CreateTeacherErrorState(error: error.toString()));
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

  Future<void> uploadProfileImage({required String email, password, phone, name, field, uid}) async{
    emit(TeacherUploadLoadingState());
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
  }

}
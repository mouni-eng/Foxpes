import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/view_models/Auth_Cubit/states.dart';
import 'package:movies_app/views/auth_views/otp_verfication_view.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/baby_sitter_views/babysitter_signup_view.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/drivers_views/driver_signup_view.dart';
import 'package:movies_app/views/auth_views/parteners_signup_views/teacher_views/teacher_signup_view.dart';
import 'package:movies_app/views/client_views/client_layout.dart';
import 'package:movies_app/views/partner_views/partner_home.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_toast.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthStates());
  static AuthCubit get(context) => BlocProvider.of(context);
  File? idCard;
  File? cardLiscense;
  File? carPlate;
  File? personalImage;
  String? idCardUri;
  String? cardLiscenseUri;
  String? carPlateUri;
  String? personalImageUri;
  List<File>? carImages = [];
  List<String>? carImagesUri = [];
  String suffix = "assets/images/icon-off.svg";
  bool isPassword = false;
  String? gender;
  String? category;
  String? birthDate;
  String? experience;
  String? country;
  String? skills;
  String? faculty;
  String? subject;
  String? duration;
  String? carType;
  String? religion;
  String? status;
  String? degree;
  String? speak;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void chooseGender(String genders) {
    gender = genders;
    emit(SignUpChangecarTypeState());
  }

  void chooseCarType(String carTypes) {
    carType = carTypes;
    emit(SignUpChangeGenderState());
  }

  void choosereligion(String religions) {
    religion = religions;
    emit(SignUpChangereligionState());
  }

  void choosestatus(String statuss) {
    status = statuss;
    emit(SignUpChangestatusState());
  }

  void choosedegree(String degrees) {
    degree = degrees;
    emit(SignUpChangedegreeState());
  }

  void choosespeak(String speaks) {
    speak = speaks;
    emit(SignUpChangespeakState());
  }

  void choosebirthDate(String birthDates) {
    birthDate = birthDates;
    emit(SignUpChangebirthDateState());
  }

  void chooseExperience(String experiences) {
    experience = experiences;
    emit(SignUpChangeExperienceState());
  }

  void chooseCountry(String countries) {
    country = countries;
    emit(SignUpChangeCountryState());
  }

  void chooseskills(String skill) {
    skills = skill;
    emit(SignUpChangeskillsState());
  }

  void choosefaculty(String faculties) {
    faculty = faculties;
    emit(SignUpChangefacultyState());
  }

  void choosesubject(String subjects) {
    subject = subjects;
    emit(SignUpChangesubjectState());
  }

  void chooseduration(String durations) {
    duration = durations;
    emit(SignUpChangedurationState());
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

  LogInModel? userModel;

  void signIn({required String email, password, required context}) {
    emit(LogInLoadingState());
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      _firestore.collection("user").doc(value.user!.uid).get().then((value) {
        userModel = LogInModel.fromJson(value.data()!);
        emit(LogInSuccessState(logInModel: userModel!));
      }).then((value) {
        _firestore
            .collection("user")
            .doc(userModel!.uid)
            .update({"token": tokenMessages}).then((value) {
          CacheHelper.saveData(
            key: 'uid',
            value: userModel!.uid,
          ).then((value) {
            CacheHelper.saveData(
              key: 'categories',
              value: userModel!.category,
            ).then((value) {
              initialHomeScreen(context: context, logInModel: userModel!);
            });
          });
        });
      });
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastState.ERROR);
      emit(LogInErrorState(error: error.toString()));
    });
  }

  // method for handling sign up for users

  void signUp({required LogInModel logInModel, required context}) {
    emit(SignUpLoadingState());
    _auth
        .createUserWithEmailAndPassword(
            email: logInModel.email!, password: logInModel.password!)
        .then((value) {
      LogInModel model = LogInModel(
        email: logInModel.email,
        phone: logInModel.phone,
        firstName: logInModel.firstName,
        lastName: logInModel.lastName,
        uid: value.user!.uid,
        image: personalImageUri == null
            ? "https://firebasestorage.googleapis.com/v0/b/movies-app-fe023.appspot.com/o/users%2Fvuesax-linear-profile-circle.png?alt=media&token=e81580b4-85d6-4fe1-8f5c-0814a260a52b"
            : personalImageUri,
        token: tokenMessages,
        gender: logInModel.gender,
        category: logInModel.category,
        password: logInModel.password,
        price: logInModel.price,
        duration: logInModel.duration,
        aboutYou: logInModel.aboutYou,
        birthDate: logInModel.birthDate,
        country: logInModel.country,
        experience: logInModel.experience,
        careType: logInModel.careType,
        carNumber: logInModel.carNumber,
        idCardImage: logInModel.idCardImage,
        carImages: logInModel.carImages,
        licienceCardImage: logInModel.licienceCardImage,
        carPlateImage: logInModel.carPlateImage,
        skills: logInModel.skills,
        faculty: logInModel.faculty,
        teachIn: logInModel.teachIn,
        religion: logInModel.religion,
        status: logInModel.status,
        degree: logInModel.degree,
        speaks: logInModel.speaks,
      );
      createUser(logInModel: model, context: context);
    }).catchError((error) {
      emit(SignUpErrorState(error: error.toString()));
      showToast(text: error.toString(), state: ToastState.ERROR);
    });
  }

  void createUser({required LogInModel logInModel, required context}) {
    _firestore
        .collection("user")
        .doc(logInModel.uid)
        .set(logInModel.toMap())
        .then((value) {
      _firestore
          .collection("user")
          .doc(logInModel.uid)
          .collection("rating")
          .add({"rating": "0"}).then((value) {
        CacheHelper.saveData(
          key: 'uid',
          value: logInModel.uid,
        ).then((value) {
          CacheHelper.saveData(
            key: 'categories',
            value: logInModel.category,
          ).then((value) {
            initialHomeScreen(context: context, logInModel: logInModel);
          });
        });
      });
      emit(CreateUserSuccessState(logInModel: logInModel));
    }).catchError((error) {
      emit(CreateUserErrorState(error: error.toString()));
    });
  }

  void resetPassword({required String email, required context}) {
    emit(ResetPasswordLoadingState());
    _auth.sendPasswordResetEmail(email: email).then((value) {
      emit(ResetPasswordSuccessState());
      showToast(text: "Email sent successfully", state: ToastState.SUCCESS);
    }).catchError((error) {
      emit(ResetPasswordErrorState());
      showToast(
          text: "Something went wrong please try again later",
          state: ToastState.ERROR);
    });
  }

  nextSignUpScreen({
    required context,
    required String email,
    password,
    phone,
    firstName,
    lastName,
    country,
    gender,
    category,
  }) {
    if (category == "Student") {
      navigateTo(
          context,
          OtpVerficationView(
              logInModel: LogInModel(
            email: email,
            password: password,
            phone: phone,
            firstName: firstName,
            lastName: lastName,
            country: country,
            gender: gender,
            category: category,
          )));
    } else if (category == "Teacher") {
      navigateTo(
          context,
          TeacherSignUpView(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            phone: phone,
            gender: gender,
            category: category,
          ));
    } else if (category == "Driver") {
      navigateTo(
          context,
          DriverSignUpView(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            phone: phone,
            gender: gender,
            category: category,
          ));
    } else {
      navigateTo(
          context,
          BabySitterSignUpView(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            phone: phone,
            gender: gender,
            category: category,
          ));
    }
  }

  initialHomeScreen({
    required context,
    required LogInModel logInModel,
  }) {
    if (logInModel.category == "Student") {
      navigateToAndFinish(context, ClientLayoutView());
    } else {
      navigateToAndFinish(context, PartnerHomeView());
    }
  }

  var picker = ImagePicker();

  chooseImagre({required String key}) async {
    await picker.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        if (key == "idCard") {
          idCard = File(value.path);
          emit(SignUpChangechooseImageState());
        } else if (key == "cardLiscense") {
          cardLiscense = File(value.path);
          emit(SignUpChangechooseImageState());
        } else if (key == "carPlate") {
          carPlate = File(value.path);
          emit(SignUpChangechooseImageState());
        } else if (key == "otherImages") {
          carImages!.add(File(value.path));
          emit(SignUpChangechooseImageState());
        } else {
          personalImage = File(value.path);
          emit(SignUpChangechooseImageState());
        }
      } else {
        showToast(text: "No image selected", state: ToastState.WARNING);
      }
    });
  }

  Future uploadFile() async {
    emit(SignUpGetUriLoadingState());
    for (var img in carImages!) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(img.path).pathSegments.last}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          carImagesUri!.add(value);
        });
      });
    }

    var ref = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(idCard!.path).pathSegments.last}');
    await ref.putFile(idCard!).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        idCardUri = value;
      });
    });

    var refLicense = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(cardLiscense!.path).pathSegments.last}');
    await refLicense.putFile(cardLiscense!).whenComplete(() async {
      await refLicense.getDownloadURL().then((value) {
        cardLiscenseUri = value;
      });
    });

    var refPlate = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(carPlate!.path).pathSegments.last}');
    await refPlate.putFile(carPlate!).whenComplete(() async {
      await refPlate.getDownloadURL().then((value) {
        carPlateUri = value;
      });
    });
    emit(SignUpGetUriSuccesState());
  }

  Future uploadPersonalFile() async {
    emit(SignUpGetUriLoadingState());
    var personalRef = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(personalImage!.path).pathSegments.last}');
    await personalRef.putFile(personalImage!).whenComplete(() async {
      await personalRef.getDownloadURL().then((value) {
        personalImageUri = value;
        emit(SignUpGetUriSuccesState());
      });
    });
  }
}

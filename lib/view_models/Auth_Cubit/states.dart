import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/models/user_model.dart';

class AuthStates {}

class LogInChangePasswordVisibilityState extends AuthStates {}

class LogInLoadingState extends AuthStates {}

class LogInSuccessState extends AuthStates {
  final String uId;
  LogInSuccessState({required this.uId});
}

class LogInErrorState extends AuthStates {
  final String error;
  LogInErrorState({required this.error});
}

class TeacherLogInLoadingState extends AuthStates {}

class TeacherLogInSuccessState extends AuthStates {
  final String uId;
  TeacherLogInSuccessState({required this.uId});
}

class TeacherLogInErrorState extends AuthStates {
  final String error;
  TeacherLogInErrorState({required this.error});
}

class SignUpLoadingState extends AuthStates {}

class SignUpSuccessState extends AuthStates {
  final LogInModel? logInModel;
  SignUpSuccessState({this.logInModel});
}

class SignUpErrorState extends AuthStates {
  final String error;
  SignUpErrorState({required this.error});
}

class TeacherSignUpLoadingState extends AuthStates {}

class TeacherSignUpSuccessState extends AuthStates {
  final TeacherModel? teacherModel;
  TeacherSignUpSuccessState({this.teacherModel});
}

class TeacherSignUpErrorState extends AuthStates {
  final String error;
  TeacherSignUpErrorState({required this.error});
}

class CreateUserLoadingState extends AuthStates {}

class CreateUserSuccessState extends AuthStates {
  final LogInModel? logInModel;
  CreateUserSuccessState({this.logInModel});
}

class CreateUserErrorState extends AuthStates {
  final String error;
  CreateUserErrorState({required this.error});
}

class CreateTeacherLoadingState extends AuthStates {}

class CreateTeacherSuccessState extends AuthStates {
  final TeacherModel? teacherModel;
  CreateTeacherSuccessState({this.teacherModel});
}

class CreateTeacherErrorState extends AuthStates {
  final String error;
  CreateTeacherErrorState({required this.error});
}

class ProfileImagePickedSuccessState extends AuthStates {}
class ProfileImagePickedErrorState extends AuthStates {}
class TeacherUploadLoadingState extends AuthStates {}
class TeacherUploadProfileImageSuccessState extends AuthStates {}
class TeacherUploadProfileImageErrorState extends AuthStates {}


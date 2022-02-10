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

class SignUpLoadingState extends AuthStates {}

class SignUpSuccessState extends AuthStates {
  final LogInModel? logInModel;
  SignUpSuccessState({this.logInModel});
}

class SignUpErrorState extends AuthStates {
  final String error;
  SignUpErrorState({required this.error});
}

class SignUpChangeGenderState extends AuthStates {}

class SignUpChangeCategoryState extends AuthStates {}


class CreateUserLoadingState extends AuthStates {}

class CreateUserSuccessState extends AuthStates {
  final LogInModel? logInModel;
  CreateUserSuccessState({this.logInModel});
}

class CreateUserErrorState extends AuthStates {
  final String error;
  CreateUserErrorState({required this.error});
}

class ProfileImagePickedSuccessState extends AuthStates {}
class ProfileImagePickedErrorState extends AuthStates {}


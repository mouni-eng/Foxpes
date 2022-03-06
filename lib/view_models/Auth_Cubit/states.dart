import 'package:movies_app/models/user_model.dart';

class AuthStates {}

class LogInChangePasswordVisibilityState extends AuthStates {}

class LogInLoadingState extends AuthStates {}

class LogInSuccessState extends AuthStates {
  final LogInModel logInModel;
  LogInSuccessState({required this.logInModel});
}

class LogInErrorState extends AuthStates {
  final String error;
  LogInErrorState({required this.error});
}

class SignUpLoadingState extends AuthStates {}

class SignUpSuccessState extends AuthStates {
  final LogInModel? logInModel;
  SignUpSuccessState({required this.logInModel});
}

class SignUpErrorState extends AuthStates {
  final String error;
  SignUpErrorState({required this.error});
}

class SignUpChangeGenderState extends AuthStates {}

class SignUpChangecarTypeState extends AuthStates {}

class SignUpChangereligionState extends AuthStates {}

class SignUpChangestatusState extends AuthStates {}

class SignUpChangedegreeState extends AuthStates {}

class SignUpChangespeakState extends AuthStates {}

class SignUpChangeCategoryState extends AuthStates {}

class SignUpChangeExperienceState extends AuthStates {}

class SignUpChangeCountryState extends AuthStates {}

class SignUpChangeskillsState extends AuthStates {}

class SignUpChangefacultyState extends AuthStates {}

class SignUpChangesubjectState extends AuthStates {}

class SignUpChangedurationState extends AuthStates {}

class SignUpChangebirthDateState extends AuthStates {}

class SignUpChangechooseImageState extends AuthStates {}

class SignUpGetUriSuccesState extends AuthStates {}

class SignUpGetUriLoadingState extends AuthStates {}


class CreateUserLoadingState extends AuthStates {}

class CreateUserSuccessState extends AuthStates {
  final LogInModel? logInModel;
  CreateUserSuccessState({this.logInModel});
}

class CreateUserErrorState extends AuthStates {
  final String error;
  CreateUserErrorState({required this.error});
}

class ResetPasswordLoadingState extends AuthStates {}

class ResetPasswordSuccessState extends AuthStates {}

class ResetPasswordErrorState extends AuthStates {}


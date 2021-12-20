class ServicesStates {}

class GetTeacherLoadingState extends ServicesStates{}
class GetTeacherSuccessState extends ServicesStates{}
class GetTeacherErrorState extends ServicesStates{
  final String error;
  GetTeacherErrorState({required this.error});
}
class AddServiceLoadingState extends ServicesStates{}
class AddServiceSuccessState extends ServicesStates{}
class AddServiceErrorState extends ServicesStates{
  final String error;
  AddServiceErrorState({required this.error});
}
class GetServiceLoadingState extends ServicesStates{}
class GetServiceSuccessState extends ServicesStates{}
class GetServiceErrorState extends ServicesStates{
  final String error;
  GetServiceErrorState({required this.error});
}

class GetServiceRatingLoadingState extends ServicesStates{}
class GetServiceRatingSuccessState extends ServicesStates{}
class GetServiceRatingErrorState extends ServicesStates{
  final String error;
  GetServiceRatingErrorState({required this.error});
}

class TeacherImagePickedSuccessState extends ServicesStates {}
class TeacherImagePickedErrorState extends ServicesStates {}
class TeacherUpdateLoadingState extends ServicesStates {}
class TeacherUploadLoadingState extends ServicesStates {}
class UrlTeacherProfileImageSuccessState extends ServicesStates {}
class UploadTeacherProfileImageErrorState extends ServicesStates {}
class TeacherUpdateErrorState extends ServicesStates {}

class GetChatDataLoadingState extends ServicesStates{}
class GetChatDataSuccessState extends ServicesStates{}
class GetChatDataErrorState extends ServicesStates{
  final String error;
  GetChatDataErrorState({required this.error});
}

class SendMessageSuccessState extends ServicesStates {}

class SendMessageErrorState extends ServicesStates {}

class GetMessagesLoadingState extends ServicesStates {}
class GetMessagesSuccessState extends ServicesStates {}

class ChangeNotificationState extends ServicesStates {}

class ChooseCountryState extends ServicesStates {}

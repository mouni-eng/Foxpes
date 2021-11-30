class ExploreStates {}

class GetUserLoadingState extends ExploreStates {}
class GetUserSuccessState extends ExploreStates {}
class GetUserErrorState extends ExploreStates {
final String error;
GetUserErrorState({required this.error});
}
class ProfileImagePickedSuccessState extends ExploreStates {}
class ProfileImagePickedErrorState extends ExploreStates {}
class UserUploadLoadingState extends ExploreStates {}
class UserUpdateLoadingState extends ExploreStates {}
class UploadProfileImageErrorState extends ExploreStates {}
class UserUpdateErrorState extends ExploreStates {}

class GetUserChatDataLoadingState extends ExploreStates{}
class GetUserChatDataSuccessState extends ExploreStates{}
class GetUserChatDataErrorState extends ExploreStates{
  final String error;
  GetUserChatDataErrorState({required this.error});
}

class SendUserMessageSuccessState extends ExploreStates {}
class SendUserMessageErrorState extends ExploreStates {}
class GetUserMessagesLoadingState extends ExploreStates {}
class GetUserMessagesSuccessState extends ExploreStates {}

class CreateRoomSuccessState extends ExploreStates {}

class CreateRoomErrorState extends ExploreStates {}

class ChangeUserNotificationState extends ExploreStates {}


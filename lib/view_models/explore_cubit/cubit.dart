import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/models/chatRoom_model.dart';
import 'package:movies_app/models/message_model.dart';
import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/services/network/notfications.dart';
import 'package:movies_app/view_models/explore_cubit/states.dart';
import 'package:movies_app/views/layout_views/details_chat_view.dart';
import 'package:movies_app/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ExploreCubit extends Cubit<ExploreStates> {
  ExploreCubit() : super(ExploreStates());

  static ExploreCubit get(context) => BlocProvider.of(context);


  // method for handling get user data

  LogInModel? userModel;

  void getUserData() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      userModel = LogInModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error: error.toString()));
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

  void uploadProfileImage({
    required String name,
    required String phone,
    required String email,
  }) async{
    emit(UserUploadLoadingState());
    await getProfileImage();
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(
          name: name,
          phone: phone,
          image: value,
          email: email,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String email,
    String? image,
  }) {
    LogInModel model = LogInModel(
      name: name,
      phone: phone,
      email: email,
      image: image ?? userModel!.image,
      uid: userModel!.uid,
    );
    emit(UserUpdateLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateErrorState());
    });
  }

  // method for getting old chats

  List<TeacherModel>? userChatList = [];

  Future<void> getUserChats() async{
    emit(GetUserChatDataLoadingState());
    FirebaseFirestore.instance.collection('chatRooms').where('senderId', isEqualTo: uId).snapshots().listen((event) {
      event.docs.forEach((element) {
        userChatList = [];
        var id = element.data()['receiverId'];
        FirebaseFirestore.instance.collection("teachers").doc(id).get().then((value) {
          userChatList!.add(TeacherModel.fromJson(value.data()!));
        });
      });
      emit(GetUserChatDataSuccessState());
    });
  }

  // method for sending and getting messages

  TeacherModel? teacherModel;
  var itemController = ItemScrollController();

  void sendUserMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: userModel!.uid,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc()
        .set(model.toMap())
        .then((value) {
      emit(SendUserMessageSuccessState());
    }).catchError((error) {
      emit(SendUserMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('teachers')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendUserMessageSuccessState());
    }).catchError((error) {
      emit(SendUserMessageErrorState());
    });
    if(userMessages.length == 0)
    createChatRoom(receiverId: receiverId);
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(receiverId)
        .get().then((value) {
          teacherModel = TeacherModel.fromJson(value.data()!);
          NotificationCenter().sendMessageNotification(token: teacherModel!.token!.toString(), title: teacherModel!.name, name: userModel!.name, image: userModel!.image, uid: userModel!.uid, body: "you have a new message from ${userModel!.name}");
    });
    itemController.jumpTo(
      index: userMessages.length,
      alignment: 0.0,
    );

  }

  void createChatRoom({
    required String receiverId,
  }) {
    FirebaseFirestore.instance.collection('chatRooms').doc().set(
        ChatRoomModel(
          senderId: uId,
          receiverId: receiverId,
          dateTime: DateTime.now().toString(),
        ).toMap()
    ).then((value) {
      emit(CreateRoomSuccessState());
    }).catchError((error) {
      emit(CreateRoomErrorState());
    });
  }

  List<MessageModel> userMessages = [];

  void getUserMessages({
    required String receiverId,
  }) {
    emit(GetUserMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      userMessages = [];

      event.docs.forEach((element) {
        userMessages.add(MessageModel.fromJson(element.data()));
      });

      emit(GetUserMessagesSuccessState());
    });
  }

  bool value = true;

  void changeUserNotification() {
    value = !value;
    emit(ChangeUserNotificationState());
  }

  Future<void> signOut(context) async{
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeData(
      key: 'uId',
    ).then((value)
    {
      CacheHelper.removeData(
          key: 'categorie'
      ).then((value) {
        if (value)
        {
          userModel = null;
          navigateToAndFinish(
            context,
            EducationApp(),
          );
        }
      });
    });
  }

  // section handling notfications

  List<RemoteMessage> messages = [];

  Future<void> notificationHandler(context) async{

    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      FirebaseFirestore.instance.collection("users").doc(userModel!.uid).update({
        "token" : event
      });
    });


    // foreground fcm
    FirebaseMessaging.onMessage.listen((event)
    {
      if(event.data["type"] == "chat") {
        messages.add(event);
      }
    });

    // when click on notification to open app
    FirebaseMessaging.onMessageOpenedApp.listen((event)
    {
      if(event.data["type"] == "chat") {
        navigateTo(context, DetailsChatView(teacherModel: TeacherModel(
          name: event.data["name"],
          image: event.data["image"],
          uid: event.data["uid"],
        )));
      }
    });
  }
}
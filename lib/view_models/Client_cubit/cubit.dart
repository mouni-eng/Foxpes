import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/models/message_model.dart';
import 'package:movies_app/models/notification_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/size_config.dart';
import 'package:movies_app/view_models/App_Cubit/cubit.dart';
import 'package:movies_app/view_models/Client_cubit/states.dart';
import 'package:movies_app/views/client_views/client_home.dart';
import 'package:movies_app/views/client_views/messages_view.dart';
import 'package:movies_app/views/client_views/settings_view.dart';
import 'package:movies_app/views/starting_views/onboarding_view.dart';
import 'package:movies_app/widgets/custom_navigation.dart';
import 'package:movies_app/widgets/custom_toast.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ClientCubit extends Cubit<ClientStates> {
  ClientCubit() : super(ClientStates());
  static ClientCubit get(context) => BlocProvider.of(context);

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  LogInModel? logInModel;
  List<LogInModel>? popularTeachers = [];
  List<dynamic>? popularTeachersRating = [];
  List<LogInModel> chatsList = [];
  List<MessageModel> lastMessagesList = [];
  List<NotificationMessage> notificationList = [];
  Map<String, int> notOpenedMessages = {};
  int carouselIndex = 0;
  bool notificationValue = true;
  File? personalImage;
  String? personalImageUri;

  void getUserData() {
    emit(GetUserDataLoadingState());
    AppCubit().getCacheData();
    _firestore.collection("user").doc(uId).get().then((value) {
      logInModel = LogInModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      Foxpes.navigatorKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => OnBoardingScreen()),
          (route) => false);
      emit(GetUserDataErrorState());
      /*showToast(
          text: "Something went wrong please try again later",
          state: ToastState.ERROR);*/
    }).then((value) {
      getPopularTeacherData();
    });
  }

  void addNotificationList(NotificationMessage message) {
    notificationList.add(message);
  }

  void getPopularTeacherData() {
    popularTeachersRating = [];
    emit(GetPopularTeacherDataLoadingState());
    _firestore
        .collection("user")
        .where("category", isEqualTo: "Teacher")
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        emit(GetPopularTeacherDataSuccessState());
      } else {
        value.docs.forEach((element) {
          element.reference.collection("rating").get().then((value) {
            int ratingSum = int.parse(value.docs.first["rating"]) +
                int.parse(value.docs.last["rating"]);
            print(ratingSum.toString());
            double rating = value.docs.length == 1
                ? ratingSum / 2
                : ratingSum / value.docs.length;
            popularTeachersRating!.add(rating.round());
            popularTeachers!.add(LogInModel.fromJson(element.data()));
            emit(GetPopularTeacherDataSuccessState());
          });
        });
      }
    }).catchError((error) {
      emit(GetPopularTeacherDataErrorState());
      showToast(
          text: "Something went wrong please try again later",
          state: ToastState.ERROR);
    });
  }

  void signOut({required context}) async {
    await FirebaseAuth.instance.signOut();
    CacheHelper.removeData(
      key: 'uId',
    ).then((value) {
      CacheHelper.removeData(key: 'categorie').then((value) {
        if (value) {
          navigateToAndFinish(
            context,
            Foxpes(),
          );
        }
      });
    });
  }

  void changeIndicatorIndex(int index) {
    carouselIndex = index;
    emit(ChangeIndexState());
  }

  void changeNotificationValue(bool value) {
    notificationValue = value;
    if (value) {
      FirebaseMessaging.instance.subscribeToTopic("users");
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic("users");
    }
    emit(ChangeNotificationState());
  }

  List<Widget> screens = [
    ClientHomeView(),
    ClientMessagesView(),
    ClientSettingsView(),
  ];

  int currentIndex = 0;

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(AppBottomNavBarState());
  }

  var picker = ImagePicker();

  chooseImagre({required String key}) async {
    await picker.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        personalImage = File(value.path);
        emit(ChooseUpdateProfileState());
      } else {
        showToast(text: "No image selected", state: ToastState.WARNING);
      }
    }).then((value) {
      if (personalImage != null) {
        updatePersonalFile();
      }
    });
  }

  Future updatePersonalFile() async {
    emit(GetUriUpdateProfileLoadingState());
    var personalRef = FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(personalImage!.path).pathSegments.last}');
    await personalRef.putFile(personalImage!).whenComplete(() async {
      await personalRef.getDownloadURL().then((value) {
        personalImageUri = value;
        emit(GetUriUpdateProfileSuccessState());
      });
    });
  }

  void updateUser({required LogInModel logInModel}) {
    emit(UpdateProfileLoadingState());
    _firestore
        .collection("user")
        .doc(logInModel.uid)
        .update(logInModel.toMap())
        .then((value) {
      emit(UpdateProfileSuccessState());
    }).catchError((error) {
      emit(UpdateProfileErrorState());
    }).then((value) {
      getUserData();
    });
  }

  void getUserChats() {
    emit(GetUserChatsDataLoadingState());
    _firestore
        .collection("user")
        .doc(uId)
        .collection("chats")
        .where("isOpened", isEqualTo: false)
        .orderBy("dateTime")
        .get()
        .then((event) {
      chatsList = [];
      lastMessagesList = [];
      if (event.docs.length == 0) {
        emit(GetUserChatsDataSuccessState());
      } else {
        event.docs.forEach((element) {
          _firestore.collection("user").doc(element.id).get().then((value) {
            chatsList.add(LogInModel.fromJson(value.data()!));
            lastMessagesList.add(MessageModel.fromJson(element.data()));
            emit(GetUserChatsDataSuccessState());
          }).then((value) {
            getUserNotOpenedMessages();
          });
        });
      }
    });
  }

  void getUserNotOpenedMessages() {
    emit(GetUserNotOpenedDataLoadingState());
    _firestore
        .collection("user")
        .doc(uId)
        .collection("chats")
        .orderBy("dateTime")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        notOpenedMessages = {};
        element.reference
            .collection("messages")
            .where("isOpened", isEqualTo: false)
            .where("senderId", isNotEqualTo: uId)
            .get()
            .then((value) {
          notOpenedMessages.addAll({element.id: value.size});
          emit(GetUserNotOpenedDataSuccessState());
        });
      });
    });
  }

  List<MessageModel> userMessages = [];
  var itemController = ItemScrollController();

  void getUserMessages({
    required String receiverId,
  }) {
    emit(GetAllUserMessagesDataLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      userMessages = [];
      if (event.docs.length == 0) {
        emit(GetAllUserMessagesDataSuccessState());
      } else {
        event.docs.forEach((element) {
          userMessages.add(MessageModel.fromJson(element.data()));
          emit(GetAllUserMessagesDataSuccessState());
        });
      }
      if (userMessages.length != 0) {
        itemController.scrollTo(
          index: userMessages.length,
          alignment: 0.0,
          duration: Duration(milliseconds: 1),
        );
      }
    });
  }

  void sendUserMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    required String token,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: uId,
      receiverId: receiverId,
      dateTime: dateTime,
      isOpened: false,
    );

    // set my chats
    FirebaseFirestore.instance
        .collection('user')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .doc()
        .set(model.toMap())
        .then((value) {
      emit(SendUserMessageSuccessState());
    }).catchError((error) {
      emit(SendUserMessageErrorState());
    }).then((value) {
      MessageModel reciverModel = MessageModel(
        text: text,
        senderId: uId,
        senderName: "${logInModel!.firstName} ${logInModel!.lastName}",
        image: logInModel!.image,
        token: token,
        receiverId: receiverId,
        dateTime: dateTime,
        isOpened: false,
      );
      FirebaseFirestore.instance
          .collection('user')
          .doc(receiverId)
          .collection('chats')
          .doc(uId)
          .collection('messages')
          .add(reciverModel.toMap())
          .then((value) {
        emit(SendUserMessageSuccessState());
      }).catchError((error) {
        emit(SendUserMessageErrorState());
      }).then((value) {
        updateMessagesStatus(receiverId: receiverId);
      });
    });

    // set receiver chats
  }

  void updateMessagesStatus({
    required String receiverId,
  }) {
    MessageModel model = MessageModel(
      text: userMessages.last.text,
      senderId: uId,
      receiverId: receiverId,
      dateTime: userMessages.last.dateTime,
      isOpened: false,
    );
    _firestore
        .collection("user")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .set(model.toMap())
        .then((value) {
      MessageModel model = MessageModel(
        text: userMessages.last.text,
        senderId: uId,
        receiverId: receiverId,
        dateTime: userMessages.last.dateTime,
        isOpened: false,
      );
      _firestore
          .collection("user")
          .doc(receiverId)
          .collection("chats")
          .doc(uId)
          .set(model.toMap());
    });
  }

  void updateIsOpenedStatus({required String receiverId}) {
    _firestore
        .collection("user")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .where("senderId", isNotEqualTo: uId)
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        return "";
      } else {
        value.docs.forEach((element) {
          element.reference.update({"isOpened": true});
        });
      }
    }).then((value) {
      getUserChats();
    });
  }

  void searchChatsData({required String name}) {
    if (name != "") {
      chatsList = chatsList
          .where((element) => element.firstName!.contains(name))
          .toList();
      print(chatsList.length);
      emit(GetUserChatsDataSuccessState());
    } else {
      getUserChats();
    }
  }
}

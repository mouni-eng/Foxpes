import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/main.dart';
import 'package:movies_app/models/message_model.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/models/teacher_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/services/network/notfications.dart';
import 'package:movies_app/view_models/Services_cubit/states.dart';
import 'package:movies_app/views/teacher_layout_views/teacher_details_chat_view.dart';
import 'package:movies_app/widgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ServicesCubit extends Cubit<ServicesStates> {
  ServicesCubit() : super(ServicesStates());

  static ServicesCubit get(context) => BlocProvider.of(context);

  // method for handling get teacher data

  TeacherModel? teacherModel;

  void getTeacherData() {
    emit(GetTeacherLoadingState());

    FirebaseFirestore.instance.collection('teachers').doc(uId).get().then((value) {
      teacherModel = TeacherModel.fromJson(value.data()!);
      emit(GetTeacherSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetTeacherErrorState(error: error.toString()));
    });
  }

  // method for uploading new services

  String? nationality = "الكويت";
  String? flagUri = "flags/kw.png";

  void chooseCountry(String flag, country) {
    nationality = country;
    flagUri = flag;
    emit(ChooseCountryState());
  }

  void uploadService(ServicesModel model) {
    emit(AddServiceLoadingState());

    FirebaseFirestore.instance.collection("services").add(model.toMap()).then((value) {
      getService();
      emit(AddServiceSuccessState());
    }).catchError((error) {
      emit(AddServiceErrorState(error: error.toString()));
    });
  }

  // method for getting teacher services

  List<ServicesModel>? teacherServices = [];

  void getService() {
    teacherServices = [];
    emit(GetServiceLoadingState());
    FirebaseFirestore.instance.collection("services").where('uid', isEqualTo: uId).get().then((value) {
      value.docs.forEach((element) {
        teacherServices!.add(ServicesModel.fromJson(element.data()));
      });
      emit(GetServiceSuccessState());
    }).catchError((error) {
      emit(GetServiceErrorState(error: error.toString()));
    });
  }

  List<int> allTeachersRating = [];

  void getServiceRating(dynamic id) {
    allTeachersRating = [];
    int ratingSum = 0;
    double rating = 0;
    emit(GetServiceRatingLoadingState());
    FirebaseFirestore.instance
        .collection('services')
        .doc(id)
        .collection('rating')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        ratingSum += int.parse(element.data()['rating']);
        print(element.data()['rating']);
        rating = ratingSum / value.docs.length;
        allTeachersRating.add(rating.toInt());
        print(allTeachersRating);
        emit(GetServiceRatingSuccessState());
      }
      );
    }).catchError((error) {
      print(error.toString());
      emit(GetServiceRatingErrorState(error: error.toString()));
    });
  }

  // methods handling editing the user profile

  File? profileImage;
  var picker = ImagePicker();
  String? imageUrl;
  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(TeacherImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(TeacherImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String email,
  }) async{
    emit(TeacherUploadLoadingState());
    await getProfileImage();
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        imageUrl = value;
        emit(UrlTeacherProfileImageSuccessState());
      }).catchError((error) {
        emit(UploadTeacherProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadTeacherProfileImageErrorState());
    });
  }

  void updateTeacher({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(TeacherUpdateLoadingState());
    TeacherModel model = TeacherModel(
      name: name,
      phone: phone,
      email: email,
      field: teacherModel!.field,
      image: imageUrl ?? teacherModel!.image,
      status: teacherModel!.status,
      uid: teacherModel!.uid,
    );

    FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherModel!.uid)
        .update(model.toMap())
        .then((value) {
      getTeacherData();
    }).catchError((error) {
      emit(TeacherUpdateErrorState());
    });
  }

  // method for getting old chats

  List<LogInModel>? chatList = [];

  Future<void> getChats() async{
    emit(GetChatDataLoadingState());
    FirebaseFirestore.instance.collection('chatRooms').where('receiverId', isEqualTo: uId).snapshots().listen((event) {
      chatList = [];
      event.docs.forEach((element) {
        var id = element.data()['senderId'];
        FirebaseFirestore.instance.collection("users").doc(id).get().then((value) {
          chatList!.add(LogInModel.fromJson(value.data()!));
        });
      });
      emit(GetChatDataSuccessState());
    });
  }

  // method for sending and getting messages

  void sendMessage({
    required String receiverId,
    required LogInModel user,
    required String dateTime,
    required String text,
  }) async{
    MessageModel model = MessageModel(
      text: text,
      senderId: teacherModel!.uid,
      receiverId: receiverId,
      dateTime: dateTime,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(teacherModel!.uid)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
    NotificationCenter().sendMessageNotification(token: user.token!.toString(), title: user.name, name: teacherModel!.name, image: teacherModel!.image, uid: teacherModel!.uid, body: "you have recieved a message from ${teacherModel!.name}");
    itemController.jumpTo(
      index: messages.length,
      alignment: 0.0,
    );
  }

  List<MessageModel> messages = [];
  var itemController = ItemScrollController();

  void getMessages({
    required String receiverId,
  }) {
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherModel!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }

  // notifications

  bool value = true;

  void changeNotification() {
    value = !value;
    emit(ChangeNotificationState());
  }

  Future<void> teacherSignOut(context) async{
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
          teacherModel = null;
          navigateToAndFinish(
            context,
            EducationApp(),
          );
        }
      });
    });
  }

  // section handling notfications

  List<RemoteMessage> teacherMessages = [];

  Future<void> teacherNotificationHandler(context) async{

    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.onTokenRefresh.listen((event) {
      FirebaseFirestore.instance.collection("teachers").doc(teacherModel!.uid).update({
        "token" : event
      });
    });


    // foreground fcm
    FirebaseMessaging.onMessage.listen((event)
    {
      if(event.data["type"] == "chat") {
        teacherMessages.add(event);
      }
      print(event.data);
    });

    // when click on notification to open app
    FirebaseMessaging.onMessageOpenedApp.listen((event)
    {
      if(event.data["type"] == "chat") {
        navigateTo(context, TeacherDetailsChatView(userModel: LogInModel(
          name: event.data["name"],
          image: event.data["image"],
          uid: event.data["uid"],
        )));
      }
    });
  }

}
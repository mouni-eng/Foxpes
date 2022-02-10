import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/services_model.dart';
import 'package:movies_app/view_models/find_teacher_cubit/states.dart';
import 'package:movies_app/widgets/custom_toast.dart';

class FindTeachersCubit extends Cubit<FindTeachersStates> {
  FindTeachersCubit() : super(FindTeachersStates());

  static FindTeachersCubit get(context) => BlocProvider.of(context);

  // method for handling find teachers data

  List<ServicesModel>? allTeachersServices = [];
  List<dynamic>? allTeachersServicesId = [];
  List<dynamic>? allTeachersRating = [];

  void getAllTeacherData({required String key}) {
    allTeachersServices = [];
    allTeachersServicesId = [];
    emit(GetAllTeacherLoadingState());

    FirebaseFirestore.instance
        .collection('teachers')
        .where('field', isEqualTo: key)
        .firestore
        .collection("services")
        .where('field', isEqualTo: key)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.id);
        allTeachersServices!.add(ServicesModel.fromJson(element.data()));
        allTeachersServicesId!.add(element.id);
      });
      emit(GetAllTeacherSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllTeacherErrorState(error: error.toString()));
    });
  }

  void getRating(dynamic id) {
    allTeachersRating = [];
    int ratingSum = 0;
    double rating = 0;
    emit(GetTeacherRatingLoadingState());
    FirebaseFirestore.instance
    .collection('services')
    .doc(id)
    .collection('rating')
    .get()
    .then((value) {
      value.docs.forEach((element) {
       ratingSum += int.parse(element.data()['rating']);
       print(element.data()['rating']);
       print(ratingSum);
       rating = ratingSum / value.docs.length;
       print(value.docs.length);
       print(rating.toString());
       allTeachersRating!.add(rating.round());
       print(allTeachersRating!);
       emit(GetTeacherRatingSuccessState());
      }
    );
    }).catchError((error) {
      print(error.toString());
      emit(GetTeacherRatingErrorState(error: error.toString()));
    });
  }

  // section handling rating methods

  void updateRating(dynamic id, int response) {
    FirebaseFirestore.instance
        .collection("services")
        .doc(id)
        .collection('rating')
        .doc(uId)
        .set({'rating': response.toString()}).then((value) {
      showToast(
        text: "Done!",
        state: ToastState.SUCCESS,
      );
    }).catchError((error) {
      showToast(
        text: error.toString(),
        state: ToastState.ERROR,
      );
    });
  }
}

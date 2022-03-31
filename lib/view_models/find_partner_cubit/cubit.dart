import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/constants.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/services/local/cache_helper.dart';
import 'package:movies_app/view_models/find_partner_cubit/states.dart';
import 'package:movies_app/widgets/custom_toast.dart';

class FindPartnerCubit extends Cubit<FindPartnerStates> {
  FindPartnerCubit() : super(FindPartnerStates());

  static FindPartnerCubit get(context) => BlocProvider.of(context);

  // method for handling find partners data

  List<LogInModel> allPartnersServices = [];
  List<dynamic> allPartnersRating = [];
  String? subjectFilter;
  String? genderFilter;

  void getAllPartnersData({required String key}) {
    allPartnersServices = [];
    allPartnersRating = [];
    emit(GetAllPartnersLoadingState());
    FirebaseFirestore.instance
        .collection('user')
        .where('category', isEqualTo: key)
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        emit(GetAllPartnersSuccessState());
      }
      value.docs.forEach((element) {
        element.reference.collection("rating").get().then((value) {
          int ratingSum = int.parse(value.docs.first["rating"]) +
              int.parse(value.docs.last["rating"]);
          double rating = value.docs.length == 1
              ? ratingSum / 2
              : ratingSum / value.docs.length;
          allPartnersServices.add(LogInModel.fromJson(element.data()));
          print(allPartnersServices[0].email);
          allPartnersRating.add(rating.round());
          emit(GetAllPartnersSuccessState());
        });
      });
    }).catchError((error) {
      print(error.toString());
      emit(GetAllPartnersErrorState(error: error.toString()));
    });
  }

  void searchPartnersData({required String key, required String name}) {
    if (name != "") {
      allPartnersServices = allPartnersServices
          .where((element) => element.firstName!.contains(name))
          .toList();
      print(allPartnersServices.length);
      emit(GetAllPartnersSuccessState());
    } else {
      getAllPartnersData(key: key);
    }
  }

  void filterSubjectPartnerData({
    String? subject,
  }) {
    subjectFilter = subject;
    CacheHelper.saveData(key: "Subject", value: subject.toString());
    emit(ChangeFilterValueState());
  }

  void filterGenderPartnerData({
    String? gender,
  }) {
    genderFilter = gender;
    CacheHelper.saveData(key: "Gender", value: gender.toString());
    emit(ChangeFilterValueState());
  }

  void getSubjectFilteredData() {
    subjectFilter = CacheHelper.getData(key: "Subject");
    emit(GetAllPartnersLoadingState());
    if (subjectFilter != "null") {
      allPartnersServices = allPartnersServices
          .where((element) => element.teachIn!.contains(subjectFilter!))
          .toList();
      emit(ChangeSubjectFilterValueState());
    } else {
      showToast(text: "Something went wrong!", state: ToastState.ERROR);
    }
  }

  void getGenderFilteredData() {
    genderFilter = CacheHelper.getData(key: "Gender");
    emit(GetAllPartnersLoadingState());
    if (genderFilter != "null") {
      allPartnersServices = allPartnersServices
          .where((element) => element.gender!.contains(genderFilter!))
          .toList();
      emit(ChangeGenderFilterValueState());
    } else {
      showToast(text: "Something went wrong!", state: ToastState.ERROR);
    }
  }
  // section handling rating methods

  void updateRating(dynamic id, int response) {
    FirebaseFirestore.instance
        .collection("user")
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

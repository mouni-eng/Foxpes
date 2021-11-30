class FindTeachersStates {}

class GetAllTeacherLoadingState extends FindTeachersStates{}

class GetAllTeacherSuccessState extends FindTeachersStates{}

class GetAllTeacherErrorState extends FindTeachersStates{
  final String error;
  GetAllTeacherErrorState({required this.error});
}

class GetTeacherRatingLoadingState extends FindTeachersStates{}

class GetTeacherRatingSuccessState extends FindTeachersStates{}

class GetTeacherRatingErrorState extends FindTeachersStates{
  final String error;
  GetTeacherRatingErrorState({required this.error});
}
class FindPartnerStates {}

class GetAllPartnersLoadingState extends FindPartnerStates{}

class GetAllPartnersSuccessState extends FindPartnerStates{}

class GetAllPartnersErrorState extends FindPartnerStates{
  final String error;
  GetAllPartnersErrorState({required this.error});
}

class ChangeFilterValueState extends FindPartnerStates{}

class ChangeSubjectFilterValueState extends FindPartnerStates{}

class ChangeGenderFilterValueState extends FindPartnerStates{}
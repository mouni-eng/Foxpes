class CountryModel {
    String? name;

  /// the flag of the country
   String? flagUri;

  /// the country code (IT,AF..)
   String? code;

  /// the dial code (+39,+93..)
   String? dialCode;

  CountryModel({
    this.name,
    this.flagUri,
    this.code,
    this.dialCode,
  });

    CountryModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    flagUri = json['flags/${json['code'].toLowerCase()}.png'];
    code = json['code'];
    dialCode = json['dial_code'];
  }

}
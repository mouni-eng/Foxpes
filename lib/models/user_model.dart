class LogInModel {
  String? email, phone, name, uid, image, token, gender;

  LogInModel({
    this.phone,
    this.email,
    this.name,
    this.uid,
    this.image,
    this.token,
    this.gender,
  });

  LogInModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    token = json['token'];
    gender = json['gender'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'email' : email,
      'phone' : phone,
      'uid' : uid,
      'image' : image,
      'token' : token,
      'gender' : gender,
    };
  }
}
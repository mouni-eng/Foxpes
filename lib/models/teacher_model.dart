class TeacherModel {
  String? email, phone, name, uid, image, field, status, token, gender;

  TeacherModel({
    this.phone,
    this.email,
    this.name,
    this.uid,
    this.image,
    this.field,
    this.status,
    this.token,
    this.gender,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    field = json['field'];
    status = json['status'];
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
      'field' : field,
      'status' : status,
      'token' : token,
      'gender' : gender,
    };
  }
}
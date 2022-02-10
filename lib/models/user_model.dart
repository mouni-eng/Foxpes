class LogInModel {
  String? email, phone, firstName, lastName, uid, image, token, gender, category, password, price, duration, aboutYou, birthDate, country, experience, careType, carNumber, idCardImage, licienceCardImage, carPlateImage, carImages, skills, faculty, teachIn, religion, status, degree, speaks;

  LogInModel({
    this.phone,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.uid,
    this.image,
    this.token,
    this.gender,
    this.category,
    this.aboutYou,
    this.birthDate,
    this.carImages,
    this.carNumber,
    this.carPlateImage,
    this.careType,
    this.country,
    this.degree,
    this.duration,
    this.experience,
    this.faculty,
    this.idCardImage,
    this.licienceCardImage,
    this.price,
    this.religion,
    this.skills,
    this.speaks,
    this.status,
    this.teachIn,
  });

  LogInModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    password = json['password'];
    phone = json['phone'];
    email = json['email'];
    aboutYou = json['aboutYou'];
    birthDate = json['birthDate'];
    carImages = json['carImages'];
    carNumber = json['carNumber'];
    carPlateImage = json['carPlateImage'];
    careType = json['careType'];
    country = json['country'];
    degree = json['degree'];
    duration = json['duration'];
    experience = json['experience'];
    faculty = json['faculty'];
    idCardImage = json['idCardImage'];
    licienceCardImage = json['licienceCardImage'];
    price = json['price'];
    religion = json['religion'];
    skills = json['skills'];
    speaks = json['speaks'];
    status = json['status'];
    teachIn = json['teachIn'];
    uid = json['uid'];
    image = json['image'];
    token = json['token'];
    gender = json['gender'];
    category = json['category'];
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName' : firstName,
      'lastName' : lastName,
      'password' : password,
      'email' : email,
      'phone' : phone,
      'uid' : uid,
      'aboutYou' : aboutYou,
      'birthDate' : birthDate,
      'carImages' : carImages,
      'carNumber' : carNumber,
      'carPlateImage' : carPlateImage,
      'careType' : careType,
      'country' : country,
      'degree' : degree,
      'duration' : duration,
      'experience' : experience,
      'faculty' : faculty,
      'idCardImage' : idCardImage,
      'licienceCardImage' : licienceCardImage,
      'price' : price,
      'religion' : religion,
      'skills' : skills,
      'speaks' : speaks,
      'status' : status,
      'teachIn' : teachIn,
      'image' : image,
      'token' : token,
      'gender' : gender,
      'category' : category,
    };
  }
}
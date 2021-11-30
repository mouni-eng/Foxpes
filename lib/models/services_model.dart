class ServicesModel {

  String? nationality, aboutMe, education, experience, name, uid, image, age, hourRate, field, rating, dateTime;
  int? rank;

  ServicesModel({
    this.nationality,
    this.aboutMe,
    this.name,
    this.uid,
    this.image,
    this.education,
    this.experience,
    this.age,
    this.hourRate,
    this.rank,
    this.field,
    this.rating,
    this.dateTime,
  });

  ServicesModel.fromJson(Map<String, dynamic> json) {
    nationality = json['nationality'];
    aboutMe = json['aboutMe'];
    name = json['name'];
    uid = json['uid'];
    image = json['image'];
    education = json['education'];
    experience = json['experience'];
    age = json['age'];
    hourRate = json['hourRate'];
    rank = json['rank'];
    field = json['field'];
    rating = json['rating'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'nationality' : nationality,
      'aboutMe' : aboutMe,
      'uid' : uid,
      'image' : image,
      'education' : education,
      'experience' : experience,
      'age' : age,
      'hourRate' : hourRate,
      'rank' : rank,
      'field' : field,
      'rating' : rating,
      'dateTime' : dateTime,
    };
  }

}
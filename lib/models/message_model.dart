class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? token;
  String? senderName;
  String? image;
  String? text;
  bool? isOpened;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.senderName,
    this.token,
    this.image,
    this.isOpened,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    senderName = json['senderName'];
    token = json['token'];
    image = json['image'];
    isOpened = json['isOpened'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'senderName': senderName,
      'token': token,
      'image': image,
      'isOpened': isOpened,
    };
  }
}

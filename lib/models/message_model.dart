class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  bool? isOpened;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.isOpened,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    isOpened = json['isOpened'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'isOpened': isOpened,
    };
  }
}

class ChatRoomModel {
  String? senderId;
  String? receiverId;
  String? dateTime;

  ChatRoomModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
  });

  ChatRoomModel.fromJson(Map<String, dynamic> json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
    };
  }
}
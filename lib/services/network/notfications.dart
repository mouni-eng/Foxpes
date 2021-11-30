import 'package:http/http.dart' as http;

import 'dart:convert';

class NotificationCenter {

  static const _fcmUrl = "https://fcm.googleapis.com/fcm/send";
  static const _Key = "key=AAAASBdGCYo:APA91bFncqR4cfEKKQ7tgAJqcn1B3W5ZeXeKGJH_LG31Q2eSP-LkPMu44VZeuo_EbfFzap_HHDQp1NfdCnCEwiT5AWFPTncy33VqNjrOnNhKIec3fleNRH-d_k6_0RUDLikJIPhc5n-i";

  Map<String, String> headers = {
    'Authorization' : _Key,
    'Content-Type' : 'application/json'
  };


  Future<String> sendMessageNotification({
  required String token, title, body,
}) async{
    var messageBody = jsonEncode({
      "to": token,
      "notification": {
        "title": title,
        "body": body,
        "mutable_content": true,
        "sound": "Tri-tone"
      },

      "data": {
        "url": body,
        "dl": "<deeplink action on tap of notification>"
      }
    });
    http.Response response = await http.post(Uri.parse(_fcmUrl), headers: headers, body: messageBody);
    return response.body;
  }


}
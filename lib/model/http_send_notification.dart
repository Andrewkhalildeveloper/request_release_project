import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:request_to_release_project/model/api_const.dart';

class FirebaseHttpRequest {
  static Future<void> sendNotifications(String deviceToken) async {
    try {
      var response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${ApiConst.serverToken}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'to': deviceToken,
            'data': <String, dynamic>{
              'body': 'Test Notification !!!',
              'title': 'Test Title !!!'
            },
          },
        ),
      );
      if (response.statusCode == 200) {
        print('notification sent successfully');
        print(response.body);
        print(response.request);
        print(response.headers);
      } else {
        print(response.statusCode);
        print(response.request);
        print(response.headers);
        // print(ApiConst.serverToken);
        // print(ApiConst.deviceToken);
        print('failed to send notification');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

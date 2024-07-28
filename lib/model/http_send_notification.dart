import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:request_to_release_project/model/api_const.dart';

class FirebaseHttpRequest {
  static Future<void> sendNotifications(String deviceToken) async {
    try {
      var response = await http.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/request-project-357d5/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': ApiConst.serverToken,
        },
        body: jsonEncode({
          "message": {
            'token': deviceToken,
            'notification': {
              'body': 'Test Notification !!!',
              'title': 'Test Title !!!'
            },
          }
        }),
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

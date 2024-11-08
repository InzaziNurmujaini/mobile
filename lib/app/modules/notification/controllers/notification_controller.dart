import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationController extends GetxController {
  final String serverToken = 'AIzaSyAqzO3JC7m67U2_Sv0Ehlel1DVb2V0qbEY';

  Future<void> sendTestNotification(String deviceToken) async {
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: json.encode({
          'to': deviceToken,
          'notification': {
            'title': 'Test Notification',
            'body': 'This is a test notification',
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }
}

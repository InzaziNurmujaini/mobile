import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  final NotificationController_controller = Get.put(NotificationController());

       NotificationPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifikasi')),
      body: Center(child: Text('Notifikasi akan muncul di sini!')),
    );
  }
}
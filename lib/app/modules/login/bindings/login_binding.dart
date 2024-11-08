// lib/app/modules/login/bindings/login_binding.dart

import 'package:get/get.dart';
import '../../notification/controllers/notification_controller.dart';
import '../controllers/login_controller.dart'; // Pastikan path ini sesuai

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
    Get.put(LoginController()); // Ganti dengan controller yang sesuai jika ada
  }
}
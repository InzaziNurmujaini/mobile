import 'package:codelab3/depedency_injection.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart'; // Pastikan untuk mengimpor Firebase Core
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_app_check/firebase_app_check.dart';
import 'app/modules/notification/controllers/notification_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Menambahkan App Check Provider
  //await FirebaseAppCheck.instance.activate(
    //webRecaptchaSiteKey: 'your_site_key', // Ganti dengan site key Anda
    //androidProvider: AndroidProvider.playIntegrity,
  //);
  DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(NotificationController()); // Inisialisasi NotificationController
  await FirebaseAppCheck.instance.activate();
  runApp(MyApp());
 
}
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Your App Title",
      initialRoute: Routes.GETSTARTED, // Atur rute awal
      getPages: AppPages.routes, // Rute aplikasi
      debugShowCheckedModeBanner: false,
    );

  }
  
}

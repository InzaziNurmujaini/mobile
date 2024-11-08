import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  // Login function with token retrieval
  Future<void> loginAndGetToken(String email, String password) async {
    try {
      isLoading.value = true;

      // Login with Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get device token after login
      await getToken();

      // Redirect to product page if login is successful
      Get.offAllNamed('/product');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login failed');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to get FCM token
  Future<void> getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('Device Token: $token');
    // Optionally, you can save this token to your database if needed
  }
}

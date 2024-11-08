import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = false.obs;

  Future<void> signUp(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Handle successful sign-up
      print('User signed up: ${userCredential.user?.email}');
    } catch (e) {
      // Handle error
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

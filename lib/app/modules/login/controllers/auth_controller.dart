import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // Jika login berhasil, arahkan ke halaman produk
      Get.offAllNamed('/product'); // Ganti '/product' dengan route halaman produk Anda
    } catch (e) {
      // Tangani error
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

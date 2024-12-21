import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    _initSpeech(); // Mengambil produk dari Firestore
  }

  // Instansiasi SpeechToText untuk menangani pengenalan suara
  final SpeechToText _speech = SpeechToText();
  // Variabel observable untuk melacak status aplikasi
  var isListening =
      false.obs; // Menunjukkan apakah aplikasi sedang mendengarkan suara
  var text = "".obs; // Menyimpan teks yang dihasilkan dari pengenalan suara

  // Menginisialisasi fungsi pengenalan suara
  void _initSpeech() async {
    try {
      await _speech.initialize();
    } catch (e) {
      print(e);
    }
  }

  // Memeriksa dan meminta izin mikrofon
  Future<void> checkMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      // Jika izin belum diberikan, minta izin kepada pengguna
      await Permission.microphone.request();
    }
  }

  // Memulai mendengarkan suara dan memperbarui variabel teks dengan kata-kata yang dikenali
  void startListening() async {
    await checkMicrophonePermission();
    if (await Permission.microphone.isGranted) {
      isListening.value = true;
      await _speech.listen(onResult: (result) {
        // Memperbarui kata-kata yang dikenali ke dalam variabel teks
        text.value = result.recognizedWords;
      });
    } else {
      print("Izin mikrofon ditolak.");
    }
  }

  // Menghentikan proses pengenalan suara
  void stopListening() async {
    isListening.value = false;
    await _speech.stop();
  }

  Future<void> fetchProducts() async {
    // Untuk testing, kita bisa menambahkan data manual jika Firestore tidak tersedia
    products.value = [
      ProductModel(
        id: '1',
        name: 'DryBag 15L',
        price: 7000,
        description: 'Tas tahan air 15L, cocok untuk camping.',
        imagePath: 'assets/product.png',
      ),
      ProductModel(
        id: '2',
        name: 'Tenda Camping',
        price: 150000,
        description: 'Tenda ringan untuk 2 orang.',
        imagePath: 'assets/product.png',
      ),
      ProductModel(
        id: '3',
        name: 'Kompor Portable',
        price: 50000,
        description: 'Kompor kecil, mudah dibawa.',
        imagePath: 'assets/product.png',
      ),
      ProductModel(
        id: '4',
        name: 'Alat Masak Set',
        price: 200000,
        description: 'Set alat masak lengkap untuk camping.',
        imagePath: 'assets/product.png',
      ),
    ];

    // Jika Anda ingin mengambil data dari Firestore, gunakan kode berikut
    /*
    final snapshot = await firestore.collection('products').get();
    products.value = snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data(), doc.id);
    }).toList();
    */
  }

  /// Menambahkan produk ke keranjang dan menyimpannya di Firestore
  void addToCart(ProductModel product) async {
  try {
    // Tambahkan produk ke koleksi "carts"
    final docRef = await firestore.collection('carts').add(product.toJson());
    product.cartId = docRef.id; // Simpan Firestore document ID
    cartItems.add(product);

    Get.snackbar(
      "Added to Cart",
      "${product.name} has been added to your cart!",
      snackPosition: SnackPosition.BOTTOM,
    );
  } catch (e) {
    Get.snackbar(
      "Error",
      "Failed to add product to cart: $e",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}


  /// Menghapus produk dari keranjang dan Firestore
  void removeFromCart(ProductModel product) async {
    try {
      // Jika produk memiliki cartId, hapus dari Firestore
      if (product.cartId != null) {
        await firestore.collection('carts').doc(product.cartId).delete();
      }

      // Hapus produk dari local cartItems
      cartItems.remove(product);

      // Memberikan notifikasi sukses
      Get.snackbar(
        "Removed from Cart",
        "${product.name} has been removed from your cart!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Menangani kesalahan
      Get.snackbar(
        "Error",
        "Failed to remove ${product.name} from your cart.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Menambahkan produk baru ke Firestore (opsional)
  Future<void> addProduct(ProductModel product) async {
    try {
      await firestore.collection('products').add(product.toJson());
      fetchProducts(); // Refresh data produk
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add product: ${product.name}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Memperbarui produk di Firestore (opsional)
  Future<void> updateProduct(ProductModel product) async {
    try {
      await firestore.collection('products').doc(product.id).update(product.toJson());
      fetchProducts(); // Refresh data produk
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update product: ${product.name}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Menghapus produk dari Firestore (opsional)
  Future<void> deleteProduct(String id) async {
    try {
      await firestore.collection('products').doc(id).delete();
      fetchProducts(); // Refresh data produk
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete product.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
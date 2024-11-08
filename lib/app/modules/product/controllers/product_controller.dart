import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final products = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // Mengambil produk dari Firestore
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

  void addToCart(ProductModel product) async {
    final docRef = await firestore.collection('carts').add(product.toJson());
    product.cartId = docRef.id; // Simpan ID dokumen ke cartId
    cartItems.add(product); 

    Get.snackbar(
      "Added to Cart",
      "${product.name} has been added to your cart!",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

 void removeFromCart(ProductModel product) async {
  if (product.cartId != null) {
    await firestore.collection('carts').doc(product.cartId).delete(); // Hapus dari Firestore
  }
  cartItems.remove(product); // Hapus dari local cartItems
  Get.snackbar(
    "Removed from Cart",
    "${product.name} has been removed from your cart!",
    snackPosition: SnackPosition.BOTTOM,
  );
}


  Future<void> addProduct(ProductModel product) async {
    await firestore.collection('products').add(product.toJson());
    fetchProducts();
  }

  Future<void> updateProduct(ProductModel product) async {
    await firestore.collection('products').doc(product.id).update(product.toJson());
    fetchProducts();
  }

  Future<void> deleteProduct(String id) async {
    await firestore.collection('products').doc(id).delete();
    fetchProducts();
  }
}

class ProductModel {
  final String id; // ID produk, unik
  final String name; // Nama produk
  final int price; // Harga produk
  final String description; // Deskripsi produk
  final String imagePath; // Path ke gambar produk
  String? cartId; // ID produk di cart (Firestore document ID), nullable

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.cartId,
  });

  /// Konversi objek ke format JSON untuk Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
    };
  }

  /// Konversi dari Firestore JSON ke objek ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json, String? docId) {
    return ProductModel(
      id: json['id'] ?? '', // Default ke string kosong jika null
      name: json['name'] ?? 'Unknown', // Default ke 'Unknown' jika null
      price: json['price'] ?? 0, // Default ke 0 jika null
      description: json['description'] ?? 'No description', // Default deskripsi
      imagePath: json['imagePath'] ?? 'assets/default.png', // Default image path
      cartId: docId, // Simpan Firestore document ID jika ada
    );
  }
}

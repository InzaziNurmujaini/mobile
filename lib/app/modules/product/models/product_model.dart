class ProductModel {
  final String id;
  final String name;
  final int price;
  final String description;
  final String imagePath;
  String? cartId; // Tambahkan properti ini

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.cartId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
    };
  }

  // Tambahkan metode fromJson untuk inisialisasi dari Firestore
  static ProductModel fromJson(Map<String, dynamic> json, String docId) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imagePath: json['imagePath'],
      cartId: docId, // Simpan Firestore document ID sebagai cartId
    );
  }
}

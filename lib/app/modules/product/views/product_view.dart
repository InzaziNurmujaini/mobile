import 'package:codelab3/app/modules/cart/views/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../models/product_model.dart';
//import 'cart_page.dart'; // Import CartPage

void main() {
  runApp(ProductView());
}

class ProductView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

 ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(productController: productController),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ProductController productController;

  const HomeScreen({super.key, required this.productController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Delivery address",
                style: TextStyle(color: Colors.black, fontSize: 14)),
            Text("Salatiga City, Central Java",
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Get.to(CartView()); // Navigate to cart page
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Row(
              children: [
                // Search Bar
                Expanded(
                  child: Obx(
                    () => TextField(
                      controller: TextEditingController(
                        text: productController.text.value,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search here ...",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) =>
                          productController.text.value = value,
                    ),
                  ),
                ),

                SizedBox(width: 10), // Space between search bar and button

                // Mic Button
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (productController.isListening.value) {
                        productController.stopListening();
                      } else {
                        productController.startListening();
                      }
                    },
                    child: Icon(Icons.mic),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Category Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryItem(icon: Icons.backpack, label: "Baju camping"),
                CategoryItem(icon: Icons.kitchen, label: "Alat masak"),
                CategoryItem(icon: Icons.outdoor_grill, label: "Tenda"),
                CategoryItem(icon: Icons.all_inbox, label: "Daftar paket"),
              ],
            ),
            SizedBox(height: 20),
            // Recent Products
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Recent product",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.filter_list, color: Colors.white),
                  label: Text(
                    "Filters",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Product Grid
            Expanded(
              child: Obx(() {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: productController.products.length,
                  itemBuilder: (context, index) {
                    final product = productController.products[index];
                    return ProductCard(product: product);
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Account"),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.find<ProductController>();

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(product.imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text("Rp. ${product.price} /24 Jam",
                    style: TextStyle(fontSize: 14, color: Colors.orange)),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    productController.addToCart(
                        product); // Call the controller to add to cart
                    Get.to(CartView()); // Navigate to CartPage
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                  ),
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

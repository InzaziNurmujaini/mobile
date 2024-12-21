import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../product/controllers/product_controller.dart';
//import '../controllers/product_controller.dart';
//import '../models/product_model.dart';

class CartView extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

   CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body:Obx(() {
  print("Cart Items: ${productController.cartItems}");
  if (productController.cartItems.isEmpty) {
    return Center(child: Text('Your cart is empty'));
  } else {
    return ListView.builder(
      itemCount: productController.cartItems.length,
      itemBuilder: (context, index) {
        final product = productController.cartItems[index];
        return ListTile(
          leading: Image.asset(product.imagePath),
          title: Text(product.name),
          subtitle: Text('Rp. ${product.price}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              productController.removeFromCart(product);
            },
          ),
        );
      },
    );
  }
}),

    );
  }
}


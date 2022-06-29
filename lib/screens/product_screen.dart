import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_tutorial/provider/product_provider.dart';
import 'package:google_maps_flutter_tutorial/screens/cart_screen.dart';
import 'package:google_maps_flutter_tutorial/screens/my_product.dart' as homeProduct;
import 'package:provider/provider.dart';

class ProductScreenTab extends StatefulWidget {
  @override
  State<ProductScreenTab> createState() => _ProductScreenTabState();
}

class _ProductScreenTabState extends State<ProductScreenTab> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product"), centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return CartScreen();}));
            },
            icon: const Icon(Icons.shopping_bag)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: productProvider.loading
            ? Container(
              height: Get.height * 0.9,
              child: const Center(
                child: CircularProgressIndicator()
              ),
            )
            : Wrap(
              children: productProvider.products.products.map((product) =>
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
                child: homeProduct.MyProduct(product: product),
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}
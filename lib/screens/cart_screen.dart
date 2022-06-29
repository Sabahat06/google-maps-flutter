import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_tutorial/modal/product.dart';
import 'package:google_maps_flutter_tutorial/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"), centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              productProvider.removeAllProduct();
            },
            icon: const Icon(Icons.delete)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: productProvider.cartProduct.length == 0
          ? Container(height: Get.height, width: Get.width, child: const Center(child: Text('You have no item in cart', style: TextStyle(fontSize: 18),),))
          : Wrap(
          children: productProvider.cartProduct.map((product) =>
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
              child: MyProduct(product: product),
            ),
          ).toList(),
        ),
      ),
    );
  }
}

class MyProduct extends StatelessWidget {
  Product product;
  bool outOfStock= false;
  RxInt cartIndex = 1.obs;


  MyProduct({@required this.product});
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    outOfStock = product.status.toString() == "0" ? true : false;
    return Stack(
      children: [
        Container(
          constraints: const BoxConstraints(
              minWidth: 400,
              minHeight: 100,
              maxWidth: 400,
              maxHeight: 350
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  child: Image.network(product.photo),
                ),
                const SizedBox(height: 3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${product.title}  ", style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    Text("${utf8.decode(product.urduTitle.codeUnits)}", style: const TextStyle(fontSize: 16),),
                  ],
                ),
                const SizedBox(height: 3,),
                Text("(${product.unitName})", style: const TextStyle(fontSize: 16,color: Colors.black54),),
                const SizedBox(height: 3,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    product.discountedPrice == null
                        ? Text("${double.parse(product.salePrice).toStringAsFixed(0)}", style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)
                        : Text("${double.parse(product.discountedPrice).toStringAsFixed(0)}", style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    product.discountedPrice == null
                        ? Container()
                        : const Text(" - ", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                    product.discountedPrice == null
                        ? Container()
                        : Text("${product.salePrice}", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black54,decoration: TextDecoration.lineThrough),),
                  ],
                ),
                const SizedBox(height: 3,),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: product.discount =="0"? Container(): Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: Text("Discount ${product.discount}%")),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
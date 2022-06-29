import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_tutorial/modal/product.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static Uri _uri = Uri.parse("https://imrans9.sg-host.com/app/app.php");

  static Future<ProductsModal> getProducts(int page_no) async {
    try {
      var response = await http.post(
        _uri,
        body: {
          'all_products': '1',
          'page_no': page_no.toString(),
        },
      );
      if (response.statusCode == 200) {
        return ProductsModal.fromJson(jsonDecode(response.body));
      } else
        return null;
    }
    catch (e) {
      print(e);
      return null;
    }
  }

}
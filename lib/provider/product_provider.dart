import 'package:flutter/material.dart';
import 'package:google_maps_flutter_tutorial/modal/product.dart';
import 'package:google_maps_flutter_tutorial/services/http_service.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  ProductsModal _productsModal = ProductsModal();
  List<Product> _product = <Product>[];

  ProductProvider() {
    getData();
  }

  List<Product> get cartProduct => _product;
  setCartData(Product product) {
    _product.add(product);
    notifyListeners();
  }

  ProductsModal get products => _productsModal;
  setProductModel(ProductsModal productModal) {
    _productsModal = productModal;
    notifyListeners();
  }

  bool get loading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void addProduct(Product product) {
    int value = _product.indexWhere((element) => element.id== product.id);
    if(value == -1) {
      _product.add(product);
    }
    notifyListeners();
  }

  void removeAllProduct() {
    _product.clear();
    notifyListeners();
  }

  getData() async {
    setLoading(true);
    _productsModal = await HttpService.getProducts(1);
    setProductModel(_productsModal);
    setLoading(false);
  }
}
import 'package:get/get.dart';

class ProductsModal {

  RxList<Product> products = <Product>[].obs;
  int totalPages = 0;

  ProductsModal({this.products, this.totalPages});

  ProductsModal.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products= <Product>[].obs;
      json['products'].forEach((v) {
        products.add(new Product.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    return data;
  }
}

class Product {
  String id;
  String title;
  String urduTitle;
  String shortDetails;
  String longDetails;
  String salePrice;
  String discount;
  String photo;
  String categoryId;
  String subCategoryId;
  String status;
  String userId;
  String unitName;
  String categoryTitle;
  String subCategoryTitle;
  String statusTitle;
  String reviews;
  String rating;
  String discountedPrice;
  RxInt quantity = 0.obs;
  Product(
      {this.id,
        this.title,
        this.urduTitle,
        this.shortDetails,
        this.longDetails,
        this.salePrice,
        this.discount,
        this.photo,
        this.categoryId,
        this.subCategoryId,
        this.status,
        this.userId,
        this.unitName,
        this.categoryTitle,
        this.subCategoryTitle,
        this.statusTitle,
        this.reviews,
        this.rating,
        this.discountedPrice,
        this.quantity
      });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    urduTitle = json['urdu_title'];
    shortDetails = json['short_details'];
    longDetails = json['long_details'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    photo = json['photo'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    status = json['status'];
    userId = json['user_id'];
    unitName = json['unit_name'];
    categoryTitle = json['category_title'];
    subCategoryTitle = json['sub_category_title'];
    statusTitle = json['status_title'];
    reviews = json['reviews'];
    rating = json['rating'];
    discountedPrice = json['discounted_price'];
    quantity.value = json['quantity']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['urdu_title'] = this.urduTitle;
    data['short_details'] = this.shortDetails;
    data['long_details'] = this.longDetails;
    data['sale_price'] = this.salePrice;
    data['discount'] = this.discount;
    data['photo'] = this.photo;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['unit_name'] = this.unitName;
    data['category_title'] = this.categoryTitle;
    data['sub_category_title'] = this.subCategoryTitle;
    data['status_title'] = this.statusTitle;
    data['reviews'] = this.reviews;
    data['rating'] = this.rating;
    data['discounted_price'] = this.discountedPrice;
    data['quantity'] = this.quantity.value;
    return data;
  }
}

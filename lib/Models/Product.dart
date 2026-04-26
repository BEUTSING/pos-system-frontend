import 'package:pos_front/Models/Supplier.dart';

import 'category.dart';

class Product {
  final int id;
  final String productname;
  final Category category;
  final double purchaseprice;
  final double saleprice;
  final int quantity;
  final int minimumstock;
final Supplier? supplier;

  Product({
    required this.id,
    required this.productname,
    required this.category,
    required this.purchaseprice,
    required this.saleprice,
    required this.quantity,
    required this.minimumstock,
    this.supplier,
  });

  // EN: Convert JSON to Product object
  // FR: Convertir JSON en objet Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],

      productname: json['productname'],

      // EN: Convert category JSON to object
      category: Category.fromJson(json['category']),
       supplier: json['supplier'] != null
          ? Supplier.fromJson(json['supplier'])
          : null,
      purchaseprice: double.parse(json['purchaseprice'].toString()),
      saleprice: double.parse(json['saleprice'].toString()),

      quantity: json['quantity'],
      minimumstock: json['minimumstock'],

    );
  }

  // EN: Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'productname': productname,
      'category': category.id,      
      'supplier': supplier?.id,
      'purchaseprice': purchaseprice,
      'saleprice': saleprice,
      'quantity': quantity,
      'minimumstock': minimumstock,

      // send supplier id or null
    };
  }
}
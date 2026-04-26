import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Product.dart';

class Productservice {
  final String apiUrl = "http://localhost:8000/api/products";

  //get all products
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  //create a new product
  Future<Product> createProduct(Product product) async {
    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson())
        );
        if (response.statusCode == 201) {
          return Product.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to create product');
        }
  }

  // update a product
  Future<Product> updateProduct(int id, Product product) async {
    final response = await http.put(Uri.parse('$apiUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson())
        );
        if (response.statusCode == 200) {
          return Product.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Failed to update product');
        }
  }

  // delete a product
  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));
    if (response.statusCode != 204 && response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}

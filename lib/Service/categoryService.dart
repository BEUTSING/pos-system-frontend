import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/category.dart';

class Categoryservice {
  final String apiUrl = "http://localhost:8000/api/categories";

  //get all categories
  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

//create a new category
Future<Category> createCategory(String name, String description) async {
  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name, 'description': description}),
  );

  if (response.statusCode == 201) {
    return Category.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create category');
  }
}

//update a category
Future<Category> updateCategory(int id, String name, String description) async {
  final response = await http.put(
    Uri.parse('$apiUrl/$id'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name, 'description': description}),
  );

  if (response.statusCode == 200) {
    return Category.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update category');
  }
}

//delete a category
Future<void> deleteCategory(int id) async {
  final response=await http.delete(Uri.parse('$apiUrl/$id'));
  if (response.statusCode != 204 && response.statusCode != 200) {
    throw Exception('Failed to delete category');
  }
}
}

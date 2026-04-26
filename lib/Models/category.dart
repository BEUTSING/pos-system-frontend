// This file defines the Category class, which represents a product category in the application.
class Category {
  final int id;
  final String name;
  final String description;
  Category({required this.id, required this.name, required this.description});

//Factory Constructor to create a Category instance from JSON data
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'description': description,
    };
  }
}

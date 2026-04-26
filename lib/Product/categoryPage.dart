import 'package:flutter/material.dart';
import 'package:pos_front/Models/category.dart';
import 'package:pos_front/Service/categoryService.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  // Instance of the Categoryservice to interact with the API
  final CategoryService service = CategoryService();
  // List to hold the categories fetched from the API
  List<Category> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  // Method to load categories from the API and update the state
  Future<void> loadCategories() async {
    try {
      final data = await service.getCategories();
      setState(() {
        categories = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  // Method to determine the number of columns in the grid based on screen width
  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(
      context,
    ).size.width; // Adjust the breakpoints as needed

    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }

 String getCode(String name) {
  return name
      .trim()
      .split(" ")
      .where((word) => word.isNotEmpty)
      .map((word) => word[0].toUpperCase())
      .join();
}

  // CREATE
  void openCreate() {
    showDialog(
      context: context,
      builder: (_) => CategoryDialog(
        onSave: (name, desc) async {
          await service.createCategory(name, desc);
          loadCategories();
        },
      ),
    );
  }

  // EDIT
  void openEdit(Category c) {
    showDialog(
      context: context,
      builder: (_) => CategoryDialog(
        category: c,
        onSave: (name, desc) async {
          await service.updateCategory(c.id, name, desc);
          loadCategories();
        },
      ),
    );
  }

  //  DELETE
  void delete(int id) async {
    await service.deleteCategory(id);
    loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        
        title: const Text("Categories"),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Add Category"),
            onPressed: openCreate,
          ),
        ],
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Show loading indicator while fetching data
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // Use the method to determine the number of columns
                crossAxisCount: getCrossAxisCount(context),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.5 / 2,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final c = categories[index];

                return GestureDetector(
                  onTap: () => openEdit(c),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(child: Text(getCode(c.name))),

                          const SizedBox(height: 10),

                          Text(
                            c.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),

                          Text(c.description),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => delete(c.id),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

      
    );
  }
}









// DIALOG USED FOR BOTH CREATE AND EDIT
class CategoryDialog extends StatefulWidget {
  final Category? category;
  final Function(String name, String description) onSave;

  const CategoryDialog({
    super.key,
    this.category,
    required this.onSave,
  });

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.category?.name ?? "",
    );

    descController = TextEditingController(
      text: widget.category?.description ?? "",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.category == null ? "Create Category" : "Edit Category",
      ),

      content: Form(
        key: _formKey,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // 🔵 NAME FIELD
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),

              // 🔥 VALIDATION NAME
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Name is required";
                }
                if (value.length < 3) {
                  return "Minimum 3 characters";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            // 🟡 DESCRIPTION FIELD
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),

              maxLines: 2,

              // 🔥 VALIDATION DESCRIPTION
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Description is required";
                }
                if (value.length < 5) {
                  return "Minimum 5 characters";
                }
                return null;
              },
            ),
          ],
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: () {
            // 🔥 STEP 1: validate form
            if (_formKey.currentState!.validate()) {
              
              widget.onSave(
                nameController.text.trim(),
                descController.text.trim(),
              );

              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
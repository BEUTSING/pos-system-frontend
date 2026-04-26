import 'package:flutter/material.dart';
import 'package:pos_front/Models/Product.dart';
import 'package:pos_front/Models/Supplier.dart';
import 'package:pos_front/Models/category.dart';
import 'package:pos_front/Service/productService.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final Productservice service = Productservice();

  List<Product> products = [];
  List<Category> categories = [];
List<Supplier> suppliers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final data = await service.getProducts();
      setState(() {
        products = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  int getCrossAxisCount(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 600) return 2;
    if (width < 900) return 3;
    return 4;
  }

  // CREATE
  void openCreate() {
    showDialog(
      context: context,
      builder: (_) => ProductDialog(
        categories: categories,
        suppliers: suppliers,
        onSave: (product) async {
          await service.createProduct(product);
          loadProducts();
        },
      ),
    );
  }

  // EDIT
  void openEdit(Product p) {
    showDialog(
      context: context,
      builder: (_) => ProductDialog(
        product: p,
        categories: categories,
        suppliers: suppliers,
        onSave: (updated) async {
          await service.updateProduct(p.id, updated);
          loadProducts();
        },
      ),
    );
  }

  // DELETE
  void delete(int id) async {
    await service.deleteProduct(id);
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Add Product"),
            onPressed: openCreate,
          ),
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getCrossAxisCount(context),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3.2 / 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];

                return GestureDetector(
                  onTap: () => openEdit(p),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.productname,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text("Category: ${p.category.name}"),

                          if (p.supplier != null)
                            Text("Supplier: ${p.supplier!.name}"),

                          Text("Purchase: ${p.purchaseprice}"),
                          Text("Sale: ${p.saleprice}"),
                          Text("Stock: ${p.quantity}"),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => delete(p.id),
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

class ProductDialog extends StatefulWidget {
  final Product? product;
  final List<Category> categories;
  final List<Supplier> suppliers;
  final Function(Product product) onSave;

  const ProductDialog({
    super.key,
    this.product,
    required this.categories,
    required this.suppliers,
    required this.onSave,
  });

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController purchaseController;
  late TextEditingController saleController;
  late TextEditingController quantityController;
  late TextEditingController minimumController;

  Category? selectedCategory;
  Supplier? selectedSupplier;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.product?.productname ?? "");
    purchaseController = TextEditingController(
        text: widget.product?.purchaseprice.toString() ?? "");
    saleController = TextEditingController(
        text: widget.product?.saleprice.toString() ?? "");
    quantityController = TextEditingController(
        text: widget.product?.quantity.toString() ?? "");
    minimumController = TextEditingController(
        text: widget.product?.minimumstock.toString() ?? "");

    selectedCategory = widget.product?.category;
    selectedSupplier = widget.product?.supplier;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.product == null ? "Create Product" : "Edit Product"),

      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 🟢 NAME
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Product name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 10),

              // 🟡 CATEGORY DROPDOWN
              DropdownButtonFormField<Category>(
                value: selectedCategory,
                decoration: const InputDecoration(labelText: "Category"),
                items: widget.categories.map((c) {
                  return DropdownMenuItem(
                    value: c,
                    child: Text(c.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) =>
                    value == null ? "Select category" : null,
              ),

              const SizedBox(height: 10),

              // 🔵 SUPPLIER DROPDOWN
              DropdownButtonFormField<Supplier>(
                value: selectedSupplier,
                decoration: const InputDecoration(labelText: "Supplier"),
                items: widget.suppliers.map((s) {
                  return DropdownMenuItem(
                    value: s,
                    child: Text(s.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSupplier = value;
                  });
                },
              ),

              const SizedBox(height: 10),

              // PURCHASE PRICE
              TextFormField(
                controller: purchaseController,
                decoration: const InputDecoration(labelText: "Purchase price"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 10),

              // SALE PRICE
              TextFormField(
                controller: saleController,
                decoration: const InputDecoration(labelText: "Sale price"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 10),

              // QUANTITY
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 10),

              // MINIMUM STOCK
              TextFormField(
                controller: minimumController,
                decoration: const InputDecoration(labelText: "Minimum stock"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),

        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final product = Product(
                id: widget.product?.id ?? 0,
                productname: nameController.text,
                category: selectedCategory!,
                supplier: selectedSupplier,
                purchaseprice: double.parse(purchaseController.text),
                saleprice: double.parse(saleController.text),
                quantity: int.parse(quantityController.text),
                minimumstock: int.parse(minimumController.text),
              );

              widget.onSave(product);
              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
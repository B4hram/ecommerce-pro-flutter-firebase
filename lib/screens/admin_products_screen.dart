import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'add_product_screen.dart';

class AdminProductsScreen
    extends StatefulWidget {
  const AdminProductsScreen({
    super.key,
  });

  @override
  State<AdminProductsScreen> createState() =>
      _AdminProductsScreenState();
}

class _AdminProductsScreenState
    extends State<AdminProductsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<ProductProvider>()
          .fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<ProductProvider>();

    final products =
        provider.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Products',
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddProductScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Product',
        ),
      ),

      body: provider.isLoading
          ? const Center(
              child:
                  CircularProgressIndicator(),
            )
          : products.isEmpty
              ? const Center(
                  child: Text(
                    'No products found',
                    style:
                        TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.all(16),
                  itemCount:
                      products.length,
                  itemBuilder:
                      (context, index) {
                    final product =
                        products[index];

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: ListTile(
                        leading:
                            ClipRRect(
                          borderRadius:
                              BorderRadius
                                  .circular(
                            10,
                          ),
                          child:
                              Image.network(
                            product.image,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return const Icon(
                                Icons
                                    .image_not_supported,
                              );
                            },
                          ),
                        ),

                        title: Text(
                          product.name,
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          '\$${product.price.toStringAsFixed(2)}',
                        ),

                        trailing:
                            IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            final confirm =
                                await showDialog<
                                    bool>(
                              context:
                                  context,
                              builder:
                                  (context) {
                                return AlertDialog(
                                  title:
                                      const Text(
                                    'Delete Product?',
                                  ),
                                  content:
                                      Text(
                                    'Delete ${product.name}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                          context,
                                          false,
                                        );
                                      },
                                      child:
                                          const Text(
                                        'Cancel',
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                          context,
                                          true,
                                        );
                                      },
                                      child:
                                          const Text(
                                        'Delete',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirm ==
                                true) {
                              // ignore: use_build_context_synchronously
                              await context
                                  .read<
                                      ProductProvider>()
                                  .deleteProduct(
                                    product.id,
                                  );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
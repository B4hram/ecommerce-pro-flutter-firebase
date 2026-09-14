// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/product_provider.dart';
// import 'edit_product_screen.dart';

// class ManageProductsScreen extends StatefulWidget {
//   const ManageProductsScreen({super.key});

//   @override
//   State<ManageProductsScreen> createState() =>
//       _ManageProductsScreenState();
// }

// class _ManageProductsScreenState
//     extends State<ManageProductsScreen> {

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context
//           .read<ProductProvider>()
//           .fetchProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider =
//         context.watch<ProductProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Manage Products",
//         ),
//       ),
//       body: ListView.builder(
//         itemCount:
//             provider.products.length,
//         itemBuilder: (context, index) {
//           final product =
//               provider.products[index];

//           return Card(
//             child: ListTile(
//               leading: Image.network(
//                 product.image,
//                 width: 60,
//                 fit: BoxFit.cover,
//               ),
//               title: Text(product.name),
//               subtitle: Text(
//                 "\$${product.price}",
//               ),
//               trailing: Row(
//                 mainAxisSize:
//                     MainAxisSize.min,
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.edit,
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               EditProductScreen(
//                             product:
//                                 product,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   IconButton(
//                     icon: const Icon(
//                       Icons.delete,
//                       color: Colors.red,
//                     ),
//                     onPressed: () async {
//                       await provider
//                           .deleteProduct(
//                         product.id,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import 'edit_product_screen.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() =>
      _ManageProductsScreenState();
}

class _ManageProductsScreenState
    extends State<ManageProductsScreen> {

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Products',
        ),
      ),

      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.products.isEmpty
              ? const Center(
                  child: Text(
                    'No products found.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              : ListView.builder(
                  padding:
                      const EdgeInsets.all(16),

                  itemCount:
                      provider.products.length,

                  itemBuilder:
                      (context, index) {

                    final product =
                        provider.products[index];

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 15,
                      ),

                      elevation: 3,

                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(
                          15,
                        ),
                      ),

                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                          12,
                        ),

                        child: Row(
                          children: [

                            // PRODUCT IMAGE
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),

                              child:
                                  Image.network(
                                product.image,

                                width: 80,
                                height: 80,

                                fit: BoxFit.cover,

                                errorBuilder:
                                    (
                                  context,
                                  error,
                                  stackTrace,
                                ) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors
                                        .grey
                                        .shade200,
                                    child:
                                        const Icon(
                                      Icons
                                          .image_not_supported,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(
                              width: 15,
                            ),

                            // PRODUCT INFORMATION
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(
                                    product.name,

                                    style:
                                        const TextStyle(
                                      fontSize: 17,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',

                                    style:
                                        const TextStyle(
                                      color:
                                          Colors.green,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    product.category,

                                    style:
                                        TextStyle(
                                      color: Colors
                                          .grey
                                          .shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // EDIT + DELETE
                            Column(
                              children: [

                                IconButton(
                                  tooltip:
                                      'Edit Product',

                                  icon:
                                      const Icon(
                                    Icons.edit,
                                    color:
                                        Colors.deepPurple,
                                  ),

                                  onPressed: () {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            EditProductScreen(
                                          product:
                                              product,
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                IconButton(
                                  tooltip:
                                      'Delete Product',

                                  icon:
                                      const Icon(
                                    Icons.delete,
                                    color:
                                        Colors.red,
                                  ),

                                  onPressed: () async {

                                    final confirmed =
                                        await showDialog<
                                            bool>(
                                      context:
                                          context,

                                      builder:
                                          (context) {
                                        return AlertDialog(
                                          title:
                                              const Text(
                                            'Delete Product',
                                          ),

                                          content:
                                              Text(
                                            'Are you sure you want to delete ${product.name}?',
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

                                    if (confirmed ==
                                        true) {

                                      await provider
                                          .deleteProduct(
                                        product.id,
                                      );

                                      if (!context
                                          .mounted) {
                                        return;
                                      }

                                      ScaffoldMessenger
                                              .of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text(
                                            'Product deleted successfully.',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
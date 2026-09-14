// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/product_provider.dart';

// class AddProductScreen extends StatefulWidget {
//   const AddProductScreen({super.key});

//   @override
//   State<AddProductScreen> createState() => _AddProductScreenState();
// }

// class _AddProductScreenState extends State<AddProductScreen> {
//   final nameController = TextEditingController();

//   final descriptionController = TextEditingController();

//   final priceController = TextEditingController();

//   final imageController = TextEditingController();

//   final categoryController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Product")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: "Product Name"),
//             ),

//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(labelText: "Description"),
//             ),

//             TextField(
//               controller: priceController,
//               decoration: const InputDecoration(labelText: "Price"),
//             ),

//             TextField(
//               controller: imageController,
//               decoration: const InputDecoration(labelText: "Image URL"),
//             ),
//             TextField(
//               controller: categoryController,
//               decoration: const InputDecoration(labelText: "Category"),
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () async {
//                 await context.read<ProductProvider>().addProduct(
//                   name: nameController.text,
//                   description: descriptionController.text,
//                   price: double.parse(priceController.text),
//                   image: imageController.text,
//                   category: categoryController.text,
//                 );

//                 if (mounted) {
//                   Navigator.pop(context);
//                 }
//               },
//               child: const Text("Save Product"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/product_provider.dart';

// class AddProductScreen
//     extends StatefulWidget {
//   const AddProductScreen({
//     super.key,
//   });

//   @override
//   State<AddProductScreen> createState() =>
//       _AddProductScreenState();
// }

// class _AddProductScreenState
//     extends State<AddProductScreen> {
//   final nameController =
//       TextEditingController();

//   final priceController =
//       TextEditingController();

//   final descriptionController =
//       TextEditingController();

//   final imageController =
//       TextEditingController();

//   String category = 'Laptops';

//   bool isSaving = false;

//   @override
//   void dispose() {
//     nameController.dispose();
//     priceController.dispose();
//     descriptionController.dispose();
//     imageController.dispose();

//     super.dispose();
//   }

//   Future<void> saveProduct() async {
//     final name =
//         nameController.text.trim();

//     final price =
//         double.tryParse(
//       priceController.text.trim(),
//     );

//     final description =
//         descriptionController.text.trim();

//     final image =
//         imageController.text.trim();

//     if (name.isEmpty ||
//         price == null ||
//         description.isEmpty ||
//         image.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Please fill all fields.',
//           ),
//         ),
//       );

//       return;
//     }

//     setState(() {
//       isSaving = true;
//     });

//     try {
//       await context
//           .read<ProductProvider>()
//           .addProduct(
//             name: name,
//             price: price,
//             description: description,
//             category: category,
//             image: image,
//           );

//       if (!mounted) return;

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Product added successfully!',
//           ),
//         ),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Error: $e',
//           ),
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           isSaving = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Add Product',
//         ),
//       ),

//       body: SingleChildScrollView(
//         padding:
//             const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller:
//                   nameController,
//               decoration:
//                   const InputDecoration(
//                 labelText:
//                     'Product Name',
//                 border:
//                     OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller:
//                   priceController,
//               keyboardType:
//                   const TextInputType
//                       .numberWithOptions(
//                 decimal: true,
//               ),
//               decoration:
//                   const InputDecoration(
//                 labelText:
//                     'Price',
//                 prefixText: '\$ ',
//                 border:
//                     OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 15),

//             DropdownButtonFormField<String>(
//               initialValue: category,
//               decoration:
//                   const InputDecoration(
//                 labelText:
//                     'Category',
//                 border:
//                     OutlineInputBorder(),
//               ),
//               items: const [
//                 'Phones',
//                 'Laptops',
//                 'Shoes',
//                 'Fashion',
//                 'Accessories',
//               ].map((item) {
//                 return DropdownMenuItem(
//                   value: item,
//                   child: Text(item),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 if (value != null) {
//                   setState(() {
//                     category = value;
//                   });
//                 }
//               },
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller:
//                   descriptionController,
//               maxLines: 4,
//               decoration:
//                   const InputDecoration(
//                 labelText:
//                     'Description',
//                 border:
//                     OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller:
//                   imageController,
//               decoration:
//                   const InputDecoration(
//                 labelText:
//                     'Image URL',
//                 hintText:
//                     'https://example.com/image.jpg',
//                 border:
//                     OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 20),

//             if (imageController.text
//                 .isNotEmpty)
//               ClipRRect(
//                 borderRadius:
//                     BorderRadius.circular(
//                   15,
//                 ),
//                 child: Image.network(
//                   imageController.text,
//                   height: 180,
//                   width:
//                       double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder:
//                       (
//                     context,
//                     error,
//                     stackTrace,
//                   ) {
//                     return const SizedBox(
//                       height: 180,
//                       child: Center(
//                         child: Text(
//                           'Invalid image URL',
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//             const SizedBox(height: 25),

//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton(
//                 onPressed:
//                     isSaving
//                         ? null
//                         : saveProduct,
//                 child: isSaving
//                     ? const CircularProgressIndicator()
//                     : const Text(
//                         'Add Product',
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  String category = 'Laptops';
  bool isSaving = false;
  bool showImagePreview = false;

  final List<String> categories = const [
    'Phones',
    'Laptops',
    'Shoes',
    'Fashion',
    'Accessories',
  ];

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    final price = double.parse(priceController.text.trim());
    final description = descriptionController.text.trim();
    final image = imageController.text.trim();

    setState(() {
      isSaving = true;
    });

    try {
      await context.read<ProductProvider>().addProduct(
            name: name,
            price: price,
            description: description,
            category: category,
            image: image,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully!'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add product: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  void previewImage() {
    final url = imageController.text.trim();

    setState(() {
      showImagePreview = url.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------------------------------------------------------
                // HEADER
                // ---------------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        colorScheme.primary,
                        colorScheme.primaryContainer,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Create New Product',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Add a new product to your store',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ---------------------------------------------------------
                // BASIC INFORMATION
                // ---------------------------------------------------------
                Text(
                  'Basic Information',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Enter the main information about your product.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),

                const SizedBox(height: 18),

                // Product Name
                TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: 'e.g. Dell XPS 15',
                    prefixIcon: const Icon(
                      Icons.inventory_2_outlined,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surface,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the product name';
                    }

                    if (value.trim().length < 2) {
                      return 'Product name is too short';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Price
                TextFormField(
                  controller: priceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Price',
                    hintText: '0.00',
                    prefixIcon: const Icon(
                      Icons.attach_money_rounded,
                    ),
                    prefixText: '\$ ',
                    filled: true,
                    fillColor: isDark
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surface,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the product price';
                    }

                    final price = double.tryParse(value.trim());

                    if (price == null) {
                      return 'Please enter a valid price';
                    }

                    if (price <= 0) {
                      return 'Price must be greater than 0';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Category
                DropdownButtonFormField<String>(
                  initialValue: category,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    prefixIcon: const Icon(
                      Icons.category_outlined,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surface,
                  ),
                  items: categories.map((item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: isSaving
                      ? null
                      : (value) {
                          if (value != null) {
                            setState(() {
                              category = value;
                            });
                          }
                        },
                ),

                const SizedBox(height: 16),

                // Description
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Describe the product...',
                    alignLabelWithHint: true,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 75),
                      child: Icon(
                        Icons.description_outlined,
                      ),
                    ),
                    filled: true,
                    fillColor: isDark
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surface,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a product description';
                    }

                    if (value.trim().length < 10) {
                      return 'Description should be at least 10 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 28),

                // ---------------------------------------------------------
                // PRODUCT IMAGE
                // ---------------------------------------------------------
                Text(
                  'Product Image',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Enter an image URL for the product.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),

                const SizedBox(height: 18),

                TextFormField(
                  controller: imageController,
                  keyboardType: TextInputType.url,
                  onChanged: (value) {
                    setState(() {
                      showImagePreview = value.trim().isNotEmpty;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    hintText: 'https://example.com/product.jpg',
                    prefixIcon: const Icon(
                      Icons.image_outlined,
                    ),
                    suffixIcon: IconButton(
                      tooltip: 'Preview image',
                      icon: const Icon(
                        Icons.visibility_outlined,
                      ),
                      onPressed: previewImage,
                    ),
                    filled: true,
                    fillColor: isDark
                        ? colorScheme.surfaceContainerHighest
                        : colorScheme.surface,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an image URL';
                    }

                    final url = value.trim();

                    if (!url.startsWith('http://') &&
                        !url.startsWith('https://')) {
                      return 'Please enter a valid image URL';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ---------------------------------------------------------
                // IMAGE PREVIEW
                // ---------------------------------------------------------
                if (showImagePreview)
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? colorScheme.surfaceContainerHighest
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outlineVariant,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16,
                            14,
                            16,
                            10,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.preview_outlined,
                                size: 20,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Image Preview',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: Image.network(
                            imageController.text.trim(),
                            fit: BoxFit.cover,
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress
                                              .cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (
                              context,
                              error,
                              stackTrace,
                            ) {
                              return Container(
                                color: isDark
                                    ? Colors.black26
                                    : Colors.grey.shade200,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.broken_image_outlined,
                                          size: 50,
                                          color: colorScheme.error,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Unable to load image',
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Check that the image URL is correct.',
                                          textAlign: TextAlign.center,
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 30),

                // ---------------------------------------------------------
                // SUMMARY
                // ---------------------------------------------------------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer.withValues(
                      alpha: isDark ? 0.25 : 0.55,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Make sure all product information is correct before adding it to the store.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ---------------------------------------------------------
                // ADD PRODUCT BUTTON
                // ---------------------------------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed: isSaving ? null : saveProduct,
                    icon: isSaving
                        ? const SizedBox(
                            width: 21,
                            height: 21,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.add_shopping_cart_rounded,
                          ),
                    label: Text(
                      isSaving ? 'Adding Product...' : 'Add Product',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Cancel button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: isSaving
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/product_model.dart';
// import '../providers/product_provider.dart';

// class EditProductScreen extends StatefulWidget {
//   final ProductModel product;

//   const EditProductScreen({super.key, required this.product});

//   @override
//   State<EditProductScreen> createState() => _EditProductScreenState();
// }

// class _EditProductScreenState extends State<EditProductScreen> {
//   late TextEditingController nameController;
//   late TextEditingController priceController;
//   late TextEditingController descriptionController;
//   late TextEditingController imageController;

//   late String category;
//   bool isSaving = false;

//   final List<String> categories = [
//     'Phones',
//     'Laptops',
//     'Shoes',
//     'Fashion',
//     'Accessories',
//   ];

//   @override
//   void initState() {
//     super.initState();

//     nameController = TextEditingController(text: widget.product.name);

//     priceController = TextEditingController(
//       text: widget.product.price.toString(),
//     );

//     descriptionController = TextEditingController(
//       text: widget.product.description,
//     );

//     imageController = TextEditingController(text: widget.product.image);

//     category = categories.contains(widget.product.category)
//         ? widget.product.category
//         : 'Laptops';
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     priceController.dispose();
//     descriptionController.dispose();
//     imageController.dispose();
//     super.dispose();
//   }

//   Future<void> updateProduct() async {
//     final name = nameController.text.trim();
//     final price = double.tryParse(priceController.text.trim());
//     final description = descriptionController.text.trim();
//     final image = imageController.text.trim();

//     if (name.isEmpty || price == null || description.isEmpty || image.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields correctly.')),
//       );
//       return;
//     }

//     setState(() {
//       isSaving = true;
//     });

//     try {
//       await context.read<ProductProvider>().updateProduct(
//         id: widget.product.id,
//         name: name,
//         price: price,
//         description: description,
//         category: category,
//         image: image,
//       );

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Product updated successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error updating product: $e'),
//           backgroundColor: Colors.red,
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
//       appBar: AppBar(title: const Text('Edit Product')),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Product Name',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.shopping_bag),
//               ),
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller: priceController,
//               keyboardType: const TextInputType.numberWithOptions(
//                 decimal: true,
//               ),
//               decoration: const InputDecoration(
//                 labelText: 'Price',
//                 prefixText: '\$ ',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.attach_money),
//               ),
//             ),

//             const SizedBox(height: 15),

//             DropdownButtonFormField<String>(
//               initialValue: category,
//               decoration: const InputDecoration(
//                 labelText: 'Category',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.category),
//               ),
//               items: categories.map((item) {
//                 return DropdownMenuItem<String>(value: item, child: Text(item));
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
//               controller: descriptionController,
//               maxLines: 4,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.description),
//               ),
//             ),

//             const SizedBox(height: 15),

//             TextField(
//               controller: imageController,
//               decoration: const InputDecoration(
//                 labelText: 'Image URL',
//                 hintText: 'https://example.com/image.jpg',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.image),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // IMAGE PREVIEW
//             if (imageController.text.isNotEmpty)
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.network(
//                   imageController.text,
//                   height: 200,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       height: 200,
//                       width: double.infinity,
//                       alignment: Alignment.center,
//                       color: Colors.grey.shade200,
//                       child: const Text('Invalid image URL'),
//                     );
//                   },
//                 ),
//               ),

//             const SizedBox(height: 25),

//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton.icon(
//                 onPressed: isSaving ? null : updateProduct,
//                 icon: isSaving
//                     ? const SizedBox(
//                         width: 20,
//                         height: 20,
//                         child: CircularProgressIndicator(strokeWidth: 2),
//                       )
//                     : const Icon(Icons.save),
//                 label: Text(isSaving ? 'Updating...' : 'Update Product'),
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

import '../models/product_model.dart';
import '../providers/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;

  const EditProductScreen({
    super.key,
    required this.product,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController imageController;

  late String category;

  bool isSaving = false;
  bool showImagePreview = true;

  final List<String> categories = const [
    'Phones',
    'Laptops',
    'Shoes',
    'Fashion',
    'Accessories',
  ];

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.product.name,
    );

    priceController = TextEditingController(
      text: widget.product.price.toString(),
    );

    descriptionController = TextEditingController(
      text: widget.product.description,
    );

    imageController = TextEditingController(
      text: widget.product.image,
    );

    category = categories.contains(widget.product.category)
        ? widget.product.category
        : 'Laptops';

    imageController.addListener(_imageChanged);
  }

  void _imageChanged() {
    if (!mounted) return;

    setState(() {
      showImagePreview = imageController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    imageController.removeListener(_imageChanged);

    nameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();

    super.dispose();
  }

  Future<void> updateProduct() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = nameController.text.trim();
    final price = double.parse(
      priceController.text.trim(),
    );
    final description = descriptionController.text.trim();
    final image = imageController.text.trim();

    setState(() {
      isSaving = true;
    });

    try {
      await context.read<ProductProvider>().updateProduct(
            id: widget.product.id,
            name: name,
            price: price,
            description: description,
            category: category,
            image: image,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Product updated successfully!',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to update product: $e',
          ),
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

  Future<bool> _confirmExit() async {
    if (isSaving) {
      return false;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: const Text(
            'Discard Changes?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to leave? '
            'Your changes will not be saved.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Stay'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
              child: const Text('Discard'),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: !isSaving,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop || isSaving) return;

        final shouldPop = await _confirmExit();

        if (shouldPop && mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Product',
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
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =======================================================
                  // HEADER
                  // =======================================================

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
                            color: Colors.white.withValues(
                              alpha: 0.18,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            Icons.edit_note_rounded,
                            color: Colors.white,
                            size: 31,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Edit Product',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Update ${widget.product.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
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

                  // =======================================================
                  // BASIC INFORMATION
                  // =======================================================

                  Text(
                    'Product Information',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Update the information for this product.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Product Name
                  TextFormField(
                    controller: nameController,
                    enabled: !isSaving,
                    textCapitalization:
                        TextCapitalization.words,
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
                      if (value == null ||
                          value.trim().isEmpty) {
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
                    enabled: !isSaving,
                    keyboardType:
                        const TextInputType.numberWithOptions(
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
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter the product price';
                      }

                      final price = double.tryParse(
                        value.trim(),
                      );

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
                    enabled: !isSaving,
                    maxLines: 5,
                    textCapitalization:
                        TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText:
                          'Describe the product...',
                      alignLabelWithHint: true,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(
                          bottom: 75,
                        ),
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
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter a description';
                      }

                      if (value.trim().length < 10) {
                        return 'Description should be at least 10 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 28),

                  // =======================================================
                  // IMAGE
                  // =======================================================

                  Text(
                    'Product Image',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Change the product image URL if needed.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),

                  const SizedBox(height: 18),

                  TextFormField(
                    controller: imageController,
                    enabled: !isSaving,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      hintText:
                          'https://example.com/product.jpg',
                      prefixIcon: const Icon(
                        Icons.image_outlined,
                      ),
                      filled: true,
                      fillColor: isDark
                          ? colorScheme.surfaceContainerHighest
                          : colorScheme.surface,
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
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

                  // =======================================================
                  // IMAGE PREVIEW
                  // =======================================================

                  if (showImagePreview)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark
                            ? colorScheme
                                .surfaceContainerHighest
                            : Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              colorScheme.outlineVariant,
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(
                              16,
                              14,
                              16,
                              10,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .preview_outlined,
                                  size: 20,
                                  color:
                                      colorScheme.primary,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Current Image Preview',
                                  style: theme
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                        fontWeight:
                                            FontWeight.bold,
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
                                  (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress ==
                                    null) {
                                  return child;
                                }

                                return Center(
                                  child:
                                      CircularProgressIndicator(
                                    value: loadingProgress
                                                .expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress
                                                .expectedTotalBytes!
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
                                      padding:
                                          const EdgeInsets
                                              .all(20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                        children: [
                                          Icon(
                                            Icons
                                                .broken_image_outlined,
                                            size: 50,
                                            color:
                                                colorScheme
                                                    .error,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Unable to load image',
                                            style: theme
                                                .textTheme
                                                .titleMedium
                                                ?.copyWith(
                                                  fontWeight:
                                                      FontWeight
                                                          .bold,
                                                ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            'Check that the image URL is correct.',
                                            textAlign:
                                                TextAlign
                                                    .center,
                                            style: theme
                                                .textTheme
                                                .bodySmall,
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

                  // =======================================================
                  // PRODUCT ID
                  // =======================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? colorScheme.surfaceContainerHighest
                          : colorScheme.surface,
                      borderRadius:
                          BorderRadius.circular(18),
                      border: Border.all(
                        color:
                            colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.fingerprint_rounded,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Product ID',
                                style: theme
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.product.id,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style: theme
                                    .textTheme
                                    .bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // =======================================================
                  // UPDATE BUTTON
                  // =======================================================

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton.icon(
                      onPressed:
                          isSaving ? null : updateProduct,
                      icon: isSaving
                          ? const SizedBox(
                              width: 21,
                              height: 21,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(
                              Icons.save_rounded,
                            ),
                      label: Text(
                        isSaving
                            ? 'Updating Product...'
                            : 'Save Changes',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =======================================================
                  // CANCEL BUTTON
                  // =======================================================

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: isSaving
                          ? null
                          : () async {
                              final shouldPop =
                                  await _confirmExit();

                              if (shouldPop &&
                                  mounted) {
                                Navigator.pop(context);
                              }
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
      ),
    );
  }
}
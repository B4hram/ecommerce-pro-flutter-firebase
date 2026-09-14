// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/product_model.dart';
// import '../providers/wishlist_provider.dart';

// class ProductCard extends StatelessWidget {
//   final ProductModel product;
//   final VoidCallback onTap;

//   const ProductCard({super.key, required this.product, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     context.watch<WishlistProvider>();

//     return InkWell(
//   onTap: onTap,
//   child: Card(
//     elevation: 5,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(16),
//     ),
//     clipBehavior: Clip.antiAlias,
//         child:Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Expanded(
//       child: Image.network(
//         product.image,
//         width: double.infinity,
//         fit: BoxFit.cover,
//         errorBuilder:
//             (context, error, stackTrace) {
//           return const Center(
//             child: Icon(
//               Icons.image_not_supported,
//               size: 50,
//             ),
//           );
//         },
//       ),
//     ),

//     Padding(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,
//         children: [
//           Text(
//             product.name,
//             maxLines: 1,
//             overflow:
//                 TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontWeight:
//                   FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),

//           const SizedBox(height: 5),

//           Row(
//             children: const [
//               Icon(
//                 Icons.star,
//                 color: Colors.amber,
//                 size: 18,
//               ),
//               SizedBox(width: 4),
//               Text("4.8"),
//             ],
//           ),

//           const SizedBox(height: 5),

//           Text(
//             "\$${product.price}",
//             style: const TextStyle(
//               color: Colors.green,
//               fontWeight:
//                   FontWeight.bold,
//               fontSize: 18,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/wishlist_provider.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistProvider>();

    final isFavorite = wishlist.isFavorite(product.id);

    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // PRODUCT IMAGE
            // =====================================================
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,

                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },

                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 45,
                              color: Colors.grey.shade500,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // =================================================
                  // CATEGORY BADGE
                  // =================================================
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        product.category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // =================================================
                  // WISHLIST BUTTON
                  // =================================================
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Material(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withOpacity(0.92),
                      shape: const CircleBorder(),
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        tooltip: isFavorite
                            ? 'Remove from wishlist'
                            : 'Add to wishlist',
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : Theme.of(context).colorScheme.onSurface,
                          size: 21,
                        ),
                        onPressed: () {
                          wishlist.toggleFavorite(product);

                          ScaffoldMessenger.of(context).hideCurrentSnackBar();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 900),
                              content: Text(
                                isFavorite
                                    ? 'Removed from wishlist'
                                    : 'Added to wishlist',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // PRODUCT INFORMATION
            // =====================================================
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(11, 9, 11, 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PRODUCT NAME
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // =================================================
                    // RATING
                    // =================================================
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 17),

                        const SizedBox(width: 3),

                        Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),

                        const SizedBox(width: 4),

                        Text(
                          '(120)',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // =================================================
                    // PRICE + CART BUTTON
                    // =================================================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),

                        const SizedBox(width: 5),

                        // ADD TO CART
                        Material(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(11),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(11),
                            onTap: () {
                              context.read<CartProvider>().addToCart(product);

                              ScaffoldMessenger.of(
                                context,
                              ).hideCurrentSnackBar();

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 900),
                                  content: Text(
                                    '${product.name} added to cart',
                                  ),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(9),
                              child: Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

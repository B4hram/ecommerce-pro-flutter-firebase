// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/wishlist_provider.dart';
// import 'product_details_screen.dart';

// class WishlistScreen extends StatelessWidget {
//   const WishlistScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final wishlist =
//         context.watch<WishlistProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Wishlist",
//         ),
//       ),
//       body: wishlist.wishlist.isEmpty
//           ? const Center(
//               child: Text(
//                 "No favorites yet",
//               ),
//             )
//           : ListView.builder(
//               itemCount:
//                   wishlist.wishlist.length,
//               itemBuilder:
//                   (context, index) {
//                 final product =
//                     wishlist.wishlist[index];

//                 return ListTile(
//                   leading: Image.network(
//                     product.image,
//                     width: 60,
//                   ),
//                   title: Text(
//                     product.name,
//                   ),
//                   subtitle: Text(
//                     "\$${product.price}",
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(
//                       Icons.delete,
//                     ),
//                     onPressed: () {
//                       wishlist
//                           .toggleFavorite(
//                         product,
//                       );
//                     },
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             ProductDetailsScreen(
//                           product: product,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wishlist_provider.dart';
import '../providers/cart_provider.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final wishlist =
        context.watch<WishlistProvider>();

    return Scaffold(
      backgroundColor:
          Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (wishlist.wishlist.isNotEmpty)
            IconButton(
              icon: const Icon(
                Icons.delete_sweep,
              ),
              onPressed: () {
                _showClearDialog(
                  context,
                );
              },
            ),
        ],
      ),

      body: wishlist.wishlist.isEmpty
          ? _emptyWishlist()
          : ListView.builder(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              itemCount:
                  wishlist.wishlist.length,
              itemBuilder:
                  (context, index) {
                final product =
                    wishlist.wishlist[index];

                return Container(
                  margin:
                      const EdgeInsets.only(
                    bottom: 14,
                  ),
                  padding:
                      const EdgeInsets.all(
                    12,
                  ),
                  decoration:
                      BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                      18,
                    ),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius
                                .circular(
                          14,
                        ),
                        child:
                            Image.network(
                          product.image,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              width: 90,
                              height: 90,
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
                        width: 14,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow:
                                  TextOverflow
                                      .ellipsis,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight
                                        .bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style:
                                  const TextStyle(
                                color: Colors
                                    .green,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                fontSize: 17,
                              ),
                            ),

                            const SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              height: 38,
                              child:
                                  ElevatedButton
                                      .icon(
                                onPressed: () {
                                  context
                                      .read<
                                          CartProvider>()
                                      .addToCart(
                                        product,
                                      );

                                  ScaffoldMessenger
                                      .of(
                                    context,
                                  ).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text(
                                        'Added to cart',
                                      ),
                                    ),
                                  );
                                },
                                icon:
                                    const Icon(
                                  Icons
                                      .shopping_cart,
                                  size: 18,
                                ),
                                label:
                                    const Text(
                                  'Add to Cart',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        children: [
                          IconButton(
                            icon:
                                const Icon(
                              Icons.favorite,
                              color:
                                  Colors.red,
                            ),
                            onPressed: () {
                              wishlist
                                  .removeFromWishlist(
                                product.id,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _emptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey.shade400,
          ),

          const SizedBox(
            height: 20,
          ),

          const Text(
            'Your Wishlist is Empty',
            style: TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            'Save products you love\nand find them here later.',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color:
                  Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Clear Wishlist?',
          ),
          content: const Text(
            'Are you sure you want to remove all wishlist products?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<
                        WishlistProvider>()
                    .clearWishlist();

                Navigator.pop(
                  context,
                );
              },
              child: const Text(
                'Clear',
              ),
            ),
          ],
        );
      },
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../models/product_model.dart';
// import '../providers/cart_provider.dart';

// import '../providers/wishlist_provider.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   final ProductModel product;

//   const ProductDetailsScreen({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final wishlist =
//     context.watch<WishlistProvider>();
//     return Scaffold(
//       appBar: AppBar(
//   title: Text(product.name),
//   actions: [
//     IconButton(
//       icon: Icon(
//         wishlist.isFavorite(product.id)
//             ? Icons.favorite
//             : Icons.favorite_border,
//       ),
//       onPressed: () {
//         wishlist.toggleFavorite(product);
//       },
//     ),
//   ],
// ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: double.infinity,
//               height: 300,
//               child: Image.network(
//                 product.image,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             const SizedBox(height: 20),

//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(
//                 horizontal: 16,
//               ),
//               child: Text(
//                 product.name,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight:
//                       FontWeight.bold,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 10),

//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(
//                 horizontal: 16,
//               ),
//               child: Text(
//                 "\$${product.price}",
//                 style: const TextStyle(
//                   fontSize: 22,
//                   fontWeight:
//                       FontWeight.w600,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),

//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(
//                 horizontal: 16,
//               ),
//               child: Text(
//                 product.description,
//                 style: const TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             Padding(
//               padding:
//                   const EdgeInsets.all(16),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     context
//                         .read<CartProvider>()
//                         .addToCart(product);

//                     ScaffoldMessenger.of(
//                             context)
//                         .showSnackBar(
//                       const SnackBar(
//                         content: Text(
//                           "Added to cart",
//                         ),
//                       ),
//                     );
//                   },
//                   child: const Text(
//                     "Add To Cart",
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// 111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/product_model.dart';
// import '../providers/cart_provider.dart';
// import '../providers/wishlist_provider.dart';
// import '../providers/review_provider.dart';
// import '../providers/user_provider.dart';
// import '../widgets/review_card.dart';

// import '../widgets/review_section.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final ProductModel product;

//   const ProductDetailsScreen({super.key, required this.product});

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
//   double selectedRating = 5;

//   final commentController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context.read<ReviewProvider>().fetchReviews(widget.product.id);
//     });
//   }

//   @override
//   void dispose() {
//     commentController.dispose();
//     super.dispose();
//   }

//   Future<void> submitReview() async {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please login to review this product.")),
//       );
//       return;
//     }

//     if (commentController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Please write a review.")));
//       return;
//     }

//     final userProvider = context.read<UserProvider>();

//     await context.read<ReviewProvider>().addReview(
//       productId: widget.product.id,
//       userId: user.uid,
//       userName: userProvider.user?.name ?? "User",
//       userEmail: user.email ?? '',
//       rating: selectedRating,
//       comment: commentController.text.trim(),
//     );

//     commentController.clear();

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Review added successfully!")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final reviewProvider = context.watch<ReviewProvider>();

//     final wishlist = context.watch<WishlistProvider>();

//     final cart = context.read<CartProvider>();

//     final isFavorite = wishlist.isFavorite(widget.product.id);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Product Details"),
//         actions: [
//           IconButton(
//             icon: Icon(
//               isFavorite ? Icons.favorite : Icons.favorite_border,
//               color: Colors.red,
//             ),
//             onPressed: () {
//               wishlist.toggleFavorite(widget.product);
//             },
//           ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Image.network(
//                 widget.product.image,
//                 width: double.infinity,
//                 height: 280,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return Container(
//                     height: 280,
//                     color: Colors.grey.shade200,
//                     child: const Center(
//                       child: Icon(Icons.image_not_supported, size: 60),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 20),

//             Text(
//               widget.product.name,
//               style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               "\$${widget.product.price.toStringAsFixed(2)}",
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),

//             const SizedBox(height: 15),

//             Text(
//               widget.product.description,
//               style: const TextStyle(fontSize: 16),
//             ),

//             const SizedBox(height: 20),

//             ElevatedButton.icon(
//               onPressed: () {
//                 cart.addToCart(widget.product);

//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(const SnackBar(content: Text("Added to cart")));
//               },
//               icon: const Icon(Icons.shopping_cart),
//               label: const Text("Add to Cart"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: const Size(double.infinity, 55),
//               ),
//             ),

//             const SizedBox(height: 30),

//             const Divider(),

//             const SizedBox(height: 15),

//             Row(
//               children: [
//                 const Text(
//                   "Reviews & Ratings",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),

//                 const Spacer(),

//                 const Icon(Icons.star, color: Colors.amber),

//                 const SizedBox(width: 5),

//                 Text(
//                   reviewProvider.averageRating.toStringAsFixed(1),
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),

//                 Text(" (${reviewProvider.reviews.length})"),
//               ],
//             ),

//             const SizedBox(height: 20),

//             _buildReviewForm(),

//             const SizedBox(height: 25),

//             if (reviewProvider.isLoading)
//               const Center(child: CircularProgressIndicator())
//             else if (reviewProvider.reviews.isEmpty)
//               const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(20),
//                   child: Text(
//                     "No reviews yet.\nBe the first to review this product!",
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               )
//             else
//               ...reviewProvider.reviews.map((review) {
//                 final currentUser = FirebaseAuth.instance.currentUser;

//                 return ReviewCard(
//                   review: review,
//                   isOwner:
//                       currentUser != null && currentUser.uid == review.userId,
//                   onDelete: () async {
//                     await context.read<ReviewProvider>().deleteReview(
//                       reviewId: review.id,
//                       productId: widget.product.id,
//                     );
//                   },
//                 );
//               }),

//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildReviewForm() {
//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Write a Review",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 15),

//             Row(
//               children: List.generate(5, (index) {
//                 final starNumber = index + 1;

//                 return IconButton(
//                   onPressed: () {
//                     setState(() {
//                       selectedRating = starNumber.toDouble();
//                     });
//                   },
//                   icon: Icon(
//                     starNumber <= selectedRating
//                         ? Icons.star
//                         : Icons.star_border,
//                     color: Colors.amber,
//                     size: 32,
//                   ),
//                 );
//               }),
//             ),

//             TextField(
//               controller: commentController,
//               maxLines: 4,
//               decoration: InputDecoration(
//                 hintText: "Write your review...",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 15),

//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: submitReview,
//                 child: const Text("Submit Review"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/product_model.dart';
// import '../providers/cart_provider.dart';
// import '../providers/wishlist_provider.dart';
// import '../providers/review_provider.dart';
// import '../providers/user_provider.dart';
// import '../widgets/review_card.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final ProductModel product;

//   const ProductDetailsScreen({
//     super.key,
//     required this.product,
//   });

//   @override
//   State<ProductDetailsScreen> createState() =>
//       _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState
//     extends State<ProductDetailsScreen> {
//   double selectedRating = 5;

//   final commentController =
//       TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context
//           .read<ReviewProvider>()
//           .fetchReviews(widget.product.id);
//     });
//   }

//   @override
//   void dispose() {
//     commentController.dispose();
//     super.dispose();
//   }

//   // ==========================================
//   // SUBMIT REVIEW
//   // ==========================================

//   Future<void> submitReview() async {
//     final user =
//         FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please login to review this product.",
//           ),
//         ),
//       );
//       return;
//     }

//     final comment =
//         commentController.text.trim();

//     if (comment.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Please write a review.",
//           ),
//         ),
//       );
//       return;
//     }

//     try {
//       final userProvider =
//           context.read<UserProvider>();

//       await context
//           .read<ReviewProvider>()
//           .addReview(
//             productId: widget.product.id,
//             userId: user.uid,
//             userName:
//                 userProvider.user?.name ??
//                     "User",
//             userEmail:
//                 user.email ?? '',
//             rating: selectedRating,
//             comment: comment,
//           );

//       commentController.clear();

//       setState(() {
//         selectedRating = 5;
//       });

//       if (!mounted) return;

//       ScaffoldMessenger.of(context)
//           .showSnackBar(
//         const SnackBar(
//           content: Text(
//             "Review added successfully!",
//           ),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context)
//           .showSnackBar(
//         SnackBar(
//           content: Text(
//             "Failed to add review: $e",
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final reviewProvider =
//         context.watch<ReviewProvider>();

//     final wishlist =
//         context.watch<WishlistProvider>();

//     final cart =
//         context.read<CartProvider>();

//     final isFavorite =
//         wishlist.isFavorite(
//       widget.product.id,
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text("Product Details"),

//         actions: [
//           IconButton(
//             icon: Icon(
//               isFavorite
//                   ? Icons.favorite
//                   : Icons.favorite_border,
//               color: Colors.red,
//             ),
//             onPressed: () {
//               wishlist.toggleFavorite(
//                 widget.product,
//               );
//             },
//           ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         padding:
//             const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,

//           children: [
//             // ==================================
//             // PRODUCT IMAGE
//             // ==================================

//             ClipRRect(
//               borderRadius:
//                   BorderRadius.circular(20),

//               child: Image.network(
//                 widget.product.image,

//                 width:
//                     double.infinity,

//                 height: 280,

//                 fit: BoxFit.cover,

//                 errorBuilder:
//                     (
//                   context,
//                   error,
//                   stackTrace,
//                 ) {
//                   return Container(
//                     height: 280,

//                     color: Theme.of(
//                       context,
//                     ).colorScheme.surfaceContainerHighest,

//                     child:
//                         const Center(
//                       child: Icon(
//                         Icons
//                             .image_not_supported,
//                         size: 60,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ==================================
//             // PRODUCT NAME
//             // ==================================

//             Text(
//               widget.product.name,

//               style:
//                   const TextStyle(
//                 fontSize: 26,
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 10),

//             // ==================================
//             // PRODUCT PRICE
//             // ==================================

//             Text(
//               "\$${widget.product.price.toStringAsFixed(2)}",

//               style:
//                   const TextStyle(
//                 fontSize: 24,
//                 fontWeight:
//                     FontWeight.bold,
//                 color: Colors.green,
//               ),
//             ),

//             const SizedBox(height: 15),

//             // ==================================
//             // DESCRIPTION
//             // ==================================

//             Text(
//               widget.product.description,

//               style:
//                   const TextStyle(
//                 fontSize: 16,
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ==================================
//             // ADD TO CART
//             // ==================================

//             ElevatedButton.icon(
//               onPressed: () {
//                 cart.addToCart(
//                   widget.product,
//                 );

//                 ScaffoldMessenger.of(
//                   context,
//                 ).showSnackBar(
//                   const SnackBar(
//                     content: Text(
//                       "Added to cart",
//                     ),
//                   ),
//                 );
//               },

//               icon: const Icon(
//                 Icons.shopping_cart,
//               ),

//               label: const Text(
//                 "Add to Cart",
//               ),

//               style:
//                   ElevatedButton.styleFrom(
//                 minimumSize:
//                     const Size(
//                   double.infinity,
//                   55,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             const Divider(),

//             const SizedBox(height: 15),

//             // ==================================
//             // REVIEW HEADER
//             // ==================================

//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     "Reviews & Ratings",

//                     style:
//                         TextStyle(
//                       fontSize: 22,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),
//                 ),

//                 const Icon(
//                   Icons.star,
//                   color: Colors.amber,
//                 ),

//                 const SizedBox(
//                   width: 5,
//                 ),

//                 Text(
//                   reviewProvider
//                       .averageRating
//                       .toStringAsFixed(1),

//                   style:
//                       const TextStyle(
//                     fontWeight:
//                         FontWeight.bold,
//                   ),
//                 ),

//                 Text(
//                   " (${reviewProvider.reviews.length})",
//                 ),
//               ],
//             ),

//             const SizedBox(height: 20),

//             // ==================================
//             // REVIEW FORM
//             // ==================================

//             _buildReviewForm(),

//             const SizedBox(height: 25),

//             // ==================================
//             // REVIEW LIST
//             // ==================================

//             if (reviewProvider.isLoading)
//               const Center(
//                 child:
//                     CircularProgressIndicator(),
//               )

//             else if (
//               reviewProvider
//                   .reviews
//                   .isEmpty
//             )
//               const Center(
//                 child: Padding(
//                   padding:
//                       EdgeInsets.all(20),

//                   child: Text(
//                     "No reviews yet.\n"
//                     "Be the first to review this product!",

//                     textAlign:
//                         TextAlign.center,
//                   ),
//                 ),
//               )

//             else
//               ...reviewProvider.reviews
//                   .map(
//                 (review) {
//                   final currentUser =
//                       FirebaseAuth
//                           .instance
//                           .currentUser;

//                   return ReviewCard(
//                     review: review,

//                     isOwner:
//                         currentUser !=
//                             null &&
//                         currentUser.uid ==
//                             review.userId,

//                     onDelete:
//                         () async {
//                       await context
//                           .read<
//                               ReviewProvider>()
//                           .deleteReview(
//                             reviewId:
//                                 review.id,
//                             productId:
//                                 widget.product
//                                     .id,
//                           );
//                     },
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==========================================
//   // REVIEW FORM
//   // ==========================================

//   Widget _buildReviewForm() {
//     return Card(
//       elevation: 3,

//       shape:
//           RoundedRectangleBorder(
//         borderRadius:
//             BorderRadius.circular(18),
//       ),

//       child: Padding(
//         padding:
//             const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,

//           children: [
//             const Text(
//               "Write a Review",

//               style:
//                   TextStyle(
//                 fontSize: 18,
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 15),

//             // ==================================
//             // STAR RATING
//             // ==================================

//             Row(
//               children:
//                   List.generate(
//                 5,
//                 (index) {
//                   final starNumber =
//                       index + 1;

//                   return IconButton(
//                     onPressed: () {
//                       setState(() {
//                         selectedRating =
//                             starNumber
//                                 .toDouble();
//                       });
//                     },

//                     icon: Icon(
//                       starNumber <=
//                               selectedRating
//                           ? Icons.star
//                           : Icons
//                               .star_border,

//                       color:
//                           Colors.amber,

//                       size: 32,
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 5),

//             Text(
//               "${selectedRating.toInt()} / 5",
//               style:
//                   const TextStyle(
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 12),

//             // ==================================
//             // COMMENT
//             // ==================================

//             TextField(
//               controller:
//                   commentController,

//               maxLines: 4,

//               decoration:
//                   InputDecoration(
//                 hintText:
//                     "Write your review...",

//                 border:
//                     OutlineInputBorder(
//                   borderRadius:
//                       BorderRadius.circular(
//                     15,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 15),

//             // ==================================
//             // SUBMIT
//             // ==================================

//             SizedBox(
//               width:
//                   double.infinity,

//               child:
//                   ElevatedButton(
//                 onPressed:
//                     submitReview,

//                 child:
//                     const Text(
//                   "Submit Review",
//                 ),
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
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../providers/review_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/review_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  double selectedRating = 5;

  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ReviewProvider>().fetchReviews(widget.product.id);
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  // ============================================================
  // SUBMIT REVIEW
  // ============================================================

  Future<void> submitReview() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to review this product.')),
      );
      return;
    }

    final comment = commentController.text.trim();

    if (comment.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please write a review.')));
      return;
    }

    try {
      final userProvider = context.read<UserProvider>();

      await context.read<ReviewProvider>().addReview(
        productId: widget.product.id,
        userId: user.uid,
        userName: userProvider.user?.name ?? 'User',
        userEmail: user.email ?? '',
        rating: selectedRating,
        comment: comment,
      );

      commentController.clear();

      setState(() {
        selectedRating = 5;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Review added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to add review: $e')));
    }
  }

  // ============================================================
  // ADD TO CART
  // ============================================================

  void _addToCart() {
    context.read<CartProvider>().addToCart(widget.product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${widget.product.name} added to cart',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final reviewProvider = context.watch<ReviewProvider>();

    final wishlist = context.watch<WishlistProvider>();

    final isFavorite = wishlist.isFavorite(widget.product.id);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // ========================================================
      // APP BAR
      // ========================================================
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,

        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),

            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                  0.6,
                ),
                shape: BoxShape.circle,
              ),

              child: IconButton(
                tooltip: 'Wishlist',

                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),

                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,

                    key: ValueKey(isFavorite),

                    color: isFavorite
                        ? Colors.red
                        : theme.colorScheme.onSurface,
                  ),
                ),

                onPressed: () {
                  wishlist.toggleFavorite(widget.product);
                },
              ),
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // ==================================================
              // PRODUCT IMAGE
              // ==================================================
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),

                child: Container(
                  height: 330,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,

                    borderRadius: BorderRadius.circular(28),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),

                        blurRadius: 20,

                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),

                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            widget.product.image,

                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,

                                  size: 70,

                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              );
                            },
                          ),
                        ),

                        // FAVORITE BUTTON
                        Positioned(
                          right: 16,
                          top: 16,

                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface.withOpacity(
                                0.92,
                              ),

                              shape: BoxShape.circle,

                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.12),
                                  blurRadius: 10,
                                ),
                              ],
                            ),

                            child: IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,

                                color: Colors.red,
                              ),

                              onPressed: () {
                                wishlist.toggleFavorite(widget.product);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              // ==================================================
              // PRODUCT INFORMATION
              // ==================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // CATEGORY
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.10),

                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        widget.product.category.toUpperCase(),

                        style: TextStyle(
                          color: theme.colorScheme.primary,

                          fontSize: 12,

                          fontWeight: FontWeight.bold,

                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // PRODUCT NAME
                    Text(
                      widget.product.name,

                      style: TextStyle(
                        fontSize: 28,
                        height: 1.15,
                        fontWeight: FontWeight.w800,

                        color: theme.colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // RATING + REVIEWS
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.12),

                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 19,
                              ),

                              const SizedBox(width: 5),

                              Text(
                                reviewProvider.averageRating.toStringAsFixed(1),

                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 10),

                        Text(
                          '${reviewProvider.reviews.length} reviews',

                          style: TextStyle(
                            color: theme.colorScheme.onSurfaceVariant,

                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // PRICE
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',

                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,

                        color: theme.colorScheme.primary,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // ==================================================
                    // DESCRIPTION
                    // ==================================================
                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withOpacity(0.55),

                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            'Description',

                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,

                              color: theme.colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            widget.product.description,

                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,

                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ==================================================
                    // PRODUCT FEATURES
                    // ==================================================
                    Row(
                      children: [
                        Expanded(
                          child: _featureItem(
                            context,
                            Icons.verified_outlined,
                            'Quality',
                            'Verified product',
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _featureItem(
                            context,
                            Icons.local_shipping_outlined,
                            'Delivery',
                            'Fast shipping',
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _featureItem(
                            context,
                            Icons.security_outlined,
                            'Secure',
                            'Safe shopping',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ==================================================
                    // ADD TO CART
                    // ==================================================
                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton.icon(
                        onPressed: _addToCart,

                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 23,
                        ),

                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          elevation: 3,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    // ==================================================
                    // REVIEWS SECTION
                    // ==================================================
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Reviews & Ratings',

                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w800,

                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.12),

                            borderRadius: BorderRadius.circular(12),
                          ),

                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),

                              const SizedBox(width: 4),

                              Text(
                                reviewProvider.averageRating.toStringAsFixed(1),

                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // ==================================================
                    // REVIEW FORM
                    // ==================================================
                    _buildReviewForm(context),

                    const SizedBox(height: 28),

                    // ==================================================
                    // REVIEW LIST
                    // ==================================================
                    if (reviewProvider.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (reviewProvider.reviews.isEmpty)
                      _emptyReviews(context)
                    else
                      ...reviewProvider.reviews.map((review) {
                        final currentUser = FirebaseAuth.instance.currentUser;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),

                          child: ReviewCard(
                            review: review,

                            isOwner:
                                currentUser != null &&
                                currentUser.uid == review.userId,

                            onDelete: () async {
                              try {
                                await context
                                    .read<ReviewProvider>()
                                    .deleteReview(
                                      reviewId: review.id,
                                      productId: widget.product.id,
                                    );

                                if (!mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Review deleted.'),
                                  ),
                                );
                              } catch (e) {
                                if (!mounted) {
                                  return;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Failed to delete review: $e',
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      }),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // FEATURE ITEM
  // ============================================================

  Widget _featureItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.45),

        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        children: [
          Icon(icon, size: 25, color: theme.colorScheme.primary),

          const SizedBox(height: 7),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),

          const SizedBox(height: 3),

          Text(
            subtitle,
            textAlign: TextAlign.center,

            maxLines: 2,

            overflow: TextOverflow.ellipsis,

            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REVIEW FORM
  // ============================================================

  Widget _buildReviewForm(BuildContext context) {
    final theme = Theme.of(context);

    final user = FirebaseAuth.instance.currentUser;

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.12)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(9),

                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.10),

                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.rate_review_outlined,
                  color: theme.colorScheme.primary,
                ),
              ),

              const SizedBox(width: 12),

              const Text(
                'Write a Review',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // LOGIN WARNING
          if (user == null)
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(12),

              margin: const EdgeInsets.only(bottom: 15),

              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.10),

                borderRadius: BorderRadius.circular(12),
              ),

              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.orange, size: 20),

                  SizedBox(width: 8),

                  Expanded(child: Text('Login to share your review.')),
                ],
              ),
            ),

          // STAR RATING
          Text(
            'Your Rating',

            style: TextStyle(
              fontWeight: FontWeight.w600,

              color: theme.colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: List.generate(5, (index) {
              final starNumber = index + 1;

              final selected = starNumber <= selectedRating;

              return IconButton(
                padding: const EdgeInsets.only(right: 3),

                constraints: const BoxConstraints(),

                onPressed: user == null
                    ? null
                    : () {
                        setState(() {
                          selectedRating = starNumber.toDouble();
                        });
                      },

                icon: Icon(
                  selected ? Icons.star : Icons.star_border,

                  color: Colors.amber,

                  size: 32,
                ),
              );
            }),
          ),

          Text(
            '${selectedRating.toInt()} out of 5 stars',

            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 15),

          // COMMENT
          TextField(
            controller: commentController,

            enabled: user != null,

            maxLines: 4,

            textInputAction: TextInputAction.newline,

            decoration: InputDecoration(
              hintText: 'Share your experience with this product...',

              filled: true,

              fillColor: theme.colorScheme.surface,

              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 12, bottom: 55),

                child: Icon(Icons.chat_bubble_outline),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),

                borderSide: BorderSide.none,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),

                borderSide: BorderSide.none,
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),

                borderSide: BorderSide(
                  color: theme.colorScheme.primary,

                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // SUBMIT
          SizedBox(
            width: double.infinity,
            height: 50,

            child: ElevatedButton.icon(
              onPressed: user == null ? null : submitReview,

              icon: const Icon(Icons.send_rounded, size: 19),

              label: const Text(
                'Submit Review',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY REVIEWS
  // ============================================================

  Widget _emptyReviews(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),

      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),

        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        children: [
          Icon(
            Icons.rate_review_outlined,

            size: 55,

            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.6),
          ),

          const SizedBox(height: 12),

          Text(
            'No reviews yet',

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,

              color: theme.colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            'Be the first person to review this product.',

            textAlign: TextAlign.center,

            style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../models/product_model.dart';
// import '../providers/review_provider.dart';

// class ReviewSection extends StatefulWidget {
//   final ProductModel product;

//   const ReviewSection({
//     super.key,
//     required this.product,
//   });

//   @override
//   State<ReviewSection> createState() =>
//       _ReviewSectionState();
// }

// class _ReviewSectionState
//     extends State<ReviewSection> {
//   final commentController =
//       TextEditingController();

//   double selectedRating = 5;

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context
//           .read<ReviewProvider>()
//           .fetchReviews(
//             widget.product.id,
//           );
//     });
//   }

//   @override
//   void dispose() {
//     commentController.dispose();
//     super.dispose();
//   }

//   // ==========================================
//   // WRITE REVIEW DIALOG
//   // ==========================================

//   void _showReviewDialog() {
//     final user =
//         FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(
//         const SnackBar(
//           content:
//               Text('Please login first.'),
//         ),
//       );
//       return;
//     }

//     selectedRating = 5;
//     commentController.clear();

//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return StatefulBuilder(
//           builder:
//               (
//             context,
//             setDialogState,
//           ) {
//             return AlertDialog(
//               title: const Text(
//                 'Write a Review',
//               ),

//               content:
//                   SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize:
//                       MainAxisSize.min,
//                   children: [
//                     const Text(
//                       'How would you rate this product?',
//                     ),

//                     const SizedBox(
//                       height: 15,
//                     ),

//                     Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment
//                               .center,
//                       children: List.generate(
//                         5,
//                         (index) {
//                           final star =
//                               index + 1;

//                           return IconButton(
//                             onPressed: () {
//                               setDialogState(
//                                 () {
//                                   selectedRating =
//                                       star.toDouble();
//                                 },
//                               );
//                             },
//                             icon: Icon(
//                               star <=
//                                       selectedRating
//                                   ? Icons.star
//                                   : Icons
//                                       .star_border,
//                               color:
//                                   Colors.amber,
//                               size: 35,
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 10,
//                     ),

//                     TextField(
//                       controller:
//                           commentController,

//                       maxLines: 4,

//                       decoration:
//                           const InputDecoration(
//                         labelText:
//                             'Your Review',
//                         hintText:
//                             'Write your experience...',
//                         border:
//                             OutlineInputBorder(),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(
//                       dialogContext,
//                     );
//                   },
//                   child:
//                       const Text('Cancel'),
//                 ),

//                 ElevatedButton(
//                   onPressed: () async {
//                     final comment =
//                         commentController
//                             .text
//                             .trim();

//                     if (comment.isEmpty) {
//                       ScaffoldMessenger.of(
//                         context,
//                       ).showSnackBar(
//                         const SnackBar(
//                           content: Text(
//                             'Please write a review.',
//                           ),
//                         ),
//                       );
//                       return;
//                     }

//                     try {
//                       await context
//                           .read<
//                               ReviewProvider>()
//                           .addReview(
//                             productId:
//                                 widget.product
//                                     .id,
//                             rating:
//                                 selectedRating,
//                             comment:
//                                 comment,
//                           );

//                       if (!dialogContext
//                           .mounted) {
//                         return;
//                       }

//                       Navigator.pop(
//                         dialogContext,
//                       );

//                       ScaffoldMessenger.of(
//                         context,
//                       ).showSnackBar(
//                         const SnackBar(
//                           content: Text(
//                             'Review added successfully!',
//                           ),
//                           backgroundColor:
//                               Colors.green,
//                         ),
//                       );
//                     } catch (e) {
//                       if (!dialogContext
//                           .mounted) {
//                         return;
//                       }

//                       ScaffoldMessenger.of(
//                         context,
//                       ).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             'Error: $e',
//                           ),
//                         ),
//                       );
//                     }
//                   },
//                   child:
//                       const Text('Submit'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   // ==========================================
//   // STAR WIDGET
//   // ==========================================

//   Widget _stars(double rating) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: List.generate(
//         5,
//         (index) {
//           return Icon(
//             index < rating
//                 ? Icons.star
//                 : Icons.star_border,
//             color: Colors.amber,
//             size: 18,
//           );
//         },
//       ),
//     );
//   }

//   // ==========================================
//   // REVIEW CARD
//   // ==========================================

//   Widget _reviewCard(
//     ReviewModel review,
//   ) {
//     final currentUser =
//         FirebaseAuth.instance.currentUser;

//     final isOwner =
//         currentUser?.uid ==
//             review.userId;

//     return Container(
//       margin:
//           const EdgeInsets.only(
//         bottom: 12,
//       ),

//       padding:
//           const EdgeInsets.all(15),

//       decoration: BoxDecoration(
//         color:
//             Theme.of(context).cardColor,

//         borderRadius:
//             BorderRadius.circular(16),

//         border: Border.all(
//           color: Theme.of(context)
//               .dividerColor,
//         ),
//       ),

//       child: Column(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,

//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor:
//                     Colors.deepPurple
//                         .withOpacity(
//                   0.1,
//                 ),

//                 child: const Icon(
//                   Icons.person,
//                   color:
//                       Colors.deepPurple,
//                 ),
//               ),

//               const SizedBox(width: 10),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       review.userName,
//                       style:
//                           const TextStyle(
//                         fontWeight:
//                             FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(
//                       height: 3,
//                     ),

//                     _stars(
//                       review.rating,
//                     ),
//                   ],
//                 ),
//               ),

//               if (isOwner)
//                 PopupMenuButton(
//                   itemBuilder:
//                       (context) => [
//                     const PopupMenuItem(
//                       value: 'delete',
//                       child:
//                           Text('Delete'),
//                     ),
//                   ],

//                   onSelected:
//                       (value) async {
//                     if (value ==
//                         'delete') {
//                       await context
//                           .read<
//                               ReviewProvider>()
//                           .deleteReview(
//                             review.id,
//                             widget.product
//                                 .id,
//                           );
//                     }
//                   },
//                 ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           Text(
//             review.comment,
//             style: const TextStyle(
//               fontSize: 15,
//             ),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             review.date,
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey.shade600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ==========================================
//   // BUILD
//   // ==========================================

//   @override
//   Widget build(BuildContext context) {
//     final provider =
//         context.watch<ReviewProvider>();

//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.start,

//       children: [
//         const SizedBox(height: 20),

//         const Divider(),

//         const SizedBox(height: 20),

//         Row(
//           children: [
//             const Expanded(
//               child: Text(
//                 'Customer Reviews',
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight:
//                       FontWeight.bold,
//                 ),
//               ),
//             ),

//             ElevatedButton.icon(
//               onPressed:
//                   _showReviewDialog,

//               icon: const Icon(
//                 Icons.rate_review,
//                 size: 18,
//               ),

//               label: const Text(
//                 'Write Review',
//               ),
//             ),
//           ],
//         ),

//         const SizedBox(height: 20),

//         // ======================================
//         // RATING SUMMARY
//         // ======================================

//         Container(
//           padding:
//               const EdgeInsets.all(18),

//           decoration:
//               BoxDecoration(
//             color: Colors.deepPurple
//                 .withOpacity(0.08),

//             borderRadius:
//                 BorderRadius.circular(
//               16,
//             ),
//           ),

//           child: Row(
//             children: [
//               Column(
//                 children: [
//                   Text(
//                     provider
//                         .averageRating
//                         .toStringAsFixed(1),

//                     style:
//                         const TextStyle(
//                       fontSize: 40,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   _stars(
//                     provider.averageRating,
//                   ),

//                   const SizedBox(
//                     height: 5,
//                   ),

//                   Text(
//                     '${provider.totalReviews} Reviews',
//                     style: TextStyle(
//                       color: Colors
//                           .grey
//                           .shade600,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(width: 30),

//               const Expanded(
//                 child: Text(
//                   'Your feedback helps other customers make better decisions.',
//                   style: TextStyle(
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         const SizedBox(height: 20),

//         // ======================================
//         // REVIEWS
//         // ======================================

//         if (provider.isLoading)
//           const Center(
//             child:
//                 CircularProgressIndicator(),
//           )
//         else if (provider.reviews.isEmpty)
//           Center(
//             child: Padding(
//               padding:
//                   const EdgeInsets.all(30),
//               child: Column(
//                 children: [
//                   Icon(
//                     Icons.rate_review_outlined,
//                     size: 60,
//                     color:
//                         Colors.grey.shade400,
//                   ),

//                   const SizedBox(
//                     height: 10,
//                   ),

//                   const Text(
//                     'No reviews yet',
//                     style:
//                         TextStyle(
//                       fontSize: 18,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(
//                     height: 5,
//                   ),

//                   Text(
//                     'Be the first to review this product.',
//                     style: TextStyle(
//                       color: Colors
//                           .grey
//                           .shade600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         else
//           ...provider.reviews.map(
//             _reviewCard,
//           ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product_model.dart';
import '../models/review_model.dart';
import '../providers/review_provider.dart';
import '../providers/user_provider.dart';

class ReviewSection extends StatefulWidget {
  final ProductModel product;

  const ReviewSection({super.key, required this.product});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  final commentController = TextEditingController();

  double selectedRating = 5;

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

  // ==========================================
  // WRITE REVIEW
  // ==========================================

  void _showReviewDialog() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please login first.')));
      return;
    }

    selectedRating = 5;
    commentController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Write a Review'),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('How would you rate this product?'),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final star = index + 1;

                        return IconButton(
                          onPressed: () {
                            setDialogState(() {
                              selectedRating = star.toDouble();
                            });
                          },
                          icon: Icon(
                            star <= selectedRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 35,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: commentController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Your Review',
                        hintText: 'Write your experience...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () async {
                    final comment = commentController.text.trim();

                    if (comment.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please write a review.')),
                      );
                      return;
                    }

                    final currentUser = FirebaseAuth.instance.currentUser;

                    if (currentUser == null) {
                      return;
                    }

                    try {
                      final userProvider = context.read<UserProvider>();

                      await context.read<ReviewProvider>().addReview(
                        productId: widget.product.id,
                        userId: currentUser.uid,
                        userName: userProvider.user?.name ?? 'User',
                        userEmail: currentUser.email ?? '',
                        rating: selectedRating,
                        comment: comment,
                      );

                      if (!dialogContext.mounted) {
                        return;
                      }

                      Navigator.pop(dialogContext);

                      if (!mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Review added successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      if (!dialogContext.mounted) {
                        return;
                      }

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Error: $e')));
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==========================================
  // STARS
  // ==========================================

  Widget _stars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.round() ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }

  // ==========================================
  // REVIEW CARD
  // ==========================================

  Widget _reviewCard(ReviewModel review) {
    final currentUser = FirebaseAuth.instance.currentUser;

    final isOwner = currentUser?.uid == review.userId;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              CircleAvatar(
                child: Text(
                  review.userName.isNotEmpty
                      ? review.userName[0].toUpperCase()
                      : 'U',
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 3),

                    _stars(review.rating),
                  ],
                ),
              ),

              if (isOwner)
                PopupMenuButton<String>(
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],

                  onSelected: (value) async {
                    if (value == 'delete') {
                      await context.read<ReviewProvider>().deleteReview(
                        reviewId: review.id,
                        productId: widget.product.id,
                      );
                    }
                  },
                ),
            ],
          ),

          const SizedBox(height: 12),

          Text(review.comment, style: const TextStyle(fontSize: 15)),

          const SizedBox(height: 8),

          Text(
            review.date,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReviewProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SizedBox(height: 20),

        const Divider(),

        const SizedBox(height: 20),

        Row(
          children: [
            const Expanded(
              child: Text(
                'Customer Reviews',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            ElevatedButton.icon(
              onPressed: _showReviewDialog,

              icon: const Icon(Icons.rate_review, size: 18),

              label: const Text('Write Review'),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // RATING SUMMARY
        Container(
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.08),

            borderRadius: BorderRadius.circular(16),
          ),

          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    provider.averageRating.toStringAsFixed(1),

                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  _stars(provider.averageRating),

                  const SizedBox(height: 5),

                  Text(
                    '${provider.totalReviews} Reviews',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),

              const SizedBox(width: 30),

              const Expanded(
                child: Text(
                  'Your feedback helps other customers make better decisions.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // REVIEWS
        if (provider.isLoading)
          const Center(child: CircularProgressIndicator())
        else if (provider.reviews.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'No reviews yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Be the first to review this product.',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          )
        else
          ...provider.reviews.map(_reviewCard),
      ],
    );
  }
}
// 1111111122222222233333333333333333333333333
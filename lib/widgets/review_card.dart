// import 'package:flutter/material.dart';

// import '../models/review_model.dart';

// class ReviewCard extends StatelessWidget {
//   final ReviewModel review;
//   final bool isOwner;
//   final VoidCallback? onEdit;
//   final VoidCallback? onDelete;

//   const ReviewCard({
//     super.key,
//     required this.review,
//     required this.isOwner,
//     this.onEdit,
//     this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.only(
//         bottom: 12,
//       ),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius:
//             BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding:
//             const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   child: Text(
//                     review.userName
//                         .isNotEmpty
//                         ? review.userName[0]
//                             .toUpperCase()
//                         : "U",
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         review.userName,
//                         style:
//                             const TextStyle(
//                           fontWeight:
//                               FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),

//                       Text(
//                         review.userEmail,
//                         style:
//                             TextStyle(
//                           color: Colors
//                               .grey.shade600,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 if (isOwner)
//                   PopupMenuButton<String>(
//                     onSelected: (value) {
//                       if (value == "edit") {
//                         onEdit?.call();
//                       }

//                       if (value == "delete") {
//                         onDelete?.call();
//                       }
//                     },
//                     itemBuilder:
//                         (context) => const [
//                       PopupMenuItem(
//                         value: "edit",
//                         child:
//                             Text("Edit"),
//                       ),
//                       PopupMenuItem(
//                         value: "delete",
//                         child:
//                             Text("Delete"),
//                       ),
//                     ],
//                   ),
//               ],
//             ),

//             const SizedBox(height: 10),

//             Row(
//               children: List.generate(
//                 5,
//                 (index) {
//                   return Icon(
//                     index <
//                             review.rating
//                                 .round()
//                         ? Icons.star
//                         : Icons.star_border,
//                     color: Colors.amber,
//                     size: 20,
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 8),

//             Text(
//               review.comment,
//               style:
//                   const TextStyle(
//                 fontSize: 15,
//               ),
//             ),

//             const SizedBox(height: 8),

//             Text(
//               review.date,
//               style: TextStyle(
//                 color:
//                     Colors.grey.shade600,
//                 fontSize: 12,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../models/review_model.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;
  final bool isOwner;
  final VoidCallback? onDelete;

  const ReviewCard({
    super.key,
    required this.review,
    required this.isOwner,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15),
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // ==================================
            // USER INFORMATION
            // ==================================

            Row(
              children: [
                CircleAvatar(
                  child: Text(
                    review.userName.isNotEmpty
                        ? review.userName[0]
                            .toUpperCase()
                        : "U",
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        review.userName,
                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        review.userEmail,
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // ==================================
                // DELETE BUTTON
                // ==================================

                if (isOwner)
                  PopupMenuButton<String>(
                    onSelected:
                        (value) {
                      if (value ==
                          "delete") {
                        onDelete?.call();
                      }
                    },
                    itemBuilder:
                        (context) =>
                            const [
                      PopupMenuItem(
                        value:
                            "delete",
                        child:
                            Text(
                          "Delete",
                        ),
                      ),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 10),

            // ==================================
            // STAR RATING
            // ==================================

            Row(
              children:
                  List.generate(
                5,
                (index) {
                  return Icon(
                    index <
                            review.rating
                                .round()
                        ? Icons.star
                        : Icons.star_border,
                    color:
                        Colors.amber,
                    size: 20,
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // ==================================
            // COMMENT
            // ==================================

            Text(
              review.comment,
              style:
                  const TextStyle(
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            // ==================================
            // DATE
            // ==================================

            Text(
              review.date,
              style: TextStyle(
                color:
                    Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
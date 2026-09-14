



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// import '../models/review_model.dart';

// class ReviewProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore =
//       FirebaseFirestore.instance;

//   List<ReviewModel> reviews = [];

//   bool isLoading = false;

//   // ==========================================
//   // FETCH REVIEWS
//   // ==========================================

//   Future<void> fetchReviews(
//     String productId,
//   ) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final snapshot = await _firestore
//           .collection('reviews')
//           .where(
//             'productId',
//             isEqualTo: productId,
//           )
//           .get();

//       reviews = snapshot.docs.map((doc) {
//         return ReviewModel.fromMap(
//           doc.data(),
//           doc.id,
//         );
//       }).toList();

//       // Newest reviews first
//       reviews.sort(
//         (a, b) => b.date.compareTo(a.date),
//       );
//     } catch (e) {
//       debugPrint(
//         'Fetch Reviews Error: $e',
//       );
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   // ==========================================
//   // ADD REVIEW
//   // ==========================================

//   // Future<void> addReview({
//   //   required String productId,
//   //   required double rating,
//   //   required String comment,
//   // }) async {
//   //   final user =
//   //       FirebaseAuth.instance.currentUser;

//   //   if (user == null) {
//   //     throw Exception(
//   //       'User is not logged in',
//   //     );
//   //   }

//   //   final review = {
//   //     'productId': productId,
//   //     'userId': user.uid,
//   //     'userName':
//   //         user.displayName?.isNotEmpty == true
//   //             ? user.displayName
//   //             : 'User',
//   //     'userEmail':
//   //         user.email ?? '',
//   //     'rating': rating,
//   //     'comment': comment,
//   //     'date':
//   //         DateTime.now().toIso8601String(),
//   //   };

//   //   await _firestore
//   //       .collection('reviews')
//   //       .add(review);

//   //   await fetchReviews(productId);
//   // }

// Future<void> addReview({
//   required String productId,
//   required String userId,
//   required String userName,
//   required String userEmail,
//   required double rating,
//   required String comment,
// }) async {
//   final review = {
//     'productId': productId,
//     'userId': userId,
//     'userName': userName,
//     'userEmail': userEmail,
//     'rating': rating,
//     'comment': comment,
//     'date': DateTime.now().toIso8601String(),
//   };

//   await _firestore
//       .collection('reviews')
//       .add(review);

//   await fetchReviews(productId);
// }


//   // ==========================================
//   // DELETE REVIEW
//   // ==========================================

//   Future<void> deleteReview(
//     String reviewId,
//     String productId,
//   ) async {
//     await _firestore
//         .collection('reviews')
//         .doc(reviewId)
//         .delete();

//     await fetchReviews(productId);
//   }

//   // ==========================================
//   // AVERAGE RATING
//   // ==========================================

//   double get averageRating {
//     if (reviews.isEmpty) {
//       return 0;
//     }

//     double total = 0;

//     for (final review in reviews) {
//       total += review.rating;
//     }

//     return total / reviews.length;
//   }

//   // ==========================================
//   // TOTAL REVIEWS
//   // ==========================================

//   int get totalReviews {
//     return reviews.length;
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/review_model.dart';

class ReviewProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  List<ReviewModel> reviews = [];

  bool isLoading = false;

  // ==========================================
  // FETCH REVIEWS
  // ==========================================

  Future<void> fetchReviews(String productId) async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('reviews')
          .where(
            'productId',
            isEqualTo: productId,
          )
          .get();

      reviews = snapshot.docs.map((doc) {
        return ReviewModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();

      // Newest reviews first
      reviews.sort(
        (a, b) => b.date.compareTo(a.date),
      );
    } catch (e) {
      debugPrint(
        'Fetch Reviews Error: $e',
      );
    }

    isLoading = false;
    notifyListeners();
  }

  // ==========================================
  // ADD REVIEW
  // ==========================================

  Future<void> addReview({
    required String productId,
    required String userId,
    required String userName,
    required String userEmail,
    required double rating,
    required String comment,
  }) async {
    try {
      final review = {
        'productId': productId,
        'userId': userId,
        'userName': userName,
        'userEmail': userEmail,
        'rating': rating,
        'comment': comment,
        'date': DateTime.now().toIso8601String(),
      };

      await _firestore
          .collection('reviews')
          .add(review);

      await fetchReviews(productId);
    } catch (e) {
      debugPrint(
        'Add Review Error: $e',
      );

      rethrow;
    }
  }

  // ==========================================
  // DELETE REVIEW
  // ==========================================

  Future<void> deleteReview({
    required String reviewId,
    required String productId,
  }) async {
    try {
      await _firestore
          .collection('reviews')
          .doc(reviewId)
          .delete();

      await fetchReviews(productId);
    } catch (e) {
      debugPrint(
        'Delete Review Error: $e',
      );

      rethrow;
    }
  }

  // ==========================================
  // AVERAGE RATING
  // ==========================================

  double get averageRating {
    if (reviews.isEmpty) {
      return 0;
    }

    double total = 0;

    for (final review in reviews) {
      total += review.rating;
    }

    return total / reviews.length;
  }

  // ==========================================
  // TOTAL REVIEWS
  // ==========================================

  int get totalReviews {
    return reviews.length;
  }
}
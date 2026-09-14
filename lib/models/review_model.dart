// class ReviewModel {
//   final String id;
//   final String productId;
//   final String userId;
//   final String userName;
//   final String userEmail;
//   final double rating;
//   final String comment;
//   final String date;

//   ReviewModel({
//     required this.id,
//     required this.productId,
//     required this.userId,
//     required this.userName,
//     required this.userEmail,
//     required this.rating,
//     required this.comment,
//     required this.date,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'productId': productId,
//       'userId': userId,
//       'userName': userName,
//       'userEmail': userEmail,
//       'rating': rating,
//       'comment': comment,
//       'date': date,
//     };
//   }

//   factory ReviewModel.fromMap(
//     Map<String, dynamic> map,
//     String id,
//   ) {
//     return ReviewModel(
//       id: id,
//       productId: map['productId'] ?? '',
//       userId: map['userId'] ?? '',
//       userName: map['userName'] ?? 'User',
//       userEmail: map['userEmail'] ?? '',
//       rating: (map['rating'] ?? 0).toDouble(),
//       comment: map['comment'] ?? '',
//       date: map['date'] ?? '',
//     );
//   }
// }


class ReviewModel {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String userEmail;
  final double rating;
  final String comment;
  final String date;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.rating,
    required this.comment,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'rating': rating,
      'comment': comment,
      'date': date,
    };
  }

  factory ReviewModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return ReviewModel(
      id: id,
      productId:
          map['productId'] ?? '',
      userId:
          map['userId'] ?? '',
      userName:
          map['userName'] ?? 'User',
      userEmail:
          map['userEmail'] ?? '',
      rating:
          (map['rating'] ?? 0).toDouble(),
      comment:
          map['comment'] ?? '',
      date:
          map['date'] ?? '',
    );
  }
}
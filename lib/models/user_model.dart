// class UserModel {
//   final String uid;
//   final String email;

//   UserModel({
//     required this.uid,
//     required this.email,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'email': email,
//     };
//   }

//   factory UserModel.fromMap(Map<String, dynamic> map) {
//     return UserModel(
//       uid: map['uid'],
//       email: map['email'],
//     );
//   }
// }

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
    };
  }

  factory UserModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      image: map['image'] ?? '',
    );
  }
}
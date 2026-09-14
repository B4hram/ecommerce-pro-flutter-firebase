import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  UserModel? user;

  Future<void> loadUser(
    String uid,
  ) async {
    final doc =
        await _firestore
            .collection('users')
            .doc(uid)
            .get();

    if (doc.exists) {
      user = UserModel.fromMap(
        doc.data()!,
      );
      notifyListeners();
    }
  }

  Future<void> saveUser({
    required String uid,
    required String name,
    required String email,
    required String image,
  }) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .set({
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
    });

    await loadUser(uid);
  }
}
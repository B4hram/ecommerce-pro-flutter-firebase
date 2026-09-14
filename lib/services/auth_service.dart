// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   User? get currentUser => _auth.currentUser;

//   // REGISTER
//   Future<UserCredential> register({
//     required String email,
//     required String password,
//   }) async {
//     final userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );

//     await _firestore.collection("users").doc(userCredential.user!.uid).set({
//       "uid": userCredential.user!.uid,
//       "email": email,
//       "createdAt": DateTime.now(),
//     });

//     return userCredential;
//   }

//   // LOGIN
//   Future<UserCredential> login({
//     required String email,
//     required String password,
//   }) async {
//     return await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }

//   // LOGOUT
//   Future<void> logout() async {
//     await _auth.signOut();
//   }

//   // RESET PASSWORD
//   Future<void> resetPassword(String email) async {
//     await _auth.sendPasswordResetEmail(email: email);
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  // ==========================================
  // REGISTER
  // ==========================================

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    final userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user != null) {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'email': email,
        'role': 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return userCredential;
  }

  // ==========================================
  // LOGIN
  // ==========================================

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    final userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    return userCredential;
  }

  // ==========================================
  // LOGOUT
  // ==========================================

  Future<void> logout() async {
    await _auth.signOut();
  }

  // ==========================================
  // RESET PASSWORD
  // ==========================================

  Future<void> resetPassword(
    String email,
  ) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../services/auth_service.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthService _service = AuthService();

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   User? user;

//   bool isLoading = false;

//   // ==========================================
//   // USER ROLE
//   // ==========================================

//   String role = 'user';

//   // ==========================================
//   // LOGIN STATUS
//   // ==========================================

//   bool get isLoggedIn => user != null;

//   bool get isAdmin => role == 'admin';

//   bool get isUser => role == 'user';

//   // ==========================================
//   // CONSTRUCTOR
//   // ==========================================

//   AuthProvider() {
//     user = FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       _loadUserRole(user!.uid);
//     }
//   }

//   // ==========================================
//   // LOAD USER ROLE FROM FIRESTORE
//   // ==========================================

//   Future<void> _loadUserRole(String uid) async {
//     try {
//       final document = await _firestore.collection('users').doc(uid).get();

//       if (document.exists) {
//         final data = document.data();

//         role = data?['role']?.toString().toLowerCase() ?? 'user';
//       } else {
//         role = 'user';
//       }

//       notifyListeners();
//     } catch (e) {
//       debugPrint('Load User Role Error: $e');

//       // If there is an error, keep the account as a normal user.
//       role = 'user';

//       notifyListeners();
//     }
//   }

//   // ==========================================
//   // LOGIN
//   // ==========================================

//   Future<void> login(String email, String password) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final result = await _service.login(email: email, password: password);

//       user = result.user;

//       if (user != null) {
//         await _loadUserRole(user!.uid);
//       }
//     } catch (e) {
//       debugPrint('Login Error: $e');

//       rethrow;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // ==========================================
//   // REGISTER
//   // ==========================================

//   Future<void> register(String email, String password) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final result = await _service.register(email: email, password: password);

//       user = result.user;

//       // ========================================
//       // CREATE USER DOCUMENT
//       // ========================================

//       if (user != null) {
//         await _firestore.collection('users').doc(user!.uid).set({
//           'email': user!.email ?? email,
//           'name': 'User',
//           'role': 'user',
//         });

//         role = 'user';
//       }
//     } catch (e) {
//       debugPrint('Register Error: $e');

//       rethrow;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // ==========================================
//   // RESET PASSWORD
//   // ==========================================

//   Future<void> resetPassword(String email) async {
//     try {
//       isLoading = true;
//       notifyListeners();

//       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       debugPrint('Reset Password Error: $e');

//       rethrow;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   // ==========================================
//   // REFRESH USER
//   // ==========================================

//   Future<void> refreshUser() async {
//     final firebaseUser = FirebaseAuth.instance.currentUser;

//     if (firebaseUser != null) {
//       await firebaseUser.reload();

//       user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         await _loadUserRole(user!.uid);
//       }

//       notifyListeners();
//     }
//   }

//   // ==========================================
//   // LOGOUT
//   // ==========================================

//   Future<void> logout() async {
//     await _service.logout();

//     user = null;

//     role = 'user';

//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();

  User? user;

  bool isLoading = false;

  bool isAdmin = false;

  String userRole = 'user';

  bool get isLoggedIn => user != null;

  AuthProvider() {
    user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      loadUserRole();
    }
  }

  // ==========================================
  // LOGIN
  // ==========================================

  Future<void> login(
    String email,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.login(
        email: email,
        password: password,
      );

      user = result.user;

      if (user != null) {
        await loadUserRole();
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // REGISTER
  // ==========================================

  Future<void> register(
    String email,
    String password,
  ) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _service.register(
        email: email,
        password: password,
      );

      user = result.user;

      // --------------------------------------
      // EVERY NEW ACCOUNT IS A NORMAL USER
      // --------------------------------------

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .set({
          'email': user!.email,
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp(),
        });

        userRole = 'user';
        isAdmin = false;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // LOAD USER ROLE FROM FIRESTORE
  // ==========================================

  Future<void> loadUserRole() async {
    final firebaseUser =
        FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) {
      user = null;
      userRole = 'user';
      isAdmin = false;
      notifyListeners();
      return;
    }

    user = firebaseUser;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (doc.exists) {
        final data = doc.data();

        userRole =
            data?['role']?.toString().toLowerCase() ??
                'user';

        isAdmin = userRole == 'admin';
      } else {
        // If user document doesn't exist,
        // treat the account as a normal user.
        userRole = 'user';
        isAdmin = false;
      }
    } catch (e) {
      debugPrint(
        'Load user role error: $e',
      );

      userRole = 'user';
      isAdmin = false;
    }

    notifyListeners();
  }

  // ==========================================
  // RESET PASSWORD
  // ==========================================

  Future<void> resetPassword(
    String email,
  ) async {
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      );
    } catch (e) {
      debugPrint(
        'Reset Password Error: $e',
      );

      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ==========================================
  // REFRESH USER
  // ==========================================

  Future<void> refreshUser() async {
    final firebaseUser =
        FirebaseAuth.instance.currentUser;

    if (firebaseUser != null) {
      await firebaseUser.reload();

      user =
          FirebaseAuth.instance.currentUser;

      await loadUserRole();

      notifyListeners();
    }
  }

  // ==========================================
  // LOGOUT
  // ==========================================

  Future<void> logout() async {
    await _service.logout();

    user = null;
    userRole = 'user';
    isAdmin = false;

    notifyListeners();
  }
}
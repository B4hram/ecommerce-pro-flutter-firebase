

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../models/order_model.dart';

// class OrderProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore =
//       FirebaseFirestore.instance;

//   List<OrderModel> orders = [];

//   bool isLoading = false;

//   // ==========================================
//   // PLACE ORDER
//   // ==========================================

//   Future<String?> placeOrder({
//     required String userId,
//     required double total,
//     required String address,
//     required String paymentMethod,
//     required List<Map<String, dynamic>> items,
//   }) async {
//     try {
//       final docRef =
//           await _firestore.collection('orders').add({
//         'userId': userId,
//         'total': total,
//         'address': address,
//         'paymentMethod': paymentMethod,
//         'items': items,
//         'status': 'Pending',
//         'date': DateTime.now().toIso8601String(),
//       });

//       await fetchOrders(userId);

//       return docRef.id;
//     } catch (e) {
//       debugPrint('Place Order Error: $e');
//       return null;
//     }
//   }

//   // ==========================================
//   // FETCH USER ORDERS
//   // ==========================================

//   Future<void> fetchOrders(String userId) async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final snapshot = await _firestore
//           .collection('orders')
//           .where(
//             'userId',
//             isEqualTo: userId,
//           )
//           .get();

//       orders = snapshot.docs.map((doc) {
//         return OrderModel.fromMap(
//           doc.data(),
//           doc.id,
//         );
//       }).toList();

//       orders.sort(
//         (a, b) => b.date.compareTo(a.date),
//       );
//     } catch (e) {
//       debugPrint('Fetch Orders Error: $e');
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   // ==========================================
//   // FETCH ALL ORDERS - ADMIN
//   // ==========================================

//   Future<void> fetchAllOrders() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final snapshot = await _firestore
//           .collection('orders')
//           .get();

//       orders = snapshot.docs.map((doc) {
//         return OrderModel.fromMap(
//           doc.data(),
//           doc.id,
//         );
//       }).toList();

//       orders.sort(
//         (a, b) => b.date.compareTo(a.date),
//       );
//     } catch (e) {
//       debugPrint(
//         'Fetch All Orders Error: $e',
//       );
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   // ==========================================
//   // UPDATE ORDER STATUS
//   // ==========================================

//   Future<void> updateOrderStatus({
//     required String orderId,
//     required String status,
//   }) async {
//     try {
//       await _firestore
//           .collection('orders')
//           .doc(orderId)
//           .update({
//         'status': status,
//       });

//       final index = orders.indexWhere(
//         (order) => order.id == orderId,
//       );

//       if (index != -1) {
//         final oldOrder = orders[index];

//         orders[index] = OrderModel(
//           id: oldOrder.id,
//           userId: oldOrder.userId,
//           total: oldOrder.total,
//           date: oldOrder.date,
//           address: oldOrder.address,
//           paymentMethod: oldOrder.paymentMethod,
//           items: oldOrder.items,
//           status: status,
//         );
//       }

//       notifyListeners();
//     } catch (e) {
//       debugPrint(
//         'Update Order Status Error: $e',
//       );

//       rethrow;
//     }
//   }

//   // ==========================================
//   // DELETE ORDER
//   // ==========================================

//   Future<void> deleteOrder(
//     String orderId,
//   ) async {
//     try {
//       await _firestore
//           .collection('orders')
//           .doc(orderId)
//           .delete();

//       orders.removeWhere(
//         (order) => order.id == orderId,
//       );

//       notifyListeners();
//     } catch (e) {
//       debugPrint(
//         'Delete Order Error: $e',
//       );

//       rethrow;
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/order_model.dart';

class OrderProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  List<OrderModel> orders = [];

  bool isLoading = false;

  // ==========================================
  // PLACE ORDER
  // ==========================================

  Future<void> placeOrder({
    required String userId,
    required double total,
    required String address,
    required String paymentMethod,
    required List<Map<String, dynamic>> items,
  }) async {
    await _firestore.collection('orders').add({
      'userId': userId,
      'total': total,
      'address': address,
      'paymentMethod': paymentMethod,
      'items': items,
      'status': 'Pending',
      'date': DateTime.now().toIso8601String(),
    });

    await fetchOrders(userId);
  }

  // ==========================================
  // FETCH USER ORDERS
  // ==========================================

  Future<void> fetchOrders(String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('orders')
          .where(
            'userId',
            isEqualTo: userId,
          )
          .get();

      orders = snapshot.docs.map((doc) {
        return OrderModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();

      orders.sort(
        (a, b) => b.date.compareTo(a.date),
      );
    } catch (e) {
      debugPrint(
        'Fetch Orders Error: $e',
      );
    }

    isLoading = false;
    notifyListeners();
  }

  // ==========================================
  // FETCH ALL ORDERS
  // ADMIN
  // ==========================================

  Future<void> fetchAllOrders() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _firestore
          .collection('orders')
          .get();

      orders = snapshot.docs.map((doc) {
        return OrderModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();

      orders.sort(
        (a, b) => b.date.compareTo(a.date),
      );
    } catch (e) {
      debugPrint(
        'Fetch All Orders Error: $e',
      );
    }

    isLoading = false;
    notifyListeners();
  }

  // ==========================================
  // UPDATE ORDER STATUS
  // ==========================================

  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
  }) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .update({
        'status': status,
      });

      final index = orders.indexWhere(
        (order) => order.id == orderId,
      );

      if (index != -1) {
        final oldOrder = orders[index];

        orders[index] = OrderModel(
          id: oldOrder.id,
          userId: oldOrder.userId,
          total: oldOrder.total,
          date: oldOrder.date,
          address: oldOrder.address,
          paymentMethod:
              oldOrder.paymentMethod,
          items: oldOrder.items,
          status: status,
        );
      }

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Update Order Status Error: $e',
      );

      rethrow;
    }
  }

  // ==========================================
  // DELETE ORDER
  // ==========================================

  Future<void> deleteOrder(
    String orderId,
  ) async {
    try {
      await _firestore
          .collection('orders')
          .doc(orderId)
          .delete();

      orders.removeWhere(
        (order) => order.id == orderId,
      );

      notifyListeners();
    } catch (e) {
      debugPrint(
        'Delete Order Error: $e',
      );

      rethrow;
    }
  }
}


// class OrderModel {
//   final String id;
//   final String userId;
//   final double total;
//   final String date;
//   final String address;
//   final String paymentMethod;
//   final List<dynamic> items;
//   final String status;

//   OrderModel({
//     required this.id,
//     required this.userId,
//     required this.total,
//     required this.date,
//     required this.address,
//     required this.paymentMethod,
//     required this.items,
//     required this.status,
//   });

//   factory OrderModel.fromMap(
//     Map<String, dynamic> map,
//     String id,
//   ) {
//     return OrderModel(
//       id: id,
//       userId: map['userId'] ?? '',
//       total: (map['total'] as num?)?.toDouble() ?? 0.0,
//       date: map['date'] ?? '',
//       address: map['address'] ?? '',
//       paymentMethod: map['paymentMethod'] ?? '',
//       items: map['items'] is List
//           ? List<dynamic>.from(map['items'])
//           : [],
//       status: map['status'] ?? 'Pending',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'total': total,
//       'date': date,
//       'address': address,
//       'paymentMethod': paymentMethod,
//       'items': items,
//       'status': status,
//     };
//   }
// }



class OrderModel {
  final String id;
  final String userId;
  final double total;
  final String date;
  final String address;
  final String paymentMethod;
  final List<dynamic> items;
  final String status;

  OrderModel({
    required this.id,
    required this.userId,
    required this.total,
    required this.date,
    required this.address,
    required this.paymentMethod,
    required this.items,
    required this.status,
  });

  factory OrderModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return OrderModel(
      id: id,
      userId: map['userId'] ?? '',
      total: (map['total'] ?? 0).toDouble(),
      date: map['date'] ?? '',
      address: map['address'] ?? '',
      paymentMethod:
          map['paymentMethod'] ?? 'Cash on Delivery',
      items: List<dynamic>.from(
        map['items'] ?? [],
      ),
      status: map['status'] ?? 'Pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'total': total,
      'date': date,
      'address': address,
      'paymentMethod': paymentMethod,
      'items': items,
      'status': status,
    };
  }
}
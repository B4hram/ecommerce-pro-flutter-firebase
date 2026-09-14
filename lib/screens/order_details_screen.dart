


// import 'package:flutter/material.dart';

// import '../models/order_model.dart';

// class OrderDetailsScreen
//     extends StatelessWidget {
//   final OrderModel order;

//   const OrderDetailsScreen({
//     super.key,
//     required this.order,
//   });

//   Color _statusColor(String status) {
//     switch (status) {
//       case 'Delivered':
//         return Colors.green;

//       case 'Shipped':
//         return Colors.blue;

//       case 'Processing':
//         return Colors.orange;

//       case 'Cancelled':
//         return Colors.red;

//       default:
//         return Colors.grey;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text('Order Details'),
//       ),
//       body: ListView(
//         padding:
//             const EdgeInsets.all(16),
//         children: [
//           Card(
//             child: Padding(
//               padding:
//                   const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Order Status',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 10),

//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 8,
//                     ),
//                     decoration:
//                         BoxDecoration(
//                       color: _statusColor(
//                         order.status,
//                       ).withOpacity(0.12),
//                       borderRadius:
//                           BorderRadius.circular(
//                         20,
//                       ),
//                     ),
//                     child: Text(
//                       order.status,
//                       style: TextStyle(
//                         color:
//                             _statusColor(
//                           order.status,
//                         ),
//                         fontWeight:
//                             FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 15),

//           Card(
//             child: Padding(
//               padding:
//                   const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Shipping Information',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   ListTile(
//                     contentPadding:
//                         EdgeInsets.zero,
//                     leading: const Icon(
//                       Icons.location_on,
//                     ),
//                     title:
//                         const Text('Address'),
//                     subtitle:
//                         Text(order.address),
//                   ),

//                   ListTile(
//                     contentPadding:
//                         EdgeInsets.zero,
//                     leading: const Icon(
//                       Icons.payment,
//                     ),
//                     title:
//                         const Text('Payment'),
//                     subtitle: Text(
//                       order.paymentMethod,
//                     ),
//                   ),

//                   ListTile(
//                     contentPadding:
//                         EdgeInsets.zero,
//                     leading: const Icon(
//                       Icons.calendar_today,
//                     ),
//                     title:
//                         const Text('Order Date'),
//                     subtitle:
//                         Text(order.date),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 15),

//           const Text(
//             'Products',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight:
//                   FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 10),

//           ...order.items.map(
//             (item) {
//               return Card(
//                 child: ListTile(
//                   title: Text(
//                     item['name'] ??
//                         'Product',
//                   ),
//                   subtitle: Text(
//                     'Quantity: ${item['quantity'] ?? 1}',
//                   ),
//                   trailing: Text(
//                     '\$${item['price'] ?? 0}',
//                     style:
//                         const TextStyle(
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),

//           const SizedBox(height: 15),

//           Card(
//             child: Padding(
//               padding:
//                   const EdgeInsets.all(18),
//               child: Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment
//                         .spaceBetween,
//                 children: [
//                   const Text(
//                     'Total',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight:
//                           FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '\$${order.total.toStringAsFixed(2)}',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight:
//                           FontWeight.bold,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../models/order_model.dart';

import 'order_tracking_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;

      case 'processing':
        return Colors.blue;

      case 'shipped':
        return Colors.indigo;

      case 'delivered':
        return Colors.green;

      case 'cancelled':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.access_time;

      case 'processing':
        return Icons.autorenew;

      case 'shipped':
        return Icons.local_shipping;

      case 'delivered':
        return Icons.check_circle;

      case 'cancelled':
        return Icons.cancel;

      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor =
        _statusColor(order.status);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          // ==================================
          // ORDER HEADER
          // ==================================

          Card(
            elevation: 2,

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(18),
            ),

            child: Padding(
              padding:
                  const EdgeInsets.all(18),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Order Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton.icon(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              OrderTrackingScreen(
            order: order,
          ),
        ),
      );
    },
    icon: const Icon(
      Icons.local_shipping,
    ),
    label: const Text(
      'Track Order',
    ),
  ),
),

                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),

                        decoration:
                            BoxDecoration(
                          color: statusColor
                              .withOpacity(0.12),

                          borderRadius:
                              BorderRadius
                                  .circular(20),
                        ),

                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [
                            Icon(
                              _statusIcon(
                                order.status,
                              ),
                              size: 16,
                              color:
                                  statusColor,
                            ),

                            const SizedBox(
                              width: 5,
                            ),

                            Text(
                              order.status,
                              style: TextStyle(
                                color:
                                    statusColor,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  _infoRow(
                    Icons.receipt_long,
                    'Order ID',
                    order.id,
                  ),

                  const SizedBox(height: 12),

                  _infoRow(
                    Icons.calendar_today,
                    'Date',
                    _formatDate(order.date),
                  ),

                  const SizedBox(height: 12),

                  _infoRow(
                    Icons.location_on,
                    'Shipping Address',
                    order.address,
                  ),

                  const SizedBox(height: 12),

                  _infoRow(
                    order.paymentMethod ==
                            'Cash on Delivery'
                        ? Icons.money
                        : Icons.credit_card,
                    'Payment Method',
                    order.paymentMethod,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ==================================
          // PRODUCTS
          // ==================================

          const Text(
            'Ordered Products',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...order.items.map(
            (item) {
              final name =
                  item['name']?.toString() ??
                      'Product';

              final price =
                  (item['price'] as num?)
                          ?.toDouble() ??
                      0;

              final quantity =
                  (item['quantity'] as num?)
                          ?.toInt() ??
                      1;

              final subtotal =
                  price * quantity;

              return Card(
                margin:
                    const EdgeInsets.only(
                  bottom: 12,
                ),

                child: Padding(
                  padding:
                      const EdgeInsets.all(15),

                  child: Row(
                    children: [
                      Container(
                        width: 55,
                        height: 55,

                        decoration:
                            BoxDecoration(
                          color: Colors
                              .deepPurple
                              .withOpacity(0.1),

                          borderRadius:
                              BorderRadius
                                  .circular(14),
                        ),

                        child: const Icon(
                          Icons.shopping_bag,
                          color:
                              Colors.deepPurple,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Text(
                              name,

                              maxLines: 2,

                              overflow:
                                  TextOverflow
                                      .ellipsis,

                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(
                              height: 6,
                            ),

                            Text(
                              '\$${price.toStringAsFixed(2)} × $quantity',
                              style: TextStyle(
                                color: Colors
                                    .grey
                                    .shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(
                        '\$${subtotal.toStringAsFixed(2)}',

                        style:
                            const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          // ==================================
          // TOTAL
          // ==================================

          Card(
            child: Padding(
              padding:
                  const EdgeInsets.all(18),

              child: Row(
                children: [
                  const Text(
                    'Total',

                    style: TextStyle(
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '\$${order.total.toStringAsFixed(2)}',

                    style:
                        const TextStyle(
                      fontSize: 23,
                      fontWeight:
                          FontWeight.bold,
                      color:
                          Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String title,
    String value,
  ) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        Icon(
          icon,
          size: 21,
          color: Colors.deepPurple,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                title,

                style: TextStyle(
                  fontSize: 12,
                  color:
                      Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,

                style: const TextStyle(
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      final parsed =
          DateTime.parse(date);

      return '${parsed.day.toString().padLeft(2, '0')}/'
          '${parsed.month.toString().padLeft(2, '0')}/'
          '${parsed.year} '
          '${parsed.hour.toString().padLeft(2, '0')}:'
          '${parsed.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return date;
    }
  }
}
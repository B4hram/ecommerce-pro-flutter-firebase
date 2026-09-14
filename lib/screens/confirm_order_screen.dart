
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../providers/cart_provider.dart';
// import '../providers/order_provider.dart';

// import 'order_success_screen.dart';

// class ConfirmOrderScreen extends StatefulWidget {
//   final String address;
//   final String paymentMethod;

//   const ConfirmOrderScreen({
//     super.key,
//     required this.address,
//     required this.paymentMethod,
//   });

//   @override
//   State<ConfirmOrderScreen> createState() =>
//       _ConfirmOrderScreenState();
// }

// class _ConfirmOrderScreenState
//     extends State<ConfirmOrderScreen> {
//   bool _isPlacingOrder = false;

//   Future<void> _placeOrder() async {
//     final cart = context.read<CartProvider>();

//     final user =
//         FirebaseAuth.instance.currentUser;

//     // Check login
//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Please login before placing an order.',
//           ),
//         ),
//       );
//       return;
//     }

//     // Check cart
//     if (cart.items.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Your cart is empty.',
//           ),
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _isPlacingOrder = true;
//     });

//     // Save cart products
//     final items = cart.items.map((item) {
//       return {
//         'name': item.product.name,
//         'price': item.product.price,
//         'quantity': item.quantity,
//       };
//     }).toList();

//     // IMPORTANT:
//     // Save total BEFORE clearing the cart.
//     final orderTotal = cart.totalPrice;

//     // Save order to Firebase
//     final orderId =
//         await context
//             .read<OrderProvider>()
//             .placeOrder(
//               userId: user.uid,
//               total: orderTotal,
//               address: widget.address,
//               paymentMethod:
//                   widget.paymentMethod,
//               items: items,
//             );

//     if (!mounted) return;

//     setState(() {
//       _isPlacingOrder = false;
//     });

//     // If Firebase failed
//     if (orderId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Failed to place order. Please try again.',
//           ),
//         ),
//       );
//       return;
//     }

//     // Clear cart after successful order
//     cart.clearCart();

//     // Go to success screen
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (_) => OrderSuccessScreen(
//           orderId: orderId,
//           total: orderTotal,
//         ),
//       ),
//       (route) => route.isFirst,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = context.watch<CartProvider>();

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,

//       appBar: AppBar(
//         title: const Text(
//           'Confirm Order',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // =====================================
//           // SHIPPING ADDRESS
//           // =====================================

//           _infoCard(
//             icon: Icons.location_on,
//             title: 'Shipping Address',
//             value: widget.address,
//           ),

//           const SizedBox(height: 15),

//           // =====================================
//           // PAYMENT METHOD
//           // =====================================

//           _infoCard(
//             icon: Icons.payment,
//             title: 'Payment Method',
//             value: widget.paymentMethod,
//           ),

//           const SizedBox(height: 20),

//           // =====================================
//           // PRODUCTS
//           // =====================================

//           Container(
//             padding: const EdgeInsets.all(18),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(18),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.04),
//                   blurRadius: 8,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Products',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 15),

//                 ...cart.items.map((item) {
//                   return Padding(
//                     padding:
//                         const EdgeInsets.only(
//                       bottom: 14,
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 50,
//                           height: 50,
//                           decoration: BoxDecoration(
//                             color: Colors.deepPurple
//                                 .withOpacity(0.1),
//                             borderRadius:
//                                 BorderRadius.circular(
//                               12,
//                             ),
//                           ),
//                           child: const Icon(
//                             Icons.shopping_bag,
//                             color: Colors.deepPurple,
//                           ),
//                         ),

//                         const SizedBox(width: 12),

//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.product.name,
//                                 maxLines: 2,
//                                 overflow:
//                                     TextOverflow.ellipsis,
//                                 style: const TextStyle(
//                                   fontWeight:
//                                       FontWeight.bold,
//                                   fontSize: 15,
//                                 ),
//                               ),

//                               const SizedBox(height: 5),

//                               Text(
//                                 'Quantity: ${item.quantity}',
//                                 style: TextStyle(
//                                   color:
//                                       Colors.grey.shade600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         Text(
//                           '\$${item.subtotal.toStringAsFixed(2)}',
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),

//                 const Divider(),

//                 const SizedBox(height: 10),

//                 // TOTAL
//                 Row(
//                   children: [
//                     const Text(
//                       'Total',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const Spacer(),

//                     Text(
//                       '\$${cart.totalPrice.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         fontSize: 23,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.deepPurple,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 25),

//           // =====================================
//           // PLACE ORDER BUTTON
//           // =====================================

//           SizedBox(
//             height: 55,
//             child: ElevatedButton(
//               onPressed:
//                   _isPlacingOrder
//                       ? null
//                       : _placeOrder,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepPurple,
//                 disabledBackgroundColor:
//                     Colors.deepPurple.shade200,
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(15),
//                 ),
//               ),
//               child: _isPlacingOrder
//                   ? const SizedBox(
//                       width: 25,
//                       height: 25,
//                       child:
//                           CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 3,
//                       ),
//                     )
//                   : const Text(
//                       'Place Order',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//             ),
//           ),

//           const SizedBox(height: 15),

//           // Security/info text
//           Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.center,
//             children: [
//               Icon(
//                 Icons.lock_outline,
//                 size: 16,
//                 color: Colors.grey.shade600,
//               ),
//               const SizedBox(width: 5),
//               Text(
//                 'Your order information is secure',
//                 style: TextStyle(
//                   color: Colors.grey.shade600,
//                   fontSize: 13,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // ==========================================
//   // INFORMATION CARD
//   // ==========================================

//   Widget _infoCard({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius:
//             BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment:
//             CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 45,
//             height: 45,
//             decoration: BoxDecoration(
//               color: Colors.deepPurple
//                   .withOpacity(0.1),
//               borderRadius:
//                   BorderRadius.circular(12),
//             ),
//             child: Icon(
//               icon,
//               color: Colors.deepPurple,
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   value,
//                   style: TextStyle(
//                     color: Colors.grey.shade700,
//                     fontSize: 15,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'order_success_screen.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final String address;
  final String paymentMethod;

  const ConfirmOrderScreen({
    super.key,
    required this.address,
    required this.paymentMethod,
  });

  @override
  State<ConfirmOrderScreen> createState() =>
      _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState
    extends State<ConfirmOrderScreen> {
  bool isPlacingOrder = false;

  Future<void> placeOrder() async {
    final user =
        FirebaseAuth.instance.currentUser;

    final cart =
        context.read<CartProvider>();

    if (user == null) {
      showMessage(
        'Please login before placing an order.',
      );
      return;
    }

    if (cart.items.isEmpty) {
      showMessage(
        'Your cart is empty.',
      );
      return;
    }

    setState(() {
      isPlacingOrder = true;
    });

    try {
      final items = cart.items.map((item) {
        return {
          'name': item.product.name,
          'price': item.product.price,
          'quantity': item.quantity,
        };
      }).toList();

      final total = cart.totalPrice;

      await context
          .read<OrderProvider>()
          .placeOrder(
            userId: user.uid,
            total: total,
            address: widget.address,
            paymentMethod: widget.paymentMethod,
            items: items,
          );

      cart.clearCart();

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderSuccessScreen(
            total: total,
          ),
        ),
      );
    } catch (e) {
      showMessage(
        'Failed to place order: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          isPlacingOrder = false;
        });
      }
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart =
        context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Confirm Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          _infoCard(
            icon: Icons.location_on,
            title: 'Shipping Address',
            value: widget.address,
          ),

          const SizedBox(height: 15),

          _infoCard(
            icon: widget.paymentMethod ==
                    'Cash on Delivery'
                ? Icons.money
                : Icons.credit_card,

            title: 'Payment Method',

            value: widget.paymentMethod,
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,

              borderRadius:
                  BorderRadius.circular(18),

              boxShadow: [
                BoxShadow(
                  color: Colors.black
                      .withOpacity(0.05),

                  blurRadius: 8,

                  offset: const Offset(0, 3),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const Text(
                  'Products',

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                ...cart.items.map(
                  (item) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 14,
                      ),

                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,

                            decoration:
                                BoxDecoration(
                              color: Colors.deepPurple
                                  .withOpacity(0.1),

                              borderRadius:
                                  BorderRadius.circular(
                                12,
                              ),
                            ),

                            child: const Icon(
                              Icons.shopping_bag,
                              color:
                                  Colors.deepPurple,
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,

                              children: [
                                Text(
                                  item.product.name,

                                  maxLines: 2,

                                  overflow:
                                      TextOverflow.ellipsis,

                                  style:
                                      const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Text(
                                  'Quantity: ${item.quantity}',
                                ),
                              ],
                            ),
                          ),

                          Text(
                            '\$${item.subtotal.toStringAsFixed(2)}',

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const Divider(),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Text(
                      'Total',

                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '\$${cart.totalPrice.toStringAsFixed(2)}',

                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            height: 55,

            child: ElevatedButton(
              onPressed:
                  isPlacingOrder
                      ? null
                      : placeOrder,

              child:
                  isPlacingOrder
                      ? const SizedBox(
                          width: 25,
                          height: 25,

                          child:
                              CircularProgressIndicator(),
                        )
                      : const Text(
                          'Place Order',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),

        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            Icon(
              icon,
              color: Colors.deepPurple,
              size: 30,
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  Text(
                    title,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
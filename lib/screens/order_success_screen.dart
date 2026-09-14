// import 'package:flutter/material.dart';

// class OrderSuccessScreen extends StatelessWidget {
//   final double total;

//   const OrderSuccessScreen({
//     super.key,
//     required this.total,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(30),

//           child: Column(
//             mainAxisAlignment:
//                 MainAxisAlignment.center,

//             children: [
//               const Icon(
//                 Icons.check_circle,
//                 color: Colors.green,
//                 size: 100,
//               ),

//               const SizedBox(height: 25),

//               const Text(
//                 'Order Placed Successfully!',
//                 textAlign: TextAlign.center,

//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 15),

//               Text(
//                 'Total: \$${total.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 15),

//               const Text(
//                 'Thank you for shopping with E-Commerce Pro.',
//                 textAlign: TextAlign.center,
//               ),

//               const SizedBox(height: 35),

//               SizedBox(
//                 width: double.infinity,
//                 height: 55,

//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.popUntil(
//                       context,
//                       (route) => route.isFirst,
//                     );
//                   },

//                   child: const Text(
//                     'Continue Shopping',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  final double total;

  const OrderSuccessScreen({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Order Confirmation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          child: Column(
            children: [
              // ==========================================
              // SUCCESS ICON
              // ==========================================
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 58,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ==========================================
              // SUCCESS TITLE
              // ==========================================
              const Text(
                'Order Placed Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Text(
                'Thank you for your purchase!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.65),
                ),
              ),

              const SizedBox(height: 30),

              // ==========================================
              // ORDER SUMMARY CARD
              // ==========================================
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.10),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              Icons.receipt_long_rounded,
                              color: colorScheme.primary,
                            ),
                          ),

                          const SizedBox(width: 14),

                          const Expanded(
                            child: Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Divider(),

                      const SizedBox(height: 14),

                      // TOTAL
                      Row(
                        children: [
                          Text(
                            'Order Total',
                            style: TextStyle(
                              fontSize: 16,
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withOpacity(0.7),
                            ),
                          ),

                          const Spacer(),

                          Text(
                            '\$${total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // PAYMENT
                      Row(
                        children: [
                          Icon(
                            Icons.payment_rounded,
                            size: 20,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.65),
                          ),

                          const SizedBox(width: 10),

                          Text(
                            'Payment',
                            style: TextStyle(
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withOpacity(0.7),
                            ),
                          ),

                          const Spacer(),

                          const Text(
                            'Order Confirmed',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ==========================================
              // DELIVERY MESSAGE
              // ==========================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.15),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      color: colorScheme.primary,
                      size: 28,
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your order is being processed',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'You can check your order history '
                            'to view your order information.',
                            style: TextStyle(height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ==========================================
              // CONTINUE SHOPPING
              // ==========================================
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text(
                    'Continue Shopping',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ==========================================
              // ORDER HISTORY
              // ==========================================
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.receipt_long_outlined),
                  label: const Text(
                    'Back to Home',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ==========================================
              // FOOTER
              // ==========================================
              Text(
                'Thank you for shopping with E-Commerce Pro ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.55),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

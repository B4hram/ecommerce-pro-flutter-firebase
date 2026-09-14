// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../providers/cart_provider.dart';
// import 'confirm_order_screen.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   final addressController = TextEditingController();

//   final cardNumberController = TextEditingController();
//   final expiryController = TextEditingController();
//   final cvvController = TextEditingController();
//   final cardNameController = TextEditingController();

//   String paymentMethod = 'Cash on Delivery';

//   @override
//   void dispose() {
//     addressController.dispose();
//     cardNumberController.dispose();
//     expiryController.dispose();
//     cvvController.dispose();
//     cardNameController.dispose();

//     super.dispose();
//   }

//   void continueToConfirmation() {
//     final user = FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       _showMessage('Please login first.');
//       return;
//     }

//     final address = addressController.text.trim();

//     if (address.isEmpty) {
//       _showMessage('Please enter your shipping address.');
//       return;
//     }

//     if (paymentMethod == 'Card Payment') {
//       if (cardNameController.text.trim().isEmpty ||
//           cardNumberController.text.trim().isEmpty ||
//           expiryController.text.trim().isEmpty ||
//           cvvController.text.trim().isEmpty) {
//         _showMessage('Please fill all card fields.');
//         return;
//       }
//     }

//     final cart = context.read<CartProvider>();

//     if (cart.items.isEmpty) {
//       _showMessage('Your cart is empty.');
//       return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) =>
//             ConfirmOrderScreen(address: address, paymentMethod: paymentMethod),
//       ),
//     );
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cart = context.watch<CartProvider>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Checkout')),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             const Text(
//               'Shipping Address',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 12),

//             TextField(
//               controller: addressController,
//               maxLines: 3,

//               decoration: InputDecoration(
//                 hintText: 'Enter your full address',

//                 prefixIcon: const Icon(Icons.location_on),

//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             const Text(
//               'Payment Method',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 12),

//             _paymentTile(
//               title: 'Cash on Delivery',
//               subtitle: 'Pay when your order arrives',
//               icon: Icons.money,
//               value: 'Cash on Delivery',
//             ),

//             _paymentTile(
//               title: 'Card Payment',
//               subtitle: 'Pay using your debit or credit card',
//               icon: Icons.credit_card,
//               value: 'Card Payment',
//             ),

//             if (paymentMethod == 'Card Payment') _cardForm(),

//             const SizedBox(height: 30),

//             const Text(
//               'Order Summary',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 15),

//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),

//                 child: Column(
//                   children: [
//                     _summaryRow('Products', '${cart.items.length}'),

//                     const Divider(),

//                     _summaryRow(
//                       'Total',
//                       '\$${cart.totalPrice.toStringAsFixed(2)}',
//                       bold: true,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             SizedBox(
//               width: double.infinity,
//               height: 55,

//               child: ElevatedButton(
//                 onPressed: continueToConfirmation,

//                 child: const Text(
//                   'Continue to Confirm Order',
//                   style: TextStyle(fontSize: 17),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _paymentTile({
//     required String title,
//     required String subtitle,
//     required IconData icon,
//     required String value,
//   }) {
//     return Card(
//       child: RadioListTile<String>(
//         value: value,

//         groupValue: paymentMethod,

//         onChanged: (value) {
//           if (value == null) return;

//           setState(() {
//             paymentMethod = value;
//           });
//         },

//         secondary: Icon(icon, size: 30),

//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

//         subtitle: Text(subtitle),
//       ),
//     );
//   }

//   Widget _cardForm() {
//     return Card(
//       margin: const EdgeInsets.only(top: 10),

//       child: Padding(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           children: [
//             TextField(
//               controller: cardNameController,

//               decoration: const InputDecoration(
//                 labelText: 'Card Holder Name',
//                 prefixIcon: Icon(Icons.person),
//               ),
//             ),

//             const SizedBox(height: 12),

//             TextField(
//               controller: cardNumberController,

//               keyboardType: TextInputType.number,

//               decoration: const InputDecoration(
//                 labelText: 'Card Number',
//                 prefixIcon: Icon(Icons.credit_card),
//               ),
//             ),

//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: expiryController,

//                     decoration: const InputDecoration(labelText: 'MM/YY'),
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: TextField(
//                     controller: cvvController,

//                     obscureText: true,

//                     keyboardType: TextInputType.number,

//                     decoration: const InputDecoration(labelText: 'CVV'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _summaryRow(String title, String value, {bool bold = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,

//       children: [
//         Text(
//           title,

//           style: TextStyle(
//             fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),

//         Text(
//           value,

//           style: TextStyle(
//             fontWeight: bold ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController addressController = TextEditingController();

  String paymentMethod = 'Cash on Delivery';

  bool isPlacingOrder = false;

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  // ============================================================
  // PLACE ORDER
  // ============================================================

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login before placing an order.')),
      );
      return;
    }

    final cart = context.read<CartProvider>();

    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Your cart is empty.')));
      return;
    }

    setState(() {
      isPlacingOrder = true;
    });

    try {
      final items = cart.items.map((item) {
        return {
          'productId': item.product.id,
          'name': item.product.name,
          'image': item.product.image,
          'price': item.product.price,
          'quantity': item.quantity,
          'subtotal': item.subtotal,
        };
      }).toList();

      await context.read<OrderProvider>().placeOrder(
        userId: user.uid,
        total: cart.totalPrice,
        address: addressController.text.trim(),
        paymentMethod: paymentMethod,
        items: items,
      );

      cart.clearCart();

      if (!mounted) return;

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            contentPadding: const EdgeInsets.all(28),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 58,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Order Placed!',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Text(
                  'Your order has been placed successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text(
                      'Continue Shopping',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to place order: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isPlacingOrder = false;
        });
      }
    }
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: cart.items.isEmpty
          ? _buildEmptyCart(context)
          : Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
                      children: [
                        _buildProgressIndicator(),

                        const SizedBox(height: 25),

                        _buildSectionTitle(
                          icon: Icons.location_on_outlined,
                          title: 'Shipping Address',
                        ),

                        const SizedBox(height: 12),

                        _buildAddressCard(),

                        const SizedBox(height: 28),

                        _buildSectionTitle(
                          icon: Icons.payment_outlined,
                          title: 'Payment Method',
                        ),

                        const SizedBox(height: 12),

                        _buildPaymentCard(),

                        const SizedBox(height: 28),

                        _buildSectionTitle(
                          icon: Icons.shopping_bag_outlined,
                          title: 'Order Items',
                        ),

                        const SizedBox(height: 12),

                        _buildOrderItems(cart),

                        const SizedBox(height: 28),

                        _buildOrderSummary(cart),

                        const SizedBox(height: 20),

                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: colorScheme.primary.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.security_outlined,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Your order information is securely processed.',
                                  style: TextStyle(
                                    color: theme.textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  _buildBottomBar(cart),
                ],
              ),
            ),
    );
  }

  // ============================================================
  // PROGRESS
  // ============================================================

  Widget _buildProgressIndicator() {
    final primary = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        _progressStep(number: '1', title: 'Cart', active: true, color: primary),

        Expanded(child: Container(height: 2, color: primary)),

        _progressStep(
          number: '2',
          title: 'Checkout',
          active: true,
          color: primary,
        ),

        Expanded(
          child: Container(height: 2, color: Colors.grey.withOpacity(0.3)),
        ),

        _progressStep(
          number: '3',
          title: 'Complete',
          active: false,
          color: primary,
        ),
      ],
    );
  }

  Widget _progressStep({
    required String number,
    required String title,
    required bool active,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: active ? color : Colors.grey.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 5),

        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle({required IconData icon, required String title}) {
    final primary = Theme.of(context).colorScheme.primary;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(icon, color: primary, size: 21),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // ============================================================
  // ADDRESS
  // ============================================================

  Widget _buildAddressCard() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: addressController,
          maxLines: 4,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            hintText: 'Enter your complete shipping address',
            prefixIcon: const Padding(
              padding: EdgeInsets.only(bottom: 55),
              child: Icon(Icons.home_outlined),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your shipping address';
            }

            if (value.trim().length < 10) {
              return 'Please enter a complete address';
            }

            return null;
          },
        ),
      ),
    );
  }

  // ============================================================
  // PAYMENT
  // ============================================================

  Widget _buildPaymentCard() {
    final primary = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 1,
      child: Column(
        children: [
          RadioListTile<String>(
            value: 'Cash on Delivery',
            groupValue: paymentMethod,
            activeColor: primary,
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                paymentMethod = value;
              });
            },
            title: const Text(
              'Cash on Delivery',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Pay when your order arrives'),
            secondary: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.money, color: Colors.green),
            ),
          ),

          const Divider(height: 1, indent: 16, endIndent: 16),

          RadioListTile<String>(
            value: 'Online Payment',
            groupValue: paymentMethod,
            activeColor: primary,
            onChanged: (value) {
              if (value == null) return;

              setState(() {
                paymentMethod = value;
              });
            },
            title: const Text(
              'Online Payment',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Online payment integration'),
            secondary: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.credit_card, color: primary),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER ITEMS
  // ============================================================

  Widget _buildOrderItems(CartProvider cart) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ...cart.items.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        item.product.image,
                        width: 65,
                        height: 65,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 65,
                            height: 65,
                            color: Colors.grey.withOpacity(0.15),
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Qty: ${item.quantity}',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),

                    Text(
                      '\$${item.subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ORDER SUMMARY
  // ============================================================

  Widget _buildOrderSummary(CartProvider cart) {
    final primary = Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Order Summary',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 18),

            _summaryRow('Subtotal', '\$${cart.totalPrice.toStringAsFixed(2)}'),

            const SizedBox(height: 10),

            _summaryRow('Shipping', 'FREE', valueColor: Colors.green),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(),
            ),

            Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                Text(
                  '\$${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String title, String value, {Color? valueColor}) {
    return Row(
      children: [
        Text(title, style: TextStyle(color: Colors.grey.shade600)),

        const Spacer(),

        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.w600, color: valueColor),
        ),
      ],
    );
  }

  // ============================================================
  // BOTTOM BAR
  // ============================================================

  Widget _buildBottomBar(CartProvider cart) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),

                const SizedBox(height: 2),

                Text(
                  '\$${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 20),

            Expanded(
              child: SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: isPlacingOrder ? null : _placeOrder,
                  icon: isPlacingOrder
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.lock_outline),
                  label: Text(
                    isPlacingOrder ? 'Placing Order...' : 'Place Order',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY CART
  // ============================================================

  Widget _buildEmptyCart(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 65,
                color: primary,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Your Cart is Empty',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              'Add some products to your cart\nbefore checking out.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: 180,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Continue Shopping',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

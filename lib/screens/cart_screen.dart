// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/cart_provider.dart';
// import 'checkout_screen.dart';

// class CartScreen extends StatelessWidget {
//   const CartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cart = context.watch<CartProvider>();

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,

//       appBar: AppBar(
//         title: const Text(
//           'My Cart',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),

//       body: cart.items.isEmpty
//           ? _emptyCart()
//           : Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(16),
//                     itemCount: cart.items.length,
//                     itemBuilder: (context, index) {
//                       final item = cart.items[index];

//                       return _cartItem(context, cart, item, index);
//                     },
//                   ),
//                 ),

//                 _bottomSummary(context, cart),
//               ],
//             ),
//     );
//   }

//   Widget _cartItem(
//     BuildContext context,
//     CartProvider cart,
//     CartItem item,
//     int index,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 14),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Image.network(
//               item.product.image,
//               width: 85,
//               height: 85,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return Container(
//                   width: 85,
//                   height: 85,
//                   color: Colors.grey.shade200,
//                   child: const Icon(Icons.image_not_supported),
//                 );
//               },
//             ),
//           ),

//           const SizedBox(width: 12),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item.product.name,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 6),

//                 Text(
//                   '\$${item.product.price.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     color: Colors.green,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 10),

//                 Row(
//                   children: [
//                     _quantityButton(
//                       icon: Icons.remove,
//                       onPressed: () {
//                         cart.decreaseQuantity(index);
//                       },
//                     ),

//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: Text(
//                         item.quantity.toString(),
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),

//                     _quantityButton(
//                       icon: Icons.add,
//                       onPressed: () {
//                         cart.increaseQuantity(index);
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           Column(
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.delete_outline, color: Colors.red),
//                 onPressed: () {
//                   cart.removeFromCart(index);
//                 },
//               ),

//               Text(
//                 '\$${item.subtotal.toStringAsFixed(2)}',
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _quantityButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) {
//     return Container(
//       width: 32,
//       height: 32,
//       decoration: BoxDecoration(
//         color: Colors.deepPurple.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: IconButton(
//         padding: EdgeInsets.zero,
//         iconSize: 18,
//         icon: Icon(icon, color: Colors.deepPurple),
//         onPressed: onPressed,
//       ),
//     );
//   }

//   Widget _bottomSummary(BuildContext context, CartProvider cart) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const Text(
//                 'Total',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),

//               const Spacer(),

//               Text(
//                 '\$${cart.totalPrice.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 15),

//           SizedBox(
//             width: double.infinity,
//             height: 55,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => const CheckoutScreen()),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepPurple,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//               child: const Text(
//                 'Proceed to Checkout',
//                 style: TextStyle(
//                   fontSize: 17,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _emptyCart() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.shopping_cart_outlined,
//             size: 100,
//             color: Colors.grey.shade400,
//           ),

//           const SizedBox(height: 20),

//           const Text(
//             'Your Cart is Empty',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),

//           const SizedBox(height: 8),

//           Text(
//             'Add products to your cart\nto see them here.',
//             textAlign: TextAlign.center,
//             style: TextStyle(color: Colors.grey.shade600),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Cart',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            if (cart.items.isNotEmpty)
              Text(
                '${cart.itemCount} ${cart.itemCount == 1 ? 'item' : 'items'}',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.normal,
                ),
              ),
          ],
        ),
        actions: [
          if (cart.items.isNotEmpty)
            IconButton(
              tooltip: 'Clear Cart',
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: () {
                _showClearCartDialog(context, cart);
              },
            ),
          const SizedBox(width: 8),
        ],
      ),

      body: cart.items.isEmpty
          ? _emptyCart(context)
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
                    children: [
                      _deliveryBanner(context),
                      const SizedBox(height: 18),

                      Row(
                        children: [
                          Text(
                            'Your Items',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${cart.items.length} products',
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      ...List.generate(cart.items.length, (index) {
                        final item = cart.items[index];

                        return _cartItem(context, cart, item, index);
                      }),
                    ],
                  ),
                ),

                _bottomSummary(context, cart),
              ],
            ),
    );
  }

  // ============================================================
  // DELIVERY BANNER
  // ============================================================

  Widget _deliveryBanner(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withOpacity(0.65),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.local_shipping_outlined,
              color: colorScheme.primary,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fast & Secure Delivery',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your order will be carefully packed and delivered.',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onPrimaryContainer.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CART ITEM
  // ============================================================

  Widget _cartItem(
    BuildContext context,
    CartProvider cart,
    CartItem item,
    int index,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: theme.cardTheme.color ?? colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.5)),
        boxShadow: theme.brightness == Brightness.light
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------------------
            // PRODUCT IMAGE
            // ----------------------------------------------------
            Hero(
              tag: 'cart_product_${item.product.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 100,
                  height: 110,
                  color: colorScheme.surfaceContainerHighest,
                  child: Image.network(
                    item.product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported_outlined,
                        size: 40,
                        color: colorScheme.onSurfaceVariant,
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(width: 13),

            // ----------------------------------------------------
            // PRODUCT INFORMATION
            // ----------------------------------------------------
            Expanded(
              child: SizedBox(
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(width: 4),

                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            _showRemoveDialog(
                              context,
                              cart,
                              index,
                              item.product.name,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              Icons.close,
                              size: 19,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      item.product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Text(
                          '\$${item.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        _quantitySelector(context, cart, item, index),
                      ],
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
  // QUANTITY SELECTOR
  // ============================================================

  Widget _quantitySelector(
    BuildContext context,
    CartProvider cart,
    CartItem item,
    int index,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _quantityButton(
            context: context,
            icon: Icons.remove,
            onPressed: () {
              cart.decreaseQuantity(index);
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              item.quantity.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),

          _quantityButton(
            context: context,
            icon: Icons.add,
            onPressed: () {
              cart.increaseQuantity(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: SizedBox(
          width: 34,
          height: 36,
          child: Icon(icon, size: 18, color: colorScheme.primary),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM SUMMARY
  // ============================================================

  Widget _bottomSummary(BuildContext context, CartProvider cart) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const double deliveryFee = 0;

    final double total = cart.totalPrice + deliveryFee;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
        decoration: BoxDecoration(
          color: theme.cardTheme.color ?? colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border(
            top: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
          ),
          boxShadow: theme.brightness == Brightness.light
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 18,
                    offset: const Offset(0, -5),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            // ----------------------------------------------------
            // SUMMARY TITLE
            // ----------------------------------------------------
            Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 21,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ----------------------------------------------------
            // SUBTOTAL
            // ----------------------------------------------------
            _summaryRow(
              context,
              'Subtotal',
              '\$${cart.totalPrice.toStringAsFixed(2)}',
            ),

            const SizedBox(height: 9),

            // ----------------------------------------------------
            // DELIVERY
            // ----------------------------------------------------
            _summaryRow(
              context,
              'Delivery',
              deliveryFee == 0 ? 'FREE' : '\$${deliveryFee.toStringAsFixed(2)}',
              valueColor: deliveryFee == 0 ? Colors.green : null,
            ),

            const SizedBox(height: 14),

            Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),

            const SizedBox(height: 12),

            // ----------------------------------------------------
            // TOTAL
            // ----------------------------------------------------
            Row(
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const Spacer(),

                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ----------------------------------------------------
            // CHECKOUT BUTTON
            // ----------------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_rounded, size: 20),
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
  // SUMMARY ROW
  // ============================================================

  Widget _summaryRow(
    BuildContext context,
    String title,
    String value, {
    Color? valueColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, color: colorScheme.onSurfaceVariant),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // EMPTY CART
  // ============================================================

  Widget _emptyCart(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 65,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 28),

            Text(
              'Your Cart is Empty',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Looks like you haven\'t added anything to your cart yet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: 210,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text(
                  'Start Shopping',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
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
  // REMOVE ITEM DIALOG
  // ============================================================

  void _showRemoveDialog(
    BuildContext context,
    CartProvider cart,
    int index,
    String productName,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Remove Item?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text('Remove "$productName" from your cart?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                cart.removeFromCart(index);
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Remove'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CLEAR CART DIALOG
  // ============================================================

  void _showClearCartDialog(BuildContext context, CartProvider cart) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Clear Cart?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to remove all products from your cart?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Clear Cart'),
            ),
          ],
        );
      },
    );
  }
}

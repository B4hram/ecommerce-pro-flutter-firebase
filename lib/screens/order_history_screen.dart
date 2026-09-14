// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../providers/order_provider.dart';
// import '../models/order_model.dart';
// import 'order_tracking_screen.dart';

// class OrderHistoryScreen extends StatefulWidget {
//   const OrderHistoryScreen({super.key});

//   @override
//   State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
// }

// class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       final user = FirebaseAuth.instance.currentUser;

//       if (user != null) {
//         context.read<OrderProvider>().fetchOrders(user.uid);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<OrderProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'My Orders',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),

//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.orders.isEmpty
//           ? _emptyOrders()
//           : RefreshIndicator(
//               onRefresh: () async {
//                 final user = FirebaseAuth.instance.currentUser;

//                 if (user != null) {
//                   await provider.fetchOrders(user.uid);
//                 }
//               },

//               child: ListView.builder(
//                 padding: const EdgeInsets.all(16),

//                 itemCount: provider.orders.length,

//                 itemBuilder: (context, index) {
//                   final order = provider.orders[index];

//                   return _orderCard(context, order);
//                 },
//               ),
//             ),
//     );
//   }

//   // ==========================================
//   // ORDER CARD
//   // ==========================================

//   Widget _orderCard(BuildContext context, OrderModel order) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 15),

//       elevation: 2,

//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

//       child: Padding(
//         padding: const EdgeInsets.all(18),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             Row(
//               children: [
//                 Container(
//                   width: 48,
//                   height: 48,

//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple.withOpacity(0.1),

//                     borderRadius: BorderRadius.circular(12),
//                   ),

//                   child: const Icon(
//                     Icons.shopping_bag,
//                     color: Colors.deepPurple,
//                   ),
//                 ),

//                 const SizedBox(width: 12),

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,

//                     children: [
//                       const Text('Order', style: TextStyle(color: Colors.grey)),

//                       Text(
//                         '#${order.id.substring(0, order.id.length > 8 ? 8 : order.id.length)}',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),

//                 _statusBadge(order.status),
//               ],
//             ),

//             const SizedBox(height: 18),

//             const Divider(),

//             const SizedBox(height: 12),

//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,

//               children: [
//                 Text(
//                   '${order.items.length} product(s)',
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),

//                 Text(
//                   '\$${order.total.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 15),

//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton.icon(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => OrderTrackingScreen(order: order),
//                     ),
//                   );
//                 },

//                 icon: const Icon(Icons.local_shipping),

//                 label: const Text('Track Order'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==========================================
//   // STATUS BADGE
//   // ==========================================

//   Widget _statusBadge(String status) {
//     Color color;

//     switch (status.toLowerCase()) {
//       case 'delivered':
//         color = Colors.green;
//         break;

//       case 'shipped':
//         color = Colors.blue;
//         break;

//       case 'processing':
//         color = Colors.orange;
//         break;

//       case 'cancelled':
//         color = Colors.red;
//         break;

//       default:
//         color = Colors.grey;
//     }

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),

//       child: Text(
//         status,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }

//   // ==========================================
//   // EMPTY
//   // ==========================================

//   Widget _emptyOrders() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(30),

//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,

//           children: [
//             Icon(
//               Icons.shopping_bag_outlined,
//               size: 80,
//               color: Colors.grey.shade400,
//             ),

//             const SizedBox(height: 20),

//             const Text(
//               'No Orders Yet',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               'Your orders will appear here after you make a purchase.',
//               textAlign: TextAlign.center,

//               style: TextStyle(color: Colors.grey.shade600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/order_provider.dart';
import '../models/order_model.dart';
import 'order_tracking_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      _loadOrders();
    });
  }

  Future<void> _loadOrders() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await context.read<OrderProvider>().fetchOrders(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();
    final theme = Theme.of(context);
    // final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // ==========================================
      // APP BAR
      // ==========================================
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'My Orders',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadOrders,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),

      // ==========================================
      // BODY
      // ==========================================
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.orders.isEmpty
          ? _emptyOrders(context)
          : RefreshIndicator(
              onRefresh: _loadOrders,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 30),
                children: [
                  // HEADER
                  _buildHeader(context, provider.orders.length),

                  const SizedBox(height: 20),

                  // ORDERS
                  ...provider.orders.map((order) => _orderCard(context, order)),
                ],
              ),
            ),
    );
  }

  // ==========================================
  // HEADER
  // ==========================================

  Widget _buildHeader(BuildContext context, int orderCount) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primaryContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '$orderCount order${orderCount == 1 ? '' : 's'} placed',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // ORDER CARD
  // ==========================================

  Widget _orderCard(BuildContext context, OrderModel order) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final shortId = order.id.length > 8 ? order.id.substring(0, 8) : order.id;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================
            // ORDER HEADER
            // ======================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    color: colorScheme.primary,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 13),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order',
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.textTheme.bodyMedium?.color?.withOpacity(
                            0.55,
                          ),
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        '#$shortId',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                _statusBadge(context, order.status),
              ],
            ),

            const SizedBox(height: 18),

            Divider(color: theme.dividerColor.withOpacity(0.5)),

            const SizedBox(height: 15),

            // ======================================
            // ORDER INFORMATION
            // ======================================
            Row(
              children: [
                Expanded(
                  child: _infoItem(
                    context,
                    Icons.inventory_2_outlined,
                    'Products',
                    '${order.items.length}',
                  ),
                ),

                Expanded(
                  child: _infoItem(
                    context,
                    Icons.payments_outlined,
                    'Total',
                    '\$${order.total.toStringAsFixed(2)}',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ======================================
            // SHIPPING ADDRESS
            // ======================================
            if (order.address.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest.withOpacity(
                    0.45,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 21,
                      color: colorScheme.primary,
                    ),

                    const SizedBox(width: 9),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shipping Address',
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withOpacity(0.55),
                            ),
                          ),

                          const SizedBox(height: 3),

                          Text(
                            order.address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // ======================================
            // PAYMENT METHOD
            // ======================================
            if (order.paymentMethod.isNotEmpty)
              Row(
                children: [
                  Icon(
                    Icons.payment_outlined,
                    size: 20,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.65),
                  ),

                  const SizedBox(width: 9),

                  Text(
                    'Payment:',
                    style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(
                        0.65,
                      ),
                    ),
                  ),

                  const SizedBox(width: 5),

                  Expanded(
                    child: Text(
                      order.paymentMethod,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 18),

            // ======================================
            // TRACK ORDER BUTTON
            // ======================================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderTrackingScreen(order: order),
                    ),
                  );
                },
                icon: const Icon(Icons.local_shipping_outlined),
                label: const Text(
                  'Track Order',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // INFO ITEM
  // ==========================================

  Widget _infoItem(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 21, color: theme.colorScheme.primary),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.55),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================
  // STATUS BADGE
  // ==========================================

  Widget _statusBadge(BuildContext context, String status) {
    Color color;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'delivered':
        color = Colors.green;
        icon = Icons.check_circle_outline;
        break;

      case 'shipped':
        color = Colors.blue;
        icon = Icons.local_shipping_outlined;
        break;

      case 'processing':
        color = Colors.orange;
        icon = Icons.sync;
        break;

      case 'cancelled':
        color = Colors.red;
        icon = Icons.cancel_outlined;
        break;

      case 'pending':
        color = Colors.amber.shade700;
        icon = Icons.pending_outlined;
        break;

      default:
        color = Colors.grey;
        icon = Icons.info_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),

          const SizedBox(width: 5),

          Text(
            status.isEmpty ? 'Unknown' : status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // EMPTY ORDERS
  // ==========================================

  Widget _emptyOrders(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 65,
                color: colorScheme.primary.withOpacity(0.55),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'No Orders Yet',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              'You haven\'t placed any orders yet.\n'
              'Start shopping and your orders will '
              'appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text(
                  'Start Shopping',
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

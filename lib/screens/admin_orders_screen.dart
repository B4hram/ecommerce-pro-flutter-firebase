// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/order_provider.dart';
// import 'order_details_screen.dart';

// class AdminOrdersScreen
//     extends StatefulWidget {
//   const AdminOrdersScreen({
//     super.key,
//   });

//   @override
//   State<AdminOrdersScreen> createState() =>
//       _AdminOrdersScreenState();
// }

// class _AdminOrdersScreenState
//     extends State<AdminOrdersScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context
//           .read<OrderProvider>()
//           .fetchAllOrders();
//     });
//   }

//   Color statusColor(String status) {
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
//     final provider =
//         context.watch<OrderProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title:
//             const Text('Manage Orders'),
//       ),

//       body: provider.isLoading
//           ? const Center(
//               child:
//                   CircularProgressIndicator(),
//             )
//           : provider.orders.isEmpty
//               ? const Center(
//                   child:
//                       Text('No orders found.'),
//                 )
//               : RefreshIndicator(
//                   onRefresh:
//                       provider
//                           .fetchAllOrders,
//                   child: ListView.builder(
//                     padding:
//                         const EdgeInsets.all(
//                       16,
//                     ),
//                     itemCount:
//                         provider.orders.length,
//                     itemBuilder:
//                         (context, index) {
//                       final order =
//                           provider.orders[index];

//                       return Card(
//                         margin:
//                             const EdgeInsets.only(
//                           bottom: 12,
//                         ),
//                         child: Padding(
//                           padding:
//                               const EdgeInsets.all(
//                             14,
//                           ),
//                           child: Column(
//                             children: [
//                               ListTile(
//                                 contentPadding:
//                                     EdgeInsets.zero,
//                                 leading:
//                                     const CircleAvatar(
//                                   child: Icon(
//                                     Icons
//                                         .shopping_bag,
//                                   ),
//                                 ),
//                                 title: Text(
//                                   'Order #${order.id.substring(0, 6)}',
//                                   style:
//                                       const TextStyle(
//                                     fontWeight:
//                                         FontWeight.bold,
//                                   ),
//                                 ),
//                                 subtitle:
//                                     Text(
//                                   '\$${order.total.toStringAsFixed(2)}\n${order.address}',
//                                 ),
//                                 isThreeLine:
//                                     true,
//                                 trailing:
//                                     Text(
//                                   order.status,
//                                   style:
//                                       TextStyle(
//                                     color:
//                                         statusColor(
//                                       order.status,
//                                     ),
//                                     fontWeight:
//                                         FontWeight.bold,
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (_) =>
//                                               OrderDetailsScreen(
//                                         order:
//                                             order,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),

//                               const Divider(),

//                               DropdownButtonFormField<
//                                   String>(
//                                 value:
//                                     order.status,
//                                 decoration:
//                                     const InputDecoration(
//                                   labelText:
//                                       'Change Order Status',
//                                   border:
//                                       OutlineInputBorder(),
//                                 ),
//                                 items: const [
//                                   'Pending',
//                                   'Processing',
//                                   'Shipped',
//                                   'Delivered',
//                                   'Cancelled',
//                                 ].map(
//                                   (status) {
//                                     return DropdownMenuItem(
//                                       value:
//                                           status,
//                                       child:
//                                           Text(
//                                         status,
//                                       ),
//                                     );
//                                   },
//                                 ).toList(),
//                                 onChanged:
//                                     (value) async {
//                                   if (value ==
//                                       null) {
//                                     return;
//                                   }

//                                   try {
//                                     await provider
//                                         .updateOrderStatus(
//                                       orderId:
//                                           order.id,
//                                       status:
//                                           value,
//                                     );

//                                     if (!mounted) {
//                                       return;
//                                     }

//                                     ScaffoldMessenger
//                                         .of(
//                                       context,
//                                     ).showSnackBar(
//                                       const SnackBar(
//                                         content:
//                                             Text(
//                                           'Order status updated.',
//                                         ),
//                                       ),
//                                     );
//                                   } catch (e) {
//                                     if (!mounted) {
//                                       return;
//                                     }

//                                     ScaffoldMessenger
//                                         .of(
//                                       context,
//                                     ).showSnackBar(
//                                       SnackBar(
//                                         content:
//                                             Text(
//                                           'Error: $e',
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/order_provider.dart';

// class AdminOrdersScreen extends StatefulWidget {
//   const AdminOrdersScreen({super.key});

//   @override
//   State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
// }

// class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
//   final List<String> statuses = const [
//     'Pending',
//     'Confirmed',
//     'Processing',
//     'Shipped',
//     'Delivered',
//     'Cancelled',
//   ];

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context.read<OrderProvider>().fetchAllOrders();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<OrderProvider>();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Manage Orders')),

//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.orders.isEmpty
//           ? const Center(child: Text('No orders found.'))
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: provider.orders.length,
//               itemBuilder: (context, index) {
//                 final order = provider.orders[index];

//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 15),

//                   child: Padding(
//                     padding: const EdgeInsets.all(16),

//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,

//                       children: [
//                         Row(
//                           children: [
//                             const Icon(Icons.shopping_bag),

//                             const SizedBox(width: 10),

//                             Expanded(
//                               child: Text(
//                                 'Order #${order.id.substring(0, 6)}',
//                                 style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),

//                             IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 _deleteOrder(order.id);
//                               },
//                             ),
//                           ],
//                         ),

//                         const Divider(),

//                         Text('User ID: ${order.userId}'),

//                         const SizedBox(height: 8),

//                         Text('Address: ${order.address}'),

//                         const SizedBox(height: 8),

//                         Text('Payment: ${order.paymentMethod}'),

//                         const SizedBox(height: 8),

//                         Text(
//                           'Total: \$${order.total.toStringAsFixed(2)}',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),

//                         const SizedBox(height: 15),

//                         DropdownButtonFormField<String>(
//                           initialValue: statuses.contains(order.status)
//                               ? order.status
//                               : 'Pending',

//                           decoration: const InputDecoration(
//                             labelText: 'Order Status',
//                             border: OutlineInputBorder(),
//                           ),

//                           items: statuses.map((status) {
//                             return DropdownMenuItem<String>(
//                               value: status,
//                               child: Text(status),
//                             );
//                           }).toList(),

//                           onChanged: (value) async {
//                             if (value == null) {
//                               return;
//                             }

//                             try {
//                               await context
//                                   .read<OrderProvider>()
//                                   .updateOrderStatus(
//                                     orderId: order.id,
//                                     status: value,
//                                   );

//                               if (!mounted) {
//                                 return;
//                               }

//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Order status updated.'),
//                                 ),
//                               );
//                             } catch (e) {
//                               if (!mounted) {
//                                 return;
//                               }

//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('Error: $e')),
//                               );
//                             }
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Future<void> _deleteOrder(String orderId) async {
//     final confirm = await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Delete Order'),
//           content: const Text('Are you sure you want to delete this order?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context, false);
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirm != true) {
//       return;
//     }

//     try {
//       await context.read<OrderProvider>().deleteOrder(orderId);

//       if (!mounted) return;

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Order deleted.')));
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> {
  final List<String> statuses = const [
    'Pending',
    'Confirmed',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<OrderProvider>().fetchAllOrders();
    });
  }

  // =========================================================
  // REFRESH
  // =========================================================

  Future<void> _refreshOrders() async {
    await context.read<OrderProvider>().fetchAllOrders();
  }

  // =========================================================
  // FILTER ORDERS
  // =========================================================

  List<dynamic> _getFilteredOrders(OrderProvider provider) {
    if (_selectedFilter == 'All') {
      return provider.orders;
    }

    return provider.orders
        .where(
          (order) =>
              order.status.toString().toLowerCase() ==
              _selectedFilter.toLowerCase(),
        )
        .toList();
  }

  // =========================================================
  // STATUS UPDATE
  // =========================================================

  Future<void> _updateStatus(
    dynamic order,
    String status,
  ) async {
    if (order.status == status) return;

    try {
      await context.read<OrderProvider>().updateOrderStatus(
        orderId: order.id,
        status: status,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Order status changed to $status.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to update order: $e',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================================================
  // DELETE ORDER
  // =========================================================

  Future<void> _deleteOrder(
    String orderId,
    String shortId,
  ) async {
    final colors = Theme.of(context).colorScheme;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.delete_forever_rounded,
            size: 44,
            color: colors.error,
          ),
          title: const Text(
            'Delete Order?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to permanently delete '
            'order #$shortId?\n\n'
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await context.read<OrderProvider>().deleteOrder(orderId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Order deleted successfully.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to delete order: $e'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrderProvider>();

    final filteredOrders = _getFilteredOrders(provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Management',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh Orders',
            onPressed: provider.isLoading
                ? null
                : _refreshOrders,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshOrders,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                18,
                16,
                30,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildHeader(provider),
                    const SizedBox(height: 18),
                    _buildStatistics(provider),
                    const SizedBox(height: 24),
                    _buildFilterSection(),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),

            if (provider.isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else if (filteredOrders.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildEmptyState(),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  40,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final order = filteredOrders[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: _buildOrderCard(order),
                      );
                    },
                    childCount: filteredOrders.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader(OrderProvider provider) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary,
            colors.primary.withValues(alpha: 0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${provider.orders.length} total orders',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // STATISTICS
  // =========================================================

  Widget _buildStatistics(OrderProvider provider) {
    final orders = provider.orders;

    final pending = orders
        .where(
          (order) =>
              order.status.toString().toLowerCase() ==
              'pending',
        )
        .length;

    final processing = orders
        .where(
          (order) =>
              order.status.toString().toLowerCase() ==
                  'processing' ||
              order.status.toString().toLowerCase() ==
                  'confirmed',
        )
        .length;

    final delivered = orders
        .where(
          (order) =>
              order.status.toString().toLowerCase() ==
              'delivered',
        )
        .length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.pending_actions_rounded,
            title: 'Pending',
            value: pending.toString(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            icon: Icons.sync_rounded,
            title: 'Active',
            value: processing.toString(),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle_outline_rounded,
            title: 'Delivered',
            value: delivered.toString(),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: colors.primary,
            size: 26,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FILTER
  // =========================================================

  Widget _buildFilterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter Orders',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip('All'),
              ...statuses.map(
                (status) => _buildFilterChip(status),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String status) {
    final selected = _selectedFilter == status;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: selected,
        label: Text(status),
        onSelected: (_) {
          setState(() {
            _selectedFilter = status;
          });
        },
        avatar: Icon(
          _statusIcon(status),
          size: 17,
          color: selected
              ? colors.onSecondaryContainer
              : _statusColor(status),
        ),
      ),
    );
  }

  // =========================================================
  // ORDER CARD
  // =========================================================

  Widget _buildOrderCard(dynamic order) {
    final colors = Theme.of(context).colorScheme;

    final String orderId = order.id.toString();

    final String shortId = orderId.length >= 6
        ? orderId.substring(0, 6).toUpperCase()
        : orderId.toUpperCase();

    final String status =
        order.status.toString();

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // -------------------------------------------------
            // ORDER HEADER
            // -------------------------------------------------

            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color:
                        colors.onPrimaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #$shortId',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Customer Order',
                        style: TextStyle(
                          color:
                              colors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(status),
              ],
            ),

            const SizedBox(height: 16),

            Divider(
              color: colors.outlineVariant,
            ),

            const SizedBox(height: 14),

            // -------------------------------------------------
            // CUSTOMER
            // -------------------------------------------------

            _buildInfoRow(
              icon: Icons.person_outline_rounded,
              title: 'Customer ID',
              value: order.userId.toString(),
            ),

            const SizedBox(height: 12),

            // -------------------------------------------------
            // ADDRESS
            // -------------------------------------------------

            _buildInfoRow(
              icon: Icons.location_on_outlined,
              title: 'Shipping Address',
              value: order.address.toString(),
            ),

            const SizedBox(height: 12),

            // -------------------------------------------------
            // PAYMENT
            // -------------------------------------------------

            _buildInfoRow(
              icon: Icons.payment_outlined,
              title: 'Payment Method',
              value: order.paymentMethod.toString(),
            ),

            const SizedBox(height: 16),

            // -------------------------------------------------
            // TOTAL
            // -------------------------------------------------

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money_rounded,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Order Total',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '\$${order.total.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // -------------------------------------------------
            // STATUS DROPDOWN
            // -------------------------------------------------

            DropdownButtonFormField<String>(
              initialValue:
                  statuses.contains(status)
                      ? status
                      : 'Pending',
              decoration: InputDecoration(
                labelText: 'Update Order Status',
                prefixIcon: Icon(
                  Icons.sync_rounded,
                  color: colors.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(14),
                ),
              ),
              items: statuses.map((status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Row(
                    children: [
                      Icon(
                        _statusIcon(status),
                        size: 19,
                        color: _statusColor(status),
                      ),
                      const SizedBox(width: 10),
                      Text(status),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;

                _updateStatus(
                  order,
                  value,
                );
              },
            ),

            const SizedBox(height: 14),

            // -------------------------------------------------
            // DELETE BUTTON
            // -------------------------------------------------

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _deleteOrder(
                    orderId,
                    shortId,
                  );
                },
                icon: const Icon(
                  Icons.delete_outline_rounded,
                ),
                label: const Text(
                  'Delete Order',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.error,
                  side: BorderSide(
                    color: colors.error
                        .withValues(alpha: 0.5),
                  ),
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // INFO ROW
  // =========================================================

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 21,
          color: colors.primary,
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
                  color: colors.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================
  // STATUS BADGE
  // =========================================================

  Widget _buildStatusBadge(String status) {
    final color = _statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _statusIcon(status),
            size: 15,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            status,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // STATUS COLOR
  // =========================================================

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;

      case 'confirmed':
        return Colors.indigo;

      case 'processing':
        return Colors.blue;

      case 'shipped':
        return Colors.deepPurple;

      case 'delivered':
        return Colors.green;

      case 'cancelled':
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  // =========================================================
  // STATUS ICON
  // =========================================================

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending_actions_rounded;

      case 'confirmed':
        return Icons.verified_outlined;

      case 'processing':
        return Icons.sync_rounded;

      case 'shipped':
        return Icons.local_shipping_outlined;

      case 'delivered':
        return Icons.check_circle_outline_rounded;

      case 'cancelled':
        return Icons.cancel_outlined;

      default:
        return Icons.help_outline_rounded;
    }
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _buildEmptyState() {
    final colors = Theme.of(context).colorScheme;

    final isFiltered = _selectedFilter != 'All';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFiltered
                    ? Icons.filter_alt_off_outlined
                    : Icons.receipt_long_outlined,
                size: 44,
                color:
                    colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isFiltered
                  ? 'No Matching Orders'
                  : 'No Orders Yet',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isFiltered
                  ? 'There are no orders with the "$_selectedFilter" status.'
                  : 'Customer orders will appear here when they place an order.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
            if (isFiltered) ...[
              const SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  setState(() {
                    _selectedFilter = 'All';
                  });
                },
                child: const Text(
                  'Show All Orders',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
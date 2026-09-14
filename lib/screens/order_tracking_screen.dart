// import 'package:flutter/material.dart';

// import '../models/order_model.dart';

// class OrderTrackingScreen extends StatelessWidget {
//   final OrderModel order;

//   const OrderTrackingScreen({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     final currentStatus = order.status;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Track Order',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // =====================================
//             // ORDER HEADER
//             // =====================================
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         width: 55,
//                         height: 55,
//                         decoration: BoxDecoration(
//                           color: Colors.deepPurple.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: const Icon(
//                           Icons.shopping_bag,
//                           color: Colors.deepPurple,
//                           size: 30,
//                         ),
//                       ),

//                       const SizedBox(width: 15),

//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Order',
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 14,
//                               ),
//                             ),

//                             const SizedBox(height: 3),

//                             Text(
//                               '#${order.id}',
//                               style: const TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       _statusBadge(currentStatus),
//                     ],
//                   ),

//                   const SizedBox(height: 20),

//                   const Divider(),

//                   const SizedBox(height: 15),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Order Total',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),

//                       Text(
//                         '\$${order.total.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),

//             // =====================================
//             // TRACKING
//             // =====================================
//             const Text(
//               'Order Status',
//               style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 15),

//             // IMPORTANT:
//             // Pass BOTH context and currentStatus.
//             _buildTrackingTimeline(context, currentStatus),

//             const SizedBox(height: 25),

//             // =====================================
//             // SHIPPING ADDRESS
//             // =====================================
//             _infoCard(
//               context,
//               icon: Icons.location_on,
//               title: 'Shipping Address',
//               value: order.address,
//             ),

//             const SizedBox(height: 15),

//             // =====================================
//             // PAYMENT METHOD
//             // =====================================
//             _infoCard(
//               context,
//               icon: order.paymentMethod.toLowerCase().contains('cash')
//                   ? Icons.money
//                   : Icons.credit_card,
//               title: 'Payment Method',
//               value: order.paymentMethod,
//             ),

//             const SizedBox(height: 25),

//             // =====================================
//             // PRODUCTS
//             // =====================================
//             const Text(
//               'Order Items',
//               style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
//             ),

//             const SizedBox(height: 15),

//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(18),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.04),
//                     blurRadius: 8,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   ...order.items.map((item) {
//                     final name = item['name']?.toString() ?? 'Product';

//                     final price = _toDouble(item['price']);

//                     final quantity = _toInt(item['quantity']);

//                     final subtotal = price * quantity;

//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 15),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 50,
//                             height: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.deepPurple.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.shopping_bag,
//                               color: Colors.deepPurple,
//                             ),
//                           ),

//                           const SizedBox(width: 12),

//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   name,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 5),

//                                 Text(
//                                   'Quantity: $quantity',
//                                   style: TextStyle(color: Colors.grey.shade600),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           Text(
//                             '\$${subtotal.toStringAsFixed(2)}',
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     );
//                   }),

//                   const Divider(),

//                   const SizedBox(height: 10),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Total',
//                         style: TextStyle(
//                           fontSize: 19,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       Text(
//                         '\$${order.total.toStringAsFixed(2)}',
//                         style: const TextStyle(
//                           fontSize: 21,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurple,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),

//             // =====================================
//             // ORDER DATE
//             // =====================================
//             _infoCard(
//               context,
//               icon: Icons.calendar_today,
//               title: 'Order Date',
//               value: order.date,
//             ),

//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   // ============================================
//   // STATUS BADGE
//   // ============================================

//   Widget _statusBadge(String status) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//       decoration: BoxDecoration(
//         color: _statusColor(status).withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(
//           color: _statusColor(status),
//           fontWeight: FontWeight.bold,
//           fontSize: 13,
//         ),
//       ),
//     );
//   }

//   // ============================================
//   // TRACKING TIMELINE
//   // ============================================

//   Widget _buildTrackingTimeline(BuildContext context, String status) {
//     final statuses = ['Pending', 'Processing', 'Shipped', 'Delivered'];

//     final currentIndex = statuses.indexWhere(
//       (item) => item.toLowerCase() == status.toLowerCase(),
//     );

//     final effectiveIndex = currentIndex == -1 ? 0 : currentIndex;

//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: List.generate(statuses.length, (index) {
//           final isCompleted = index <= effectiveIndex;

//           final isCurrent = index == effectiveIndex;

//           return _timelineItem(
//             title: statuses[index],
//             index: index,
//             isCompleted: isCompleted,
//             isCurrent: isCurrent,
//             isLast: index == statuses.length - 1,
//           );
//         }),
//       ),
//     );
//   }

//   // ============================================
//   // TIMELINE ITEM
//   // ============================================

//   Widget _timelineItem({
//     required String title,
//     required int index,
//     required bool isCompleted,
//     required bool isCurrent,
//     required bool isLast,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             Container(
//               width: 35,
//               height: 35,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: isCompleted ? Colors.deepPurple : Colors.grey.shade300,
//               ),
//               child: Icon(
//                 isCompleted ? Icons.check : Icons.circle,
//                 size: 19,
//                 color: isCompleted ? Colors.white : Colors.grey.shade500,
//               ),
//             ),

//             if (!isLast)
//               Container(
//                 width: 3,
//                 height: 45,
//                 color: index < 3 ? Colors.deepPurple : Colors.grey.shade300,
//               ),
//           ],
//         ),

//         const SizedBox(width: 15),

//         Padding(
//           padding: const EdgeInsets.only(top: 7),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
//                   color: isCompleted ? Colors.deepPurple : Colors.grey,
//                 ),
//               ),

//               if (isCurrent)
//                 const Padding(
//                   padding: EdgeInsets.only(top: 3),
//                   child: Text(
//                     'Current status',
//                     style: TextStyle(fontSize: 12, color: Colors.grey),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ============================================
//   // INFO CARD
//   // ============================================

//   Widget _infoCard(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 45,
//             height: 45,
//             decoration: BoxDecoration(
//               color: Colors.deepPurple.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Icon(icon, color: Colors.deepPurple),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
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
//                   style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ============================================
//   // STATUS COLOR
//   // ============================================

//   Color _statusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Colors.orange;

//       case 'processing':
//         return Colors.blue;

//       case 'shipped':
//         return Colors.indigo;

//       case 'delivered':
//         return Colors.green;

//       case 'cancelled':
//         return Colors.red;

//       default:
//         return Colors.grey;
//     }
//   }

//   // ============================================
//   // CONVERT NUMBER
//   // ============================================

//   double _toDouble(dynamic value) {
//     if (value is num) {
//       return value.toDouble();
//     }

//     return double.tryParse(value.toString()) ?? 0;
//   }

//   int _toInt(dynamic value) {
//     if (value is num) {
//       return value.toInt();
//     }

//     return int.tryParse(value.toString()) ?? 1;
//   }
// }

import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderTrackingScreen extends StatelessWidget {
  final OrderModel order;

  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final status = order.status.trim();
    final statusColor = _statusColor(status);
    final statusIcon = _statusIcon(status);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============================================================
            // ORDER HEADER
            // ============================================================
            _buildOrderHeader(
              context,
              status: status,
              statusColor: statusColor,
              statusIcon: statusIcon,
            ),

            const SizedBox(height: 24),

            // ============================================================
            // TRACKING TITLE
            // ============================================================
            const Text(
              'Delivery Progress',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 6),

            Text(
              _statusDescription(status),
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 16),

            // ============================================================
            // TRACKING TIMELINE
            // ============================================================
            _buildTrackingTimeline(context, status),

            const SizedBox(height: 24),

            // ============================================================
            // SHIPPING INFORMATION
            // ============================================================
            const Text(
              'Shipping Information',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 14),

            _buildInfoCard(
              context,
              icon: Icons.location_on_rounded,
              title: 'Shipping Address',
              value: order.address,
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              context,
              icon: order.paymentMethod.toLowerCase().contains('cash')
                  ? Icons.payments_rounded
                  : Icons.credit_card_rounded,
              title: 'Payment Method',
              value: order.paymentMethod,
            ),

            const SizedBox(height: 12),

            _buildInfoCard(
              context,
              icon: Icons.calendar_month_rounded,
              title: 'Order Date',
              value: order.date,
            ),

            const SizedBox(height: 24),

            // ============================================================
            // ORDER ITEMS
            // ============================================================
            const Text(
              'Order Items',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 14),

            _buildItemsCard(context),

            const SizedBox(height: 24),

            // ============================================================
            // ORDER SUMMARY
            // ============================================================
            _buildSummaryCard(context),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ======================================================================
  // ORDER HEADER
  // ======================================================================

  Widget _buildOrderHeader(
    BuildContext context, {
    required String status,
    required Color statusColor,
    required IconData statusIcon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.22),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: const Icon(
                  Icons.local_shipping_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Number',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      '#${order.id}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.10)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(statusIcon, color: Colors.white, size: 19),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Status',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.70),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        status.isEmpty ? 'Pending' : status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order Total',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.78),
                  fontSize: 14,
                ),
              ),
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ======================================================================
  // TRACKING TIMELINE
  // ======================================================================

  Widget _buildTrackingTimeline(BuildContext context, String status) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const statuses = ['Pending', 'Processing', 'Shipped', 'Delivered'];

    final currentIndex = statuses.indexWhere(
      (item) => item.toLowerCase() == status.toLowerCase(),
    );

    final effectiveIndex = currentIndex < 0 ? 0 : currentIndex;

    final isCancelled = status.toLowerCase() == 'cancelled';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.45)),
      ),
      child: Column(
        children: [
          if (isCancelled) _buildCancelledBanner(context),

          if (isCancelled) const SizedBox(height: 18),

          ...List.generate(statuses.length, (index) {
            final isCompleted = index <= effectiveIndex;
            final isCurrent = index == effectiveIndex;
            final isLast = index == statuses.length - 1;

            return _buildTimelineItem(
              context,
              title: statuses[index],
              index: index,
              isCompleted: isCompleted,
              isCurrent: isCurrent,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  // ======================================================================
  // TIMELINE ITEM
  // ======================================================================

  Widget _buildTimelineItem(
    BuildContext context, {
    required String title,
    required int index,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLast,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final icons = [
      Icons.receipt_long_rounded,
      Icons.inventory_2_rounded,
      Icons.local_shipping_rounded,
      Icons.home_rounded,
    ];

    final activeColor = colorScheme.primary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 42,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isCurrent ? 40 : 34,
                  height: isCurrent ? 40 : 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? activeColor
                        : colorScheme.surfaceContainerHighest,
                    border: Border.all(
                      color: isCompleted
                          ? activeColor
                          : colorScheme.outlineVariant,
                      width: 2,
                    ),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: activeColor.withOpacity(0.25),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    isCompleted ? Icons.check_rounded : icons[index],
                    size: isCurrent ? 21 : 17,
                    color: isCompleted
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                  ),
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: index < _effectiveTimelineIndex(context, title)
                          ? activeColor
                          : colorScheme.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: isCurrent ? 4 : 6,
                bottom: isLast ? 0 : 28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                      color: isCompleted
                          ? colorScheme.onSurface
                          : colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    _statusStepDescription(title),
                    style: TextStyle(
                      fontSize: 13,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),

                  if (isCurrent) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: activeColor.withOpacity(0.10),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Current status',
                        style: TextStyle(
                          color: activeColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================================
  // CANCELLED BANNER
  // ======================================================================

  Widget _buildCancelledBanner(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.withOpacity(0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.cancel_rounded, color: Colors.red),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Cancelled',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'This order has been cancelled and is no longer being processed.',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================================
  // INFO CARD
  // ======================================================================

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: colorScheme.primary, size: 23),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value.isEmpty ? 'Not available' : value,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======================================================================
  // ORDER ITEMS
  // ======================================================================

  Widget _buildItemsCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.45)),
      ),
      child: Column(
        children: [
          ...order.items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            final name = item['name']?.toString() ?? 'Product';

            final price = _toDouble(item['price']);
            final quantity = _toInt(item['quantity']);
            final subtotal = price * quantity;

            final image = item['image']?.toString() ?? '';

            return Padding(
              padding: EdgeInsets.only(
                bottom: index == order.items.length - 1 ? 0 : 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildProductImage(context, image),

                  const SizedBox(width: 13),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '\$${price.toStringAsFixed(2)} × $quantity',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    '\$${subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ======================================================================
  // PRODUCT IMAGE
  // ======================================================================

  Widget _buildProductImage(BuildContext context, String image) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outlineVariant.withOpacity(0.45)),
      ),
      clipBehavior: Clip.antiAlias,
      child: image.isEmpty
          ? Icon(
              Icons.shopping_bag_outlined,
              color: colorScheme.onSurfaceVariant,
            )
          : Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported_outlined,
                  color: colorScheme.onSurfaceVariant,
                );
              },
            ),
    );
  }

  // ======================================================================
  // ORDER SUMMARY
  // ======================================================================

  Widget _buildSummaryCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.primary.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_rounded, color: colorScheme.primary),
              const SizedBox(width: 10),
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
            ],
          ),

          const SizedBox(height: 18),

          _summaryRow(context, 'Items', '${order.items.length}'),

          const SizedBox(height: 10),

          _summaryRow(context, 'Payment', order.paymentMethod),

          const SizedBox(height: 16),

          Divider(color: colorScheme.outlineVariant.withOpacity(0.5)),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              Text(
                '\$${order.total.toStringAsFixed(2)}',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(BuildContext context, String title, String value) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: colorScheme.onSurfaceVariant, fontSize: 14),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  // ======================================================================
  // STATUS HELPERS
  // ======================================================================

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
        return Icons.schedule_rounded;

      case 'processing':
        return Icons.inventory_2_rounded;

      case 'shipped':
        return Icons.local_shipping_rounded;

      case 'delivered':
        return Icons.home_rounded;

      case 'cancelled':
        return Icons.cancel_rounded;

      default:
        return Icons.info_outline_rounded;
    }
  }

  String _statusDescription(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Your order has been received and is waiting to be processed.';

      case 'processing':
        return 'Your order is currently being prepared.';

      case 'shipped':
        return 'Your order has been shipped and is on its way to you.';

      case 'delivered':
        return 'Your order has been successfully delivered.';

      case 'cancelled':
        return 'This order has been cancelled.';

      default:
        return 'You can view the current progress of your order below.';
    }
  }

  String _statusStepDescription(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Order received successfully.';

      case 'processing':
        return 'Your items are being prepared.';

      case 'shipped':
        return 'Package is on its way.';

      case 'delivered':
        return 'Package delivered successfully.';

      default:
        return '';
    }
  }

  int _effectiveTimelineIndex(BuildContext context, String title) {
    final statuses = ['Pending', 'Processing', 'Shipped', 'Delivered'];

    final currentIndex = statuses.indexWhere(
      (item) => item.toLowerCase() == order.status.toLowerCase(),
    );

    final effectiveIndex = currentIndex < 0 ? 0 : currentIndex;

    final titleIndex = statuses.indexWhere(
      (item) => item.toLowerCase() == title.toLowerCase(),
    );

    return titleIndex < effectiveIndex ? effectiveIndex : titleIndex;
  }

  // ======================================================================
  // NUMBER CONVERSION
  // ======================================================================

  double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  int _toInt(dynamic value) {
    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 1;
  }
}

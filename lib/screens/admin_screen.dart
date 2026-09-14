// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/auth_provider.dart';
// import '../providers/product_provider.dart';

// import 'add_product_screen.dart';
// import 'edit_product_screen.dart';
// import 'admin_orders_screen.dart';
// import 'home_screen.dart';
// import 'auth/login_screen.dart';

// class AdminScreen extends StatefulWidget {
//   const AdminScreen({super.key});

//   @override
//   State<AdminScreen> createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   bool _checkingRole = true;
//   bool _isAdmin = false;

//   @override
//   void initState() {
//     super.initState();

//     _checkAdminAccess();
//   }

//   // =========================================================
//   // CHECK ADMIN ROLE
//   // =========================================================

//   Future<void> _checkAdminAccess() async {
//     final auth = context.read<AuthProvider>();

//     try {
//       // Load the role from Firestore
//       await auth.loadUserRole();

//       if (!mounted) return;

//       setState(() {
//         _isAdmin = auth.isAdmin;
//         _checkingRole = false;
//       });

//       // -------------------------------------------------------
//       // USER IS NOT ADMIN
//       // -------------------------------------------------------

//       if (!auth.isAdmin) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Access denied. Admins only.')),
//         );

//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (_) => const HomeScreen()),
//           (route) => false,
//         );

//         return;
//       }

//       // -------------------------------------------------------
//       // ADMIN
//       // -------------------------------------------------------

//       await context.read<ProductProvider>().fetchProducts();
//     } catch (e) {
//       debugPrint('Admin access error: $e');

//       if (!mounted) return;

//       setState(() {
//         _checkingRole = false;
//         _isAdmin = false;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Unable to verify admin access.')),
//       );

//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//         (route) => false,
//       );
//     }
//   }

//   // =========================================================
//   // BUILD
//   // =========================================================

//   @override
//   Widget build(BuildContext context) {
//     // -------------------------------------------------------
//     // CHECKING ADMIN ROLE
//     // -------------------------------------------------------

//     if (_checkingRole) {
//       return const Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 20),
//               Text('Checking admin access...', style: TextStyle(fontSize: 16)),
//             ],
//           ),
//         ),
//       );
//     }

//     // -------------------------------------------------------
//     // ACCESS DENIED
//     // -------------------------------------------------------

//     if (!_isAdmin) {
//       return const Scaffold(
//         body: Center(
//           child: Text(
//             'Access Denied',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//         ),
//       );
//     }

//     // -------------------------------------------------------
//     // ADMIN DASHBOARD
//     // -------------------------------------------------------

//     final provider = context.watch<ProductProvider>();

//     return Scaffold(
//       // =====================================================
//       // APP BAR
//       // =====================================================
//       appBar: AppBar(
//         title: const Text(
//           'Admin Dashboard',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),

//         actions: [
//           // -------------------------------------------------
//           // MANAGE ORDERS
//           // -------------------------------------------------
//           IconButton(
//             tooltip: 'Manage Orders',
//             icon: const Icon(Icons.shopping_bag),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const AdminOrdersScreen()),
//               );
//             },
//           ),

//           // -------------------------------------------------
//           // REFRESH
//           // -------------------------------------------------
//           IconButton(
//             tooltip: 'Refresh',
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               provider.fetchProducts();
//             },
//           ),

//           // -------------------------------------------------
//           // LOGOUT
//           // -------------------------------------------------
//           IconButton(
//             tooltip: 'Logout',
//             icon: const Icon(Icons.logout),
//             onPressed: () async {
//               final auth = context.read<AuthProvider>();

//               await auth.logout();

//               if (!context.mounted) return;

//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (_) => const LoginScreen()),
//                 (route) => false,
//               );
//             },
//           ),
//         ],
//       ),

//       // =====================================================
//       // ADD PRODUCT BUTTON
//       // =====================================================
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const AddProductScreen()),
//           ).then((_) {
//             if (mounted) {
//               context.read<ProductProvider>().fetchProducts();
//             }
//           });
//         },
//         icon: const Icon(Icons.add),
//         label: const Text('Add Product'),
//       ),

//       // =====================================================
//       // PRODUCTS
//       // =====================================================
//       body: provider.isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.products.isEmpty
//           ? const Center(
//               child: Text('No products found.', style: TextStyle(fontSize: 18)),
//             )
//           : RefreshIndicator(
//               onRefresh: () {
//                 return provider.fetchProducts();
//               },
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: provider.products.length,
//                 itemBuilder: (context, index) {
//                   final product = provider.products[index];

//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 15),
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Row(
//                         children: [
//                           // =================================
//                           // PRODUCT IMAGE
//                           // =================================
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(12),
//                             child: Image.network(
//                               product.image,
//                               width: 80,
//                               height: 80,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   width: 80,
//                                   height: 80,
//                                   color: Colors.grey.shade200,
//                                   child: const Icon(Icons.image_not_supported),
//                                 );
//                               },
//                             ),
//                           ),

//                           const SizedBox(width: 12),

//                           // =================================
//                           // PRODUCT INFORMATION
//                           // =================================
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   product.name,
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: const TextStyle(
//                                     fontSize: 17,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 5),

//                                 Text(
//                                   '\$${product.price.toStringAsFixed(2)}',
//                                   style: const TextStyle(
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                   ),
//                                 ),

//                                 const SizedBox(height: 4),

//                                 Text(
//                                   product.category,
//                                   style: TextStyle(color: Colors.grey.shade600),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           // =================================
//                           // EDIT + DELETE
//                           // =================================
//                           Column(
//                             children: [
//                               // EDIT
//                               IconButton(
//                                 tooltip: 'Edit Product',
//                                 icon: const Icon(
//                                   Icons.edit,
//                                   color: Colors.blue,
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) =>
//                                           EditProductScreen(product: product),
//                                     ),
//                                   ).then((_) {
//                                     if (mounted) {
//                                       // ignore: use_build_context_synchronously
//                                       context
//                                           .read<ProductProvider>()
//                                           .fetchProducts();
//                                     }
//                                   });
//                                 },
//                               ),

//                               // DELETE
//                               IconButton(
//                                 tooltip: 'Delete Product',
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                                 onPressed: () {
//                                   _confirmDelete(
//                                     context,
//                                     product.id,
//                                     product.name,
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//     );
//   }

//   // =========================================================
//   // CONFIRM DELETE
//   // =========================================================

//   void _confirmDelete(
//     BuildContext context,
//     String productId,
//     String productName,
//   ) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text('Delete Product'),
//           content: Text('Are you sure you want to delete "$productName"?'),
//           actions: [
//             // CANCEL
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext);
//               },
//               child: const Text('Cancel'),
//             ),

//             // DELETE
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//               ),
//               onPressed: () async {
//                 Navigator.pop(dialogContext);

//                 try {
//                   await context.read<ProductProvider>().deleteProduct(
//                     productId,
//                   );

//                   if (!context.mounted) return;

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('Product deleted successfully!'),
//                     ),
//                   );
//                 } catch (e) {
//                   if (!context.mounted) return;

//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(SnackBar(content: Text('Error: $e')));
//                 }
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/product_provider.dart';

import 'add_product_screen.dart';
import 'edit_product_screen.dart';
import 'admin_orders_screen.dart';
import 'home_screen.dart';
import 'auth/login_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool _checkingRole = true;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkAdminAccess();
  }

  // =========================================================
  // CHECK ADMIN ACCESS
  // =========================================================

  Future<void> _checkAdminAccess() async {
    final auth = context.read<AuthProvider>();

    try {
      await auth.loadUserRole();

      if (!mounted) return;

      setState(() {
        _isAdmin = auth.isAdmin;
        _checkingRole = false;
      });

      if (!auth.isAdmin) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Access denied. Admins only.'),
          ),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
          (route) => false,
        );

        return;
      }

      await context.read<ProductProvider>().fetchProducts();
    } catch (e) {
      debugPrint('Admin access error: $e');

      if (!mounted) return;

      setState(() {
        _checkingRole = false;
        _isAdmin = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to verify admin access.'),
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
        (route) => false,
      );
    }
  }

  // =========================================================
  // REFRESH PRODUCTS
  // =========================================================

  Future<void> _refreshProducts() async {
    await context.read<ProductProvider>().fetchProducts();
  }

  // =========================================================
  // LOGOUT
  // =========================================================

  Future<void> _logout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final colors = Theme.of(dialogContext).colorScheme;

        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout from the admin panel?',
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
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) return;

    final auth = context.read<AuthProvider>();

    await auth.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }

  // =========================================================
  // OPEN ADD PRODUCT
  // =========================================================

  Future<void> _addProduct() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      ),
    );

    if (!mounted) return;

    await _refreshProducts();
  }

  // =========================================================
  // OPEN EDIT PRODUCT
  // =========================================================

  Future<void> _editProduct(dynamic product) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProductScreen(
          product: product,
        ),
      ),
    );

    if (!mounted) return;

    await _refreshProducts();
  }

  // =========================================================
  // DELETE PRODUCT
  // =========================================================

  Future<void> _confirmDelete(
    String productId,
    String productName,
  ) async {
    final colors = Theme.of(context).colorScheme;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.delete_forever_rounded,
            color: colors.error,
            size: 42,
          ),
          title: const Text(
            'Delete Product?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "$productName"?\n\n'
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

    if (shouldDelete != true) return;

    try {
      await context
          .read<ProductProvider>()
          .deleteProduct(productId);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Product deleted successfully.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to delete product: $e',
          ),
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
    if (_checkingRole) {
      return _buildCheckingScreen();
    }

    if (!_isAdmin) {
      return _buildAccessDeniedScreen();
    }

    return _buildDashboard();
  }

  // =========================================================
  // CHECKING SCREEN
  // =========================================================

  Widget _buildCheckingScreen() {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.admin_panel_settings_rounded,
                  size: 48,
                  color: colors.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text(
                'Checking admin access...',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please wait while we verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // ACCESS DENIED SCREEN
  // =========================================================

  Widget _buildAccessDeniedScreen() {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 80,
                color: colors.error,
              ),
              const SizedBox(height: 20),
              const Text(
                'Access Denied',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You do not have permission to access the admin dashboard.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // MAIN DASHBOARD
  // =========================================================

  Widget _buildDashboard() {
    final provider = context.watch<ProductProvider>();
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                Icons.admin_panel_settings_rounded,
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Admin Dashboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Manage Orders',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminOrdersScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_bag_outlined,
            ),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: provider.isLoading
                ? null
                : _refreshProducts,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
          IconButton(
            tooltip: 'Logout',
            onPressed: _logout,
            icon: const Icon(
              Icons.logout_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: provider.isLoading ? null : _addProduct,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Product',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                18,
                16,
                100,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _buildWelcomeHeader(),
                    const SizedBox(height: 20),
                    _buildStatistics(provider),
                    const SizedBox(height: 24),
                    _buildQuickActions(),
                    const SizedBox(height: 28),
                    _buildProductsHeader(provider),
                    const SizedBox(height: 14),
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
            else if (provider.products.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildEmptyProducts(),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  20,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final product = provider.products[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: _buildProductCard(product),
                      );
                    },
                    childCount: provider.products.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // WELCOME HEADER
  // =========================================================

  Widget _buildWelcomeHeader() {
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
            color: colors.primary.withValues(alpha: 0.22),
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
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
            child: const Icon(
              Icons.admin_panel_settings_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Administrator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Manage your E-Commerce store',
                  style: TextStyle(
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

  Widget _buildStatistics(ProductProvider provider) {
    final productCount = provider.products.length;

    final categories = provider.products
        .map((product) => product.category.trim().toLowerCase())
        .where((category) => category.isNotEmpty)
        .toSet()
        .length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.inventory_2_outlined,
            title: 'Products',
            value: productCount.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.category_outlined,
            title: 'Categories',
            value: categories.toString(),
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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: colors.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.onSurfaceVariant,
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
  // QUICK ACTIONS
  // =========================================================

  Widget _buildQuickActions() {
    // final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.add_box_outlined,
                title: 'Add Product',
                subtitle: 'Create new product',
                onTap: _addProduct,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                icon: Icons.receipt_long_outlined,
                title: 'Orders',
                subtitle: 'Manage customer orders',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminOrdersScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: colors.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // PRODUCTS HEADER
  // =========================================================

  Widget _buildProductsHeader(ProductProvider provider) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        const Expanded(
          child: Text(
            'Product Management',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: colors.primaryContainer,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '${provider.products.length} items',
            style: TextStyle(
              color: colors.onPrimaryContainer,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // PRODUCT CARD
  // =========================================================

  Widget _buildProductCard(dynamic product) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 92,
                height: 92,
                color: colors.surface,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: colors.onSurfaceVariant,
                        size: 32,
                      ),
                    );
                  },
                  loadingBuilder: (
                    context,
                    child,
                    loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: loadingProgress
                                      .expectedTotalBytes !=
                                  null
                              ? loadingProgress
                                      .cumulativeBytesLoaded /
                                  loadingProgress
                                      .expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 14),

            // PRODUCT INFORMATION
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: colors.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      product.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.onPrimaryContainer,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ACTIONS
            Column(
              children: [
                IconButton(
                  tooltip: 'Edit Product',
                  style: IconButton.styleFrom(
                    backgroundColor:
                        colors.primaryContainer,
                  ),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: colors.onPrimaryContainer,
                    size: 20,
                  ),
                  onPressed: () {
                    _editProduct(product);
                  },
                ),
                IconButton(
                  tooltip: 'Delete Product',
                  style: IconButton.styleFrom(
                    backgroundColor:
                        colors.errorContainer,
                  ),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: colors.onErrorContainer,
                    size: 20,
                  ),
                  onPressed: () {
                    _confirmDelete(
                      product.id,
                      product.name,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY PRODUCTS
  // =========================================================

  Widget _buildEmptyProducts() {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: colors.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 44,
                color: colors.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'No Products Yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start building your store by adding your first product.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _addProduct,
              icon: const Icon(Icons.add),
              label: const Text('Add First Product'),
            ),
          ],
        ),
      ),
    );
  }
}
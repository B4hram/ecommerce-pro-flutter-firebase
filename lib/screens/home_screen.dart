// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/product_provider.dart';

// import '../widgets/home_search_bar.dart';
// // import '../widgets/category_card.dart';
// import '../widgets/product_card.dart';

// import 'product_details_screen.dart';
// import 'cart_screen.dart';
// import 'wishlist_screen.dart';
// import 'order_history_screen.dart';
// import 'profile_screen.dart';
// import 'filter_screen.dart';

// import '../providers/cart_provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     super.key,
//   });

//   @override
//   State<HomeScreen> createState() =>
//       _HomeScreenState();
// }

// class _HomeScreenState
//     extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context
//           .read<ProductProvider>()
//           .fetchProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider =
//         context.watch<ProductProvider>();

//     final products =
//         provider.filteredProducts;

//         final cart =
//     context.watch<CartProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'E-Commerce Pro',
//         ),

//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.favorite,
//               color: Colors.red,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       const WishlistScreen(),
//                 ),
//               );
//             },
//           ),

//           IconButton(
//             icon: const Icon(
//               Icons.receipt_long,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       const OrderHistoryScreen(),
//                 ),
//               );
//             },
//           ),

//           IconButton(
//             icon: const Icon(
//               Icons.person,
//             ),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       const ProfileScreen(),
//                 ),
//               );
//             },
//           ),

//           // IconButton(
//           //   icon: const Icon(
//           //     Icons.shopping_cart,
//           //   ),
//           //   onPressed: () {
//           //     Navigator.push(
//           //       context,
//           //       MaterialPageRoute(
//           //         builder: (_) =>
//           //             const CartScreen(),
//           //       ),
//           //     );
//           //   },
//           // ),
//           Stack(
//   children: [
//     IconButton(
//       icon: const Icon(
//         Icons.shopping_cart,
//       ),
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) =>
//                 const CartScreen(),
//           ),
//         );
//       },
//     ),

//     if (cart.itemCount > 0)
//       Positioned(
//         right: 5,
//         top: 5,
//         child: Container(
//           padding:
//               const EdgeInsets.all(4),
//           decoration:
//               const BoxDecoration(
//             color: Colors.red,
//             shape: BoxShape.circle,
//           ),
//           constraints:
//               const BoxConstraints(
//             minWidth: 18,
//             minHeight: 18,
//           ),
//           child: Text(
//             cart.itemCount > 99
//                 ? '99+'
//                 : cart.itemCount.toString(),
//             textAlign:
//                 TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 10,
//               fontWeight:
//                   FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//   ],
// ),

//         ],
//       ),

//       body: Column(
//         children: [
//           Padding(
//             padding:
//                 const EdgeInsets.fromLTRB(
//               16,
//               16,
//               16,
//               0,
//             ),
//             child: Row(
//               children: [
//                 const Expanded(
//                   child:
//                       HomeSearchBar(),
//                 ),

//                 const SizedBox(
//                   width: 10,
//                 ),

//                 Container(
//                   decoration:
//                       BoxDecoration(
//                     color: Colors
//                         .deepPurple
//                         .withOpacity(
//                       0.1,
//                     ),
//                     borderRadius:
//                         BorderRadius
//                             .circular(
//                       15,
//                     ),
//                   ),
//                   child: IconButton(
//                     icon: const Icon(
//                       Icons.tune,
//                     ),
//                     color:
//                         Colors.deepPurple,
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               const FilterScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(
//             height: 15,
//           ),

//           // CATEGORY SECTION
//           SizedBox(
//             height: 60,
//             child: ListView(
//               padding:
//                   const EdgeInsets.symmetric(
//                 horizontal: 16,
//               ),
//               scrollDirection:
//                   Axis.horizontal,
//               children: [
//                 _categoryButton(
//                   'All',
//                   provider,
//                 ),
//                 _categoryButton(
//                   'Phones',
//                   provider,
//                 ),
//                 _categoryButton(
//                   'Laptops',
//                   provider,
//                 ),
//                 _categoryButton(
//                   'Shoes',
//                   provider,
//                 ),
//                 _categoryButton(
//                   'Fashion',
//                   provider,
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(
//             height: 10,
//           ),

//           // RESULTS COUNT
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(
//               horizontal: 16,
//             ),
//             child: Row(
//               children: [
//                 Text(
//                   '${products.length} Products',
//                   style:
//                       const TextStyle(
//                     fontSize: 17,
//                     fontWeight:
//                         FontWeight.bold,
//                   ),
//                 ),

//                 const Spacer(),

//                 if (provider
//                         .selectedCategory !=
//                     'All')
//                   Text(
//                     provider
//                         .selectedCategory,
//                     style:
//                         const TextStyle(
//                       color:
//                           Colors.deepPurple,
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           const SizedBox(
//             height: 10,
//           ),

//           // PRODUCTS
//           Expanded(
//             child: provider.isLoading
//                 ? const Center(
//                     child:
//                         CircularProgressIndicator(),
//                   )
//                 : products.isEmpty
//                     ? _emptyProducts()
//                     : GridView.builder(
//                         padding:
//                             const EdgeInsets
//                                 .all(
//                           16,
//                         ),
//                         itemCount:
//                             products.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount:
//                               2,
//                           crossAxisSpacing:
//                               12,
//                           mainAxisSpacing:
//                               12,
//                           childAspectRatio:
//                               0.68,
//                         ),
//                         itemBuilder:
//                             (context, index) {
//                           final product =
//                               products[index];

//                           return ProductCard(
//                             product:
//                                 product,
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder:
//                                       (_) =>
//                                           ProductDetailsScreen(
//                                     product:
//                                         product,
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _categoryButton(
//     String category,
//     ProductProvider provider,
//   ) {
//     final selected =
//         provider.selectedCategory ==
//             category;

//     return Padding(
//       padding:
//           const EdgeInsets.only(
//         right: 10,
//       ),
//       child: ChoiceChip(
//         label: Text(category),
//         selected: selected,
//         onSelected: (_) {
//           provider.setCategory(
//             category,
//           );
//         },
//       ),
//     );
//   }

//   Widget _emptyProducts() {
//     return Center(
//       child: Column(
//         mainAxisAlignment:
//             MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.search_off,
//             size: 80,
//             color: Colors.grey.shade400,
//           ),

//           const SizedBox(
//             height: 15,
//           ),

//           const Text(
//             'No Products Found',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight:
//                   FontWeight.bold,
//             ),
//           ),

//           const SizedBox(
//             height: 8,
//           ),

//           Text(
//             'Try another search or filter.',
//             style: TextStyle(
//               color:
//                   Colors.grey.shade600,
//             ),
//           ),

//           const SizedBox(
//             height: 20,
//           ),

//           ElevatedButton(
//             onPressed: () {
//               context
//                   .read<ProductProvider>()
//                   .clearFilters();
//             },
//             child: const Text(
//               'Clear Filters',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

import '../widgets/home_search_bar.dart';
import '../widgets/product_card.dart';

import 'product_details_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'order_history_screen.dart';
import 'profile_screen.dart';
import 'filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final productProvider = context.watch<ProductProvider>();

    final cartProvider = context.watch<CartProvider>();

    final products = productProvider.filteredProducts;

    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // ============================================================
      // APP BAR
      // ============================================================
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: theme.scaffoldBackgroundColor,

        surfaceTintColor: Colors.transparent,

        elevation: 0,

        titleSpacing: 20,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back 👋',
              style: TextStyle(
                fontSize: 13,
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.65),
              ),
            ),

            const SizedBox(height: 2),

            Text(
              'E-Commerce Pro',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),

        actions: [
          // ========================================================
          // WISHLIST
          // ========================================================
          _topIconButton(
            context,
            icon: Icons.favorite_border_rounded,
            tooltip: 'Wishlist',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
          ),

          // ========================================================
          // ORDERS
          // ========================================================
          _topIconButton(
            context,
            icon: Icons.receipt_long_outlined,
            tooltip: 'My Orders',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrderHistoryScreen()),
              );
            },
          ),

          // ========================================================
          // CART
          // ========================================================
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _topIconButton(
                  context,
                  icon: Icons.shopping_bag_outlined,
                  tooltip: 'Cart',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    );
                  },
                ),

                if (cartProvider.itemCount > 0)
                  Positioned(
                    right: 1,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        cartProvider.itemCount > 99
                            ? '99+'
                            : cartProvider.itemCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // ========================================================
          // PROFILE
          // ========================================================
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  color: colorScheme.primary,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),

      // ============================================================
      // BODY
      // ============================================================
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await productProvider.fetchProducts();
          },

          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

            slivers: [
              // ====================================================
              // SEARCH + FILTER
              // ====================================================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  isDark ? 0.15 : 0.05,
                                ),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const HomeSearchBar(),
                        ),
                      ),

                      const SizedBox(width: 10),

                      // FILTER BUTTON
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: IconButton(
                          tooltip: 'Filter',
                          icon: const Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FilterScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ====================================================
              // FEATURE BANNER
              // ====================================================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 5),
                  child: _buildPromoBanner(context),
                ),
              ),

              // ====================================================
              // CATEGORY TITLE
              // ====================================================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Row(
                    children: [
                      Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ====================================================
              // CATEGORIES
              // ====================================================
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 92,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _categoryItem(
                        context,
                        category: 'All',
                        icon: Icons.apps_rounded,
                        provider: productProvider,
                      ),

                      _categoryItem(
                        context,
                        category: 'Phones',
                        icon: Icons.smartphone_rounded,
                        provider: productProvider,
                      ),

                      _categoryItem(
                        context,
                        category: 'Laptops',
                        icon: Icons.laptop_mac_rounded,
                        provider: productProvider,
                      ),

                      _categoryItem(
                        context,
                        category: 'Shoes',
                        icon: Icons.directions_run_rounded,
                        provider: productProvider,
                      ),

                      _categoryItem(
                        context,
                        category: 'Fashion',
                        icon: Icons.checkroom_rounded,
                        provider: productProvider,
                      ),
                    ],
                  ),
                ),
              ),

              // ====================================================
              // PRODUCTS HEADER
              // ====================================================
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Popular Products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${products.length}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),

                      const Spacer(),

                      if (productProvider.selectedCategory != 'All')
                        Text(
                          productProvider.selectedCategory,
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // ====================================================
              // PRODUCTS
              // ====================================================
              if (productProvider.isLoading)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (products.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _emptyProducts(context),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final product = products[index];

                      return ProductCard(
                        product: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                      );
                    }, childCount: products.length),

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.64,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ==============================================================
  // TOP ICON BUTTON
  // ==============================================================

  Widget _topIconButton(
    BuildContext context, {
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: theme.colorScheme.onSurface.withOpacity(0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      icon: Icon(icon, size: 22, color: theme.colorScheme.onSurface),
    );
  }

  // ==============================================================
  // PROMOTION BANNER
  // ==============================================================

  Widget _buildPromoBanner(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      height: 155,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [colorScheme.primary, colorScheme.primary.withOpacity(0.78)],
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
      child: Stack(
        children: [
          // DECORATIVE CIRCLE
          Positioned(
            right: -35,
            top: -45,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

          Positioned(
            right: 35,
            bottom: -65,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'SPECIAL OFFER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Discover something\namazing today!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Shop premium products at great prices.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.80),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 20,
            bottom: 18,
            child: Icon(
              Icons.shopping_bag_rounded,
              size: 55,
              color: Colors.white.withOpacity(0.16),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // CATEGORY ITEM
  // ==============================================================

  Widget _categoryItem(
    BuildContext context, {
    required String category,
    required IconData icon,
    required ProductProvider provider,
  }) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    final selected = provider.selectedCategory == category;

    return GestureDetector(
      onTap: () {
        provider.setCategory(category);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 76,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? colorScheme.primary
                : colorScheme.onSurface.withOpacity(0.06),
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.20),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: selected ? Colors.white : colorScheme.primary,
            ),

            const SizedBox(height: 7),

            Text(
              category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: selected ? Colors.white : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // EMPTY PRODUCTS
  // ==============================================================

  Widget _emptyProducts(BuildContext context) {
    final theme = Theme.of(context);

    final colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 48,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'No Products Found',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Try another search or change your filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurface.withOpacity(0.60),
              ),
            ),

            const SizedBox(height: 22),

            ElevatedButton.icon(
              onPressed: () {
                context.read<ProductProvider>().clearFilters();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Clear Filters'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

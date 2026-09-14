// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';

// import '../providers/theme_provider.dart';
// import '../providers/user_provider.dart';

// import 'auth/login_screen.dart';
// import 'admin_screen.dart';
// import 'edit_profile_screen.dart';

// import 'order_history_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();

//     _loadUser();
//   }

//   Future<void> _loadUser() async {
//     final firebaseUser = FirebaseAuth.instance.currentUser;

//     if (firebaseUser != null) {
//       await context.read<UserProvider>().loadUser(firebaseUser.uid);

//       if (mounted) {
//         setState(() {});
//       }
//     }
//   }

//   Future<void> _openEditProfile() async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (_) => const EditProfileScreen()),
//     );

//     // Reload profile after returning
//     await _loadUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final firebaseUser = FirebaseAuth.instance.currentUser;

//     final userProvider = context.watch<UserProvider>();

//     final userData = userProvider.user;

//     // Get name from Firestore first.
//     // If unavailable, use Firebase Auth.
//     final name = userData?.name.isNotEmpty == true
//         ? userData!.name
//         : (firebaseUser?.displayName ?? 'User');

//     // Get image from Firestore first.
//     // If unavailable, use Firebase Auth.
//     final image = userData?.image.isNotEmpty == true
//         ? userData!.image
//         : (firebaseUser?.photoURL ?? '');

//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,

//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),

//       body: RefreshIndicator(
//         onRefresh: _loadUser,

//         child: ListView(
//           padding: const EdgeInsets.all(20),

//           children: [
//             // ======================================
//             // PROFILE HEADER
//             // ======================================
//             Container(
//               padding: const EdgeInsets.all(20),

//               decoration: BoxDecoration(
//                 // color: Colors.white,
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
//                 children: [
//                   // PROFILE PHOTO
//                   Container(
//                     width: 110,
//                     height: 110,

//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,

//                       border: Border.all(color: Colors.deepPurple, width: 3),
//                     ),

//                     child: ClipOval(
//                       child: image.isNotEmpty
//                           ? Image.network(
//                               image,
//                               fit: BoxFit.cover,

//                               errorBuilder: (context, error, stackTrace) {
//                                 return const Icon(
//                                   Icons.person,
//                                   size: 60,
//                                   color: Colors.deepPurple,
//                                 );
//                               },
//                             )
//                           : const Icon(
//                               Icons.person,
//                               size: 60,
//                               color: Colors.deepPurple,
//                             ),
//                     ),
//                   ),

//                   const SizedBox(height: 15),

//                   // NAME
//                   Text(
//                     name,
//                     textAlign: TextAlign.center,

//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   // EMAIL
//                   Text(
//                     firebaseUser?.email ?? 'No Email',

//                     style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
//                   ),

//                   const SizedBox(height: 18),

//                   // EDIT PROFILE
//                   SizedBox(
//                     width: double.infinity,

//                     child: ElevatedButton.icon(
//                       onPressed: _openEditProfile,

//                       icon: const Icon(Icons.edit),

//                       label: const Text('Edit Profile'),

//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         foregroundColor: Colors.white,

//                         padding: const EdgeInsets.symmetric(vertical: 13),

//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   ListTile(
//                     leading: const Icon(Icons.shopping_bag),
//                     title: const Text('My Orders'),
//                     subtitle: const Text('View and track your orders'),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const OrderHistoryScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             // ======================================
//             // ADMIN
//             // ======================================
//             Container(
//               decoration: _cardDecoration(),

//               child: ListTile(
//                 leading: Container(
//                   width: 45,
//                   height: 45,

//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),

//                   child: const Icon(
//                     Icons.admin_panel_settings,
//                     color: Colors.deepPurple,
//                   ),
//                 ),

//                 title: const Text(
//                   'Admin Dashboard',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),

//                 subtitle: const Text('Manage your products'),

//                 trailing: const Icon(Icons.chevron_right),

//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (_) => const AdminScreen()),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: 12),

//             // ======================================
//             // DARK MODE
//             // ======================================
//             Container(
//               decoration: _cardDecoration(),

//               child: SwitchListTile(
//                 secondary: Container(
//                   width: 45,
//                   height: 45,

//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple.withOpacity(0.1),

//                     borderRadius: BorderRadius.circular(12),
//                   ),

//                   child: const Icon(Icons.dark_mode, color: Colors.deepPurple),
//                 ),

//                 title: const Text(
//                   'Dark Mode',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),

//                 subtitle: const Text('Change app appearance'),

//                 value: context.watch<ThemeProvider>().isDark,

//                 onChanged: (_) {
//                   context.read<ThemeProvider>().toggleTheme();
//                 },
//               ),
//             ),

//             const SizedBox(height: 12),

//             // ======================================
//             // ACCOUNT INFORMATION
//             // ======================================
//             Container(
//               padding: const EdgeInsets.all(18),

//               decoration: _cardDecoration(),

//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,

//                 children: [
//                   const Text(
//                     'Account Information',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 15),

//                   _infoRow(Icons.person, 'Name', name),

//                   const Divider(),

//                   _infoRow(
//                     Icons.email,
//                     'Email',
//                     firebaseUser?.email ?? 'No Email',
//                   ),

//                   const Divider(),

//                   _infoRow(
//                     Icons.fingerprint,
//                     'User ID',
//                     firebaseUser?.uid ?? '',
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 25),

//             // ======================================
//             // LOGOUT
//             // ======================================
//             SizedBox(
//               height: 52,

//               child: OutlinedButton.icon(
//                 onPressed: () async {
//                   await FirebaseAuth.instance.signOut();

//                   if (!context.mounted) {
//                     return;
//                   }

//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (_) => LoginScreen()),
//                     (route) => false,
//                   );
//                 },

//                 icon: const Icon(Icons.logout, color: Colors.red),

//                 label: const Text(
//                   'Logout',
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Colors.red),

//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(14),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   // ==========================================
//   // INFO ROW
//   // ==========================================

//   Widget _infoRow(IconData icon, String title, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,

//       children: [
//         Icon(icon, size: 21, color: Colors.deepPurple),

//         const SizedBox(width: 12),

//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               Text(
//                 title,
//                 style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
//               ),

//               const SizedBox(height: 3),

//               Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ==========================================
//   // CARD DECORATION
//   // ==========================================

//   BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: Colors.white,

//       borderRadius: BorderRadius.circular(18),

//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.04),
//           blurRadius: 8,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/auth_provider.dart';
// import '../providers/theme_provider.dart';

// import 'auth/login_screen.dart';
// import 'order_history_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;

//     final auth = context.watch<AuthProvider>();
//     final themeProvider = context.watch<ThemeProvider>();

//     final user = auth.user;

//     final String email = user?.email ?? 'No email';

//     final String displayName = user?.displayName?.isNotEmpty == true
//         ? user!.displayName!
//         : email.split('@').first;

//     return Scaffold(
//       backgroundColor: colors.surface,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: colors.surface,
//         foregroundColor: colors.onSurface,
//         title: const Text(
//           'Profile',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               // =========================================================
//               // PROFILE HEADER
//               // =========================================================
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),

//                 decoration: BoxDecoration(
//                   color: colors.surfaceContainerHighest,
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     if (theme.brightness == Brightness.light)
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.08),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                   ],
//                 ),

//                 child: Column(
//                   children: [
//                     // PROFILE ICON
//                     Container(
//                       width: 90,
//                       height: 90,

//                       decoration: BoxDecoration(
//                         color: colors.primaryContainer,
//                         shape: BoxShape.circle,
//                       ),

//                       child: Icon(
//                         Icons.person,
//                         size: 55,
//                         color: colors.onPrimaryContainer,
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     // NAME
//                     Text(
//                       displayName,
//                       textAlign: TextAlign.center,

//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                         color: colors.onSurface,
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     // EMAIL
//                     Text(
//                       email,
//                       textAlign: TextAlign.center,

//                       style: TextStyle(
//                         fontSize: 15,
//                         color: colors.onSurfaceVariant,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // EDIT PROFILE BUTTON
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,

//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text(
//                                 'Edit Profile feature can be added here.',
//                               ),
//                             ),
//                           );
//                         },

//                         icon: const Icon(Icons.edit),

//                         label: const Text(
//                           'Edit Profile',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),

//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: colors.primary,
//                           foregroundColor: colors.onPrimary,

//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(14),
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     // =====================================================
//                     // MY ORDERS
//                     // =====================================================
//                     InkWell(
//                       borderRadius: BorderRadius.circular(15),

//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const OrderHistoryScreen(),
//                           ),
//                         );
//                       },

//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),

//                         child: Row(
//                           children: [
//                             Container(
//                               width: 45,
//                               height: 45,

//                               decoration: BoxDecoration(
//                                 color: colors.primaryContainer,
//                                 borderRadius: BorderRadius.circular(12),
//                               ),

//                               child: Icon(
//                                 Icons.shopping_bag,
//                                 color: colors.onPrimaryContainer,
//                               ),
//                             ),

//                             const SizedBox(width: 15),

//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,

//                                 children: [
//                                   Text(
//                                     'My Orders',

//                                     style: TextStyle(
//                                       fontSize: 17,
//                                       fontWeight: FontWeight.bold,
//                                       color: colors.onSurface,
//                                     ),
//                                   ),

//                                   const SizedBox(height: 3),

//                                   Text(
//                                     'View and track your orders',

//                                     style: TextStyle(
//                                       color: colors.onSurfaceVariant,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             Icon(
//                               Icons.arrow_forward_ios,
//                               size: 17,
//                               color: colors.onSurfaceVariant,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // =========================================================
//               // ADMIN DASHBOARD
//               // =========================================================
//               if (auth.isAdmin)
//                 _buildMenuCard(
//                   context: context,
//                   icon: Icons.admin_panel_settings,
//                   title: 'Admin Dashboard',
//                   subtitle: 'Manage products and orders',
//                   onTap: () {
//                     Navigator.pushNamed(context, '/admin');
//                   },
//                 ),

//               if (auth.isAdmin) const SizedBox(height: 12),

//               // =========================================================
//               // DARK MODE
//               // =========================================================
//               Container(
//                 width: double.infinity,

//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 12,
//                 ),

//                 decoration: BoxDecoration(
//                   color: colors.surfaceContainerHighest,
//                   borderRadius: BorderRadius.circular(18),
//                 ),

//                 child: Row(
//                   children: [
//                     Container(
//                       width: 45,
//                       height: 45,

//                       decoration: BoxDecoration(
//                         color: colors.primaryContainer,
//                         borderRadius: BorderRadius.circular(12),
//                       ),

//                       child: Icon(
//                         theme.brightness == Brightness.dark
//                             ? Icons.dark_mode
//                             : Icons.light_mode,
//                         color: colors.onPrimaryContainer,
//                       ),
//                     ),

//                     const SizedBox(width: 15),

//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,

//                         children: [
//                           Text(
//                             'Dark Mode',

//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: colors.onSurface,
//                             ),
//                           ),

//                           const SizedBox(height: 3),

//                           Text(
//                             theme.brightness == Brightness.dark
//                                 ? 'Dark theme is enabled'
//                                 : 'Use dark theme',

//                             style: TextStyle(
//                               fontSize: 13,
//                               color: colors.onSurfaceVariant,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     Switch(
//                       value: theme.brightness == Brightness.dark,

//                       onChanged: (value) {
//                         themeProvider.toggleTheme();
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // =========================================================
//               // ACCOUNT INFORMATION
//               // =========================================================
//               Container(
//                 width: double.infinity,

//                 padding: const EdgeInsets.all(20),

//                 decoration: BoxDecoration(
//                   color: colors.surfaceContainerHighest,
//                   borderRadius: BorderRadius.circular(20),
//                 ),

//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,

//                   children: [
//                     Text(
//                       'Account Information',

//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: colors.onSurface,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     // NAME
//                     _buildInformationRow(
//                       context,
//                       Icons.person,
//                       'Name',
//                       displayName,
//                     ),

//                     const SizedBox(height: 18),

//                     // EMAIL
//                     _buildInformationRow(context, Icons.email, 'Email', email),

//                     const SizedBox(height: 18),

//                     // USER ID
//                     _buildInformationRow(
//                       context,
//                       Icons.fingerprint,
//                       'User ID',
//                       user?.uid ?? 'Not available',
//                     ),

//                     const SizedBox(height: 18),

//                     // ROLE
//                     _buildInformationRow(
//                       context,
//                       auth.isAdmin
//                           ? Icons.admin_panel_settings
//                           : Icons.person_outline,
//                       'Role',
//                       auth.isAdmin ? 'Administrator' : 'User',
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // =========================================================
//               // LOGOUT BUTTON
//               // =========================================================
//               SizedBox(
//                 width: double.infinity,
//                 height: 52,

//                 child: OutlinedButton.icon(
//                   onPressed: () async {
//                     await _logout(context);
//                   },

//                   icon: const Icon(Icons.logout),

//                   label: const Text(
//                     'Logout',
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),

//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: colors.error,

//                     side: BorderSide(color: colors.error),

//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ================================================================
//   // MENU CARD
//   // ================================================================

//   Widget _buildMenuCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     final colors = Theme.of(context).colorScheme;

//     return Material(
//       color: colors.surfaceContainerHighest,

//       borderRadius: BorderRadius.circular(18),

//       child: InkWell(
//         borderRadius: BorderRadius.circular(18),

//         onTap: onTap,

//         child: Padding(
//           padding: const EdgeInsets.all(16),

//           child: Row(
//             children: [
//               Container(
//                 width: 45,
//                 height: 45,

//                 decoration: BoxDecoration(
//                   color: colors.primaryContainer,
//                   borderRadius: BorderRadius.circular(12),
//                 ),

//                 child: Icon(icon, color: colors.onPrimaryContainer),
//               ),

//               const SizedBox(width: 15),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,

//                   children: [
//                     Text(
//                       title,

//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: colors.onSurface,
//                       ),
//                     ),

//                     const SizedBox(height: 3),

//                     Text(
//                       subtitle,

//                       style: TextStyle(
//                         fontSize: 13,
//                         color: colors.onSurfaceVariant,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Icon(
//                 Icons.arrow_forward_ios,
//                 size: 16,
//                 color: colors.onSurfaceVariant,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ================================================================
//   // ACCOUNT INFORMATION ROW
//   // ================================================================

//   Widget _buildInformationRow(
//     BuildContext context,
//     IconData icon,
//     String title,
//     String value,
//   ) {
//     final colors = Theme.of(context).colorScheme;

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,

//       children: [
//         Icon(icon, color: colors.primary, size: 22),

//         const SizedBox(width: 15),

//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,

//             children: [
//               Text(
//                 title,

//                 style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
//               ),

//               const SizedBox(height: 4),

//               Text(
//                 value,

//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,

//                 style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: colors.onSurface,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ================================================================
//   // LOGOUT
//   // ================================================================

//   Future<void> _logout(BuildContext context) async {
//     final auth = context.read<AuthProvider>();

//     final shouldLogout = await showDialog<bool>(
//       context: context,

//       builder: (dialogContext) {
//         final colors = Theme.of(dialogContext).colorScheme;

//         return AlertDialog(
//           backgroundColor: colors.surface,

//           title: Text(
//             'Logout',
//             style: TextStyle(
//               color: colors.onSurface,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           content: Text(
//             'Are you sure you want to logout?',
//             style: TextStyle(color: colors.onSurfaceVariant),
//           ),

//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, false);
//               },

//               child: const Text('Cancel'),
//             ),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, true);
//               },

//               style: ElevatedButton.styleFrom(
//                 backgroundColor: colors.error,
//                 foregroundColor: colors.onError,
//               ),

//               child: const Text('Logout'),
//             ),
//           ],
//         );
//       },
//     );

//     if (shouldLogout != true) {
//       return;
//     }

//     await auth.logout();

//     if (!context.mounted) {
//       return;
//     }

//     Navigator.pushAndRemoveUntil(
//       context,

//       MaterialPageRoute(builder: (_) => const LoginScreen()),

//       (route) => false,
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/auth_provider.dart';
// import '../providers/theme_provider.dart';

// import 'auth/login_screen.dart';
// import 'order_history_screen.dart';
// import 'admin_screen.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final colors = theme.colorScheme;

//     final auth = context.watch<AuthProvider>();
//     final themeProvider = context.watch<ThemeProvider>();

//     final user = auth.user;

//     final email = user?.email ?? 'No email';

//     final displayName = user?.displayName?.trim().isNotEmpty == true
//         ? user!.displayName!.trim()
//         : email.contains('@')
//             ? email.split('@').first
//             : 'User';

//     final isDarkMode = theme.brightness == Brightness.dark;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () async {
//             await auth.refreshUser();
//           },
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(
//               parent: BouncingScrollPhysics(),
//             ),
//             padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ==========================================================
//                 // PROFILE HEADER
//                 // ==========================================================

//                 _buildProfileHeader(
//                   context,
//                   displayName: displayName,
//                   email: email,
//                   isAdmin: auth.isAdmin,
//                 ),

//                 const SizedBox(height: 24),

//                 // ==========================================================
//                 // ACCOUNT MENU
//                 // ==========================================================

//                 const Text(
//                   'Account',
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),

//                 const SizedBox(height: 14),

//                 _buildMenuCard(
//                   context,
//                   icon: Icons.shopping_bag_rounded,
//                   title: 'My Orders',
//                   subtitle: 'View and track your orders',
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => const OrderHistoryScreen(),
//                       ),
//                     );
//                   },
//                 ),

//                 const SizedBox(height: 12),

//                 _buildMenuCard(
//                   context,
//                   icon: Icons.edit_rounded,
//                   title: 'Edit Profile',
//                   subtitle: 'Update your profile information',
//                   onTap: () {
//                     _showEditProfileMessage(context);
//                   },
//                 ),

//                 if (auth.isAdmin) ...[
//                   const SizedBox(height: 12),

//                   _buildMenuCard(
//                     context,
//                     icon: Icons.admin_panel_settings_rounded,
//                     title: 'Admin Dashboard',
//                     subtitle: 'Manage products and orders',
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const AdminScreen(),
//                         ),
//                       );
//                     },
//                     isAdmin: true,
//                   ),
//                 ],

//                 const SizedBox(height: 24),

//                 // ==========================================================
//                 // PREFERENCES
//                 // ==========================================================

//                 const Text(
//                   'Preferences',
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),

//                 const SizedBox(height: 14),

//                 _buildThemeCard(
//                   context,
//                   themeProvider: themeProvider,
//                   isDarkMode: isDarkMode,
//                 ),

//                 const SizedBox(height: 24),

//                 // ==========================================================
//                 // ACCOUNT INFORMATION
//                 // ==========================================================

//                 const Text(
//                   'Account Information',
//                   style: TextStyle(
//                     fontSize: 21,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),

//                 const SizedBox(height: 14),

//                 _buildAccountInformation(
//                   context,
//                   displayName: displayName,
//                   email: email,
//                   userId: user?.uid ?? 'Not available',
//                   isAdmin: auth.isAdmin,
//                 ),

//                 const SizedBox(height: 24),

//                 // ==========================================================
//                 // LOGOUT
//                 // ==========================================================

//                 _buildLogoutButton(context),

//                 const SizedBox(height: 24),

//                 // ==========================================================
//                 // APP VERSION
//                 // ==========================================================

//                 Center(
//                   child: Text(
//                     'E-Commerce Pro',
//                     style: TextStyle(
//                       color: colors.onSurfaceVariant,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 4),

//                 Center(
//                   child: Text(
//                     'Your modern shopping experience',
//                     style: TextStyle(
//                       color: colors.onSurfaceVariant.withOpacity(0.75),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ========================================================================
//   // PROFILE HEADER
//   // ========================================================================

//   Widget _buildProfileHeader(
//     BuildContext context, {
//     required String displayName,
//     required String email,
//     required bool isAdmin,
//   }) {
//     final colors = Theme.of(context).colorScheme;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             colors.primary,
//             colors.primary.withOpacity(0.78),
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(26),
//         boxShadow: [
//           BoxShadow(
//             color: colors.primary.withOpacity(0.22),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // --------------------------------------------------------------
//           // PROFILE AVATAR
//           // --------------------------------------------------------------

//           Container(
//             width: 92,
//             height: 92,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.16),
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.35),
//                 width: 2,
//               ),
//             ),
//             child: const Icon(
//               Icons.person_rounded,
//               size: 54,
//               color: Colors.white,
//             ),
//           ),

//           const SizedBox(height: 16),

//           // --------------------------------------------------------------
//           // NAME
//           // --------------------------------------------------------------

//           Text(
//             displayName,
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.w800,
//             ),
//           ),

//           const SizedBox(height: 5),

//           // --------------------------------------------------------------
//           // EMAIL
//           // --------------------------------------------------------------

//           Text(
//             email,
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.78),
//               fontSize: 14,
//             ),
//           ),

//           const SizedBox(height: 14),

//           // --------------------------------------------------------------
//           // ROLE BADGE
//           // --------------------------------------------------------------

//           Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 13,
//               vertical: 7,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.14),
//               borderRadius: BorderRadius.circular(30),
//               border: Border.all(
//                 color: Colors.white.withOpacity(0.15),
//               ),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   isAdmin
//                       ? Icons.admin_panel_settings_rounded
//                       : Icons.verified_user_rounded,
//                   color: Colors.white,
//                   size: 16,
//                 ),
//                 const SizedBox(width: 6),
//                 Text(
//                   isAdmin ? 'Administrator' : 'Customer',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ========================================================================
//   // MENU CARD
//   // ========================================================================

//   Widget _buildMenuCard(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//     bool isAdmin = false,
//   }) {
//     final colors = Theme.of(context).colorScheme;

//     return Material(
//       color: colors.surfaceContainerHighest.withOpacity(0.65),
//       borderRadius: BorderRadius.circular(20),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   color: isAdmin
//                       ? Colors.orange.withOpacity(0.12)
//                       : colors.primary.withOpacity(0.10),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Icon(
//                   icon,
//                   color: isAdmin ? Colors.orange : colors.primary,
//                   size: 24,
//                 ),
//               ),

//               const SizedBox(width: 14),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),

//                     const SizedBox(height: 4),

//                     Text(
//                       subtitle,
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: colors.onSurfaceVariant,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 size: 16,
//                 color: colors.onSurfaceVariant,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ========================================================================
//   // THEME CARD
//   // ========================================================================

//   Widget _buildThemeCard(
//     BuildContext context, {
//     required ThemeProvider themeProvider,
//     required bool isDarkMode,
//   }) {
//     final colors = Theme.of(context).colorScheme;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: colors.surfaceContainerHighest.withOpacity(0.65),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: colors.outlineVariant.withOpacity(0.35),
//         ),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               color: colors.primary.withOpacity(0.10),
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Icon(
//               isDarkMode
//                   ? Icons.dark_mode_rounded
//                   : Icons.light_mode_rounded,
//               color: colors.primary,
//               size: 24,
//             ),
//           ),

//           const SizedBox(width: 14),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Dark Mode',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),

//                 const SizedBox(height: 4),

//                 Text(
//                   isDarkMode
//                       ? 'Dark theme is enabled'
//                       : 'Use dark theme',
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: colors.onSurfaceVariant,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Switch.adaptive(
//             value: isDarkMode,
//             onChanged: (_) {
//               themeProvider.toggleTheme();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   // ========================================================================
//   // ACCOUNT INFORMATION
//   // ========================================================================

//   Widget _buildAccountInformation(
//     BuildContext context, {
//     required String displayName,
//     required String email,
//     required String userId,
//     required bool isAdmin,
//   }) {
//     final colors = Theme.of(context).colorScheme;

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: colors.surfaceContainerHighest.withOpacity(0.65),
//         borderRadius: BorderRadius.circular(22),
//         border: Border.all(
//           color: colors.outlineVariant.withOpacity(0.35),
//         ),
//       ),
//       child: Column(
//         children: [
//           _buildInformationRow(
//             context,
//             icon: Icons.person_outline_rounded,
//             title: 'Name',
//             value: displayName,
//           ),

//           const SizedBox(height: 20),

//           _buildInformationRow(
//             context,
//             icon: Icons.email_outlined,
//             title: 'Email',
//             value: email,
//           ),

//           const SizedBox(height: 20),

//           _buildInformationRow(
//             context,
//             icon: Icons.fingerprint_rounded,
//             title: 'User ID',
//             value: userId,
//           ),

//           const SizedBox(height: 20),

//           _buildInformationRow(
//             context,
//             icon: isAdmin
//                 ? Icons.admin_panel_settings_rounded
//                 : Icons.person_outline_rounded,
//             title: 'Account Type',
//             value: isAdmin ? 'Administrator' : 'Customer',
//           ),
//         ],
//       ),
//     );
//   }

//   // ========================================================================
//   // INFORMATION ROW
//   // ========================================================================

//   Widget _buildInformationRow(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     final colors = Theme.of(context).colorScheme;

//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: 42,
//           height: 42,
//           decoration: BoxDecoration(
//             color: colors.primary.withOpacity(0.09),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             icon,
//             color: colors.primary,
//             size: 21,
//           ),
//         ),

//         const SizedBox(width: 13),

//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: colors.onSurfaceVariant,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               const SizedBox(height: 4),

//               Text(
//                 value,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   // ========================================================================
//   // LOGOUT BUTTON
//   // ========================================================================

//   Widget _buildLogoutButton(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: OutlinedButton.icon(
//         onPressed: () {
//           _logout(context);
//         },
//         icon: const Icon(
//           Icons.logout_rounded,
//         ),
//         label: const Text(
//           'Logout',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         style: OutlinedButton.styleFrom(
//           foregroundColor: colors.error,
//           side: BorderSide(
//             color: colors.error.withOpacity(0.55),
//           ),
//           backgroundColor: colors.error.withOpacity(0.04),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//       ),
//     );
//   }

//   // ========================================================================
//   // EDIT PROFILE MESSAGE
//   // ========================================================================

//   void _showEditProfileMessage(BuildContext context) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         content: const Row(
//           children: [
//             Icon(
//               Icons.info_outline_rounded,
//               color: Colors.white,
//             ),
//             SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 'Edit Profile feature can be added here.',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ========================================================================
//   // LOGOUT
//   // ========================================================================

//   Future<void> _logout(BuildContext context) async {
//     final colors = Theme.of(context).colorScheme;

//     final shouldLogout = await showDialog<bool>(
//       context: context,
//       builder: (dialogContext) {
//         return AlertDialog(
//           title: const Text(
//             'Logout',
//             style: TextStyle(
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           content: const Text(
//             'Are you sure you want to logout from your account?',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, false);
//               },
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(dialogContext, true);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: colors.error,
//                 foregroundColor: colors.onError,
//               ),
//               child: const Text(
//                 'Logout',
//               ),
//             ),
//           ],
//         );
//       },
//     );

//     if (shouldLogout != true) {
//       return;
//     }

//     await context.read<AuthProvider>().logout();

//     if (!context.mounted) {
//       return;
//     }

//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(
//         builder: (_) => const LoginScreen(),
//       ),
//       (route) => false,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

import 'auth/login_screen.dart';
import 'order_history_screen.dart';
import 'admin_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final auth = context.watch<AuthProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    final user = auth.user;

    final email = user?.email ?? 'No email';

    final displayName = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : email.contains('@')
            ? email.split('@').first
            : 'User';

    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await auth.refreshUser();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              32,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // ==========================================================
                // PROFILE HEADER
                // ==========================================================

                _buildProfileHeader(
                  context,
                  displayName: displayName,
                  email: email,
                  isAdmin: auth.isAdmin,
                ),

                const SizedBox(height: 24),

                // ==========================================================
                // ACCOUNT
                // ==========================================================

                const Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                // ----------------------------------------------------------
                // MY ORDERS
                // ----------------------------------------------------------

                _buildMenuCard(
                  context,
                  icon: Icons.shopping_bag_rounded,
                  title: 'My Orders',
                  subtitle: 'View and track your orders',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const OrderHistoryScreen(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 12),

                // ----------------------------------------------------------
                // EDIT PROFILE
                // ----------------------------------------------------------

                _buildMenuCard(
                  context,
                  icon: Icons.edit_rounded,
                  title: 'Edit Profile',
                  subtitle:
                      'Update your profile information',
                  onTap: () async {
                    final updated =
                        await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            const EditProfileScreen(),
                      ),
                    );

                    if (updated == true && mounted) {
                      await context
                          .read<AuthProvider>()
                          .refreshUser();
                    }
                  },
                ),

                // ----------------------------------------------------------
                // ADMIN DASHBOARD
                // ----------------------------------------------------------

                if (auth.isAdmin) ...[
                  const SizedBox(height: 12),

                  _buildMenuCard(
                    context,
                    icon: Icons
                        .admin_panel_settings_rounded,
                    title: 'Admin Dashboard',
                    subtitle:
                        'Manage products and orders',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const AdminScreen(),
                        ),
                      );
                    },
                    isAdmin: true,
                  ),
                ],

                const SizedBox(height: 24),

                // ==========================================================
                // PREFERENCES
                // ==========================================================

                const Text(
                  'Preferences',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                _buildThemeCard(
                  context,
                  themeProvider: themeProvider,
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: 24),

                // ==========================================================
                // ACCOUNT INFORMATION
                // ==========================================================

                const Text(
                  'Account Information',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 14),

                _buildAccountInformation(
                  context,
                  displayName: displayName,
                  email: email,
                  userId: user?.uid ?? 'Not available',
                  isAdmin: auth.isAdmin,
                ),

                const SizedBox(height: 24),

                // ==========================================================
                // LOGOUT
                // ==========================================================

                _buildLogoutButton(context),

                const SizedBox(height: 24),

                // ==========================================================
                // APP INFORMATION
                // ==========================================================

                Center(
                  child: Text(
                    'E-Commerce Pro',
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                const SizedBox(height: 4),

                Center(
                  child: Text(
                    'Your modern shopping experience',
                    style: TextStyle(
                      color: colors.onSurfaceVariant
                          .withOpacity(0.75),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // PROFILE HEADER
  // ========================================================================

  Widget _buildProfileHeader(
    BuildContext context, {
    required String displayName,
    required String email,
    required bool isAdmin,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.primary,
            colors.primary.withOpacity(0.78),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withOpacity(0.22),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // --------------------------------------------------------------
          // AVATAR
          // --------------------------------------------------------------

          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 54,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          // --------------------------------------------------------------
          // NAME
          // --------------------------------------------------------------

          Text(
            displayName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 5),

          // --------------------------------------------------------------
          // EMAIL
          // --------------------------------------------------------------

          Text(
            email,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white.withOpacity(0.78),
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 14),

          // --------------------------------------------------------------
          // ROLE
          // --------------------------------------------------------------

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.14),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.15),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isAdmin
                      ? Icons
                          .admin_panel_settings_rounded
                      : Icons.verified_user_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  isAdmin
                      ? 'Administrator'
                      : 'Customer',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // MENU CARD
  // ========================================================================

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isAdmin = false,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surfaceContainerHighest
          .withOpacity(0.65),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isAdmin
                      ? Colors.orange.withOpacity(0.12)
                      : colors.primary.withOpacity(0.10),
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: isAdmin
                      ? Colors.orange
                      : colors.primary,
                  size: 24,
                ),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: colors.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // THEME CARD
  // ========================================================================

  Widget _buildThemeCard(
    BuildContext context, {
    required ThemeProvider themeProvider,
    required bool isDarkMode,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest
            .withOpacity(0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              colors.outlineVariant.withOpacity(0.35),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: colors.primary.withOpacity(0.10),
              borderRadius:
                  BorderRadius.circular(15),
            ),
            child: Icon(
              isDarkMode
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
              color: colors.primary,
              size: 24,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Dark Mode',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  isDarkMode
                      ? 'Dark theme is enabled'
                      : 'Use dark theme',
                  style: TextStyle(
                    fontSize: 13,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          Switch.adaptive(
            value: isDarkMode,
            onChanged: (_) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // ACCOUNT INFORMATION
  // ========================================================================

  Widget _buildAccountInformation(
    BuildContext context, {
    required String displayName,
    required String email,
    required String userId,
    required bool isAdmin,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest
            .withOpacity(0.65),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color:
              colors.outlineVariant.withOpacity(0.35),
        ),
      ),
      child: Column(
        children: [
          _buildInformationRow(
            context,
            icon: Icons.person_outline_rounded,
            title: 'Name',
            value: displayName,
          ),

          const SizedBox(height: 20),

          _buildInformationRow(
            context,
            icon: Icons.email_outlined,
            title: 'Email',
            value: email,
          ),

          const SizedBox(height: 20),

          _buildInformationRow(
            context,
            icon: Icons.fingerprint_rounded,
            title: 'User ID',
            value: userId,
          ),

          const SizedBox(height: 20),

          _buildInformationRow(
            context,
            icon: isAdmin
                ? Icons
                    .admin_panel_settings_rounded
                : Icons.person_outline_rounded,
            title: 'Account Type',
            value: isAdmin
                ? 'Administrator'
                : 'Customer',
          ),
        ],
      ),
    );
  }

  // ========================================================================
  // INFORMATION ROW
  // ========================================================================

  Widget _buildInformationRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: colors.primary.withOpacity(0.09),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: colors.primary,
            size: 21,
          ),
        ),

        const SizedBox(width: 13),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ========================================================================
  // LOGOUT BUTTON
  // ========================================================================

  Widget _buildLogoutButton(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton.icon(
        onPressed: () {
          _logout(context);
        },
        icon: const Icon(
          Icons.logout_rounded,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.error,
          side: BorderSide(
            color: colors.error.withOpacity(0.55),
          ),
          backgroundColor:
              colors.error.withOpacity(0.04),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // LOGOUT
  // ========================================================================

  Future<void> _logout(BuildContext context) async {
    final colors = Theme.of(context).colorScheme;

    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Logout',
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'Are you sure you want to logout from your account?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true) {
      return;
    }

    await context.read<AuthProvider>().logout();

    if (!context.mounted) {
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
      (route) => false,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// import 'firebase_options.dart';

// // ============================================================
// // PROVIDERS
// // ============================================================

// import 'providers/auth_provider.dart';
// import 'providers/product_provider.dart';
// import 'providers/cart_provider.dart';
// import 'providers/wishlist_provider.dart';
// import 'providers/order_provider.dart';
// import 'providers/theme_provider.dart';
// import 'providers/user_provider.dart';
// import 'providers/review_provider.dart';

// // ============================================================
// // SCREENS
// // ============================================================

// import 'screens/splash_screen.dart';
// import 'screens/checkout_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // ==========================================================
//   // INITIALIZE FIREBASE
//   // ==========================================================

//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(const MyApp());
// }

// // ============================================================
// // MY APP
// // ============================================================

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // ==========================================================
//   // LIGHT THEME
//   // ==========================================================

//   ThemeData _lightTheme() {
//     return ThemeData(
//       useMaterial3: true,

//       brightness: Brightness.light,

//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.deepPurple,
//         brightness: Brightness.light,
//       ),

//       scaffoldBackgroundColor: Colors.grey.shade100,

//       // ------------------------------------------------------
//       // APP BAR
//       // ------------------------------------------------------
//       appBarTheme: const AppBarTheme(
//         centerTitle: false,
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),

//       // ------------------------------------------------------
//       // CARD
//       // ------------------------------------------------------
//       cardTheme: CardThemeData(
//         color: Colors.white,
//         elevation: 3,
//         margin: EdgeInsets.zero,

//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//       ),

//       // ------------------------------------------------------
//       // TEXT FIELDS
//       // ------------------------------------------------------
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,

//         fillColor: Colors.white,

//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(14)),
//           borderSide: BorderSide.none,
//         ),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(14)),
//           borderSide: BorderSide.none,
//         ),

//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(14)),
//           borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//         ),
//       ),

//       // ------------------------------------------------------
//       // ELEVATED BUTTON
//       // ------------------------------------------------------
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.deepPurple,

//           foregroundColor: Colors.white,

//           minimumSize: const Size.fromHeight(50),

//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//         ),
//       ),

//       // ------------------------------------------------------
//       // LIST TILE
//       // ------------------------------------------------------
//       listTileTheme: const ListTileThemeData(
//         textColor: Colors.black87,
//         iconColor: Colors.deepPurple,
//       ),

//       // ------------------------------------------------------
//       // DIVIDER
//       // ------------------------------------------------------
//       dividerTheme: const DividerThemeData(color: Colors.black12),
//     );
//   }

//   // ==========================================================
//   // DARK THEME
//   // ==========================================================

//   ThemeData _darkTheme() {
//     return ThemeData(
//       useMaterial3: true,

//       brightness: Brightness.dark,

//       colorScheme: ColorScheme.fromSeed(
//         seedColor: Colors.deepPurple,
//         brightness: Brightness.dark,
//       ),

//       scaffoldBackgroundColor: const Color(0xFF121212),

//       // ------------------------------------------------------
//       // APP BAR
//       // ------------------------------------------------------
//       appBarTheme: const AppBarTheme(
//         backgroundColor: Color(0xFF1E1E1E),

//         foregroundColor: Colors.white,

//         elevation: 0,
//       ),

//       // ------------------------------------------------------
//       // CARD
//       // ------------------------------------------------------
//       cardTheme: CardThemeData(
//         color: const Color(0xFF1E1E1E),

//         elevation: 3,

//         margin: EdgeInsets.zero,

//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16)),
//         ),
//       ),

//       // ------------------------------------------------------
//       // TEXT FIELDS
//       // ------------------------------------------------------
//       inputDecorationTheme: const InputDecorationTheme(
//         filled: true,

//         fillColor: Color(0xFF1E1E1E),

//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(14)),
//           borderSide: BorderSide.none,
//         ),

//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(14)),
//           borderSide: BorderSide.none,
//         ),

//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(14)),
//           borderSide: BorderSide(color: Colors.deepPurple, width: 2),
//         ),
//       ),

//       // ------------------------------------------------------
//       // ELEVATED BUTTON
//       // ------------------------------------------------------
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.deepPurple,

//           foregroundColor: Colors.white,

//           minimumSize: const Size.fromHeight(50),

//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(14),
//           ),
//         ),
//       ),

//       // ------------------------------------------------------
//       // LIST TILE
//       // ------------------------------------------------------
//       listTileTheme: const ListTileThemeData(
//         textColor: Colors.white,

//         iconColor: Colors.white70,
//       ),

//       // ------------------------------------------------------
//       // DIVIDER
//       // ------------------------------------------------------
//       dividerTheme: const DividerThemeData(color: Colors.white12),

//       // ------------------------------------------------------
//       // SWITCH
//       // ------------------------------------------------------
//       switchTheme: SwitchThemeData(
//         thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
//           if (states.contains(WidgetState.selected)) {
//             return Colors.deepPurple;
//           }

//           return Colors.grey;
//         }),

//         trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
//           if (states.contains(WidgetState.selected)) {
//             return Colors.deepPurple.shade200;
//           }

//           return Colors.grey.shade700;
//         }),
//       ),
//     );
//   }

//   // ==========================================================
//   // BUILD
//   // ==========================================================

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // ----------------------------------------------------
//         // AUTH PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => AuthProvider()),

//         // ----------------------------------------------------
//         // PRODUCT PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => ProductProvider()),

//         // ----------------------------------------------------
//         // CART PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => CartProvider()),

//         // ----------------------------------------------------
//         // WISHLIST PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => WishlistProvider()),

//         // ----------------------------------------------------
//         // ORDER PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => OrderProvider()),

//         // ----------------------------------------------------
//         // THEME PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => ThemeProvider()),

//         // ----------------------------------------------------
//         // USER PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => UserProvider()),

//         // ----------------------------------------------------
//         // REVIEW PROVIDER
//         // ----------------------------------------------------
//         ChangeNotifierProvider(create: (_) => ReviewProvider()),
//       ],

//       // ======================================================
//       // THEME CONSUMER
//       // ======================================================
//       child: Consumer<ThemeProvider>(
//         builder: (context, themeProvider, child) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,

//             title: 'E-Commerce Pro',

//             // =================================================
//             // LIGHT THEME
//             // =================================================
//             theme: _lightTheme(),

//             // =================================================
//             // DARK THEME
//             // =================================================
//             darkTheme: _darkTheme(),

//             // =================================================
//             // CURRENT THEME
//             //
//             // IMPORTANT:
//             // isDarkMode is the correct getter from
//             // ThemeProvider.
//             // =================================================
//             themeMode: themeProvider.isDarkMode
//                 ? ThemeMode.dark
//                 : ThemeMode.light,

//             // =================================================
//             // START SCREEN
//             // =================================================
//             home: const SplashScreen(),

//             // =================================================
//             // ROUTES
//             // =================================================
//             routes: {'/checkout': (context) => const CheckoutScreen()},
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// ============================================================
// PROVIDERS
// ============================================================

import 'providers/auth_provider.dart';
import 'providers/product_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/order_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'providers/review_provider.dart';

// ============================================================
// SCREENS
// ============================================================

import 'screens/splash_screen.dart';
import 'screens/checkout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

// ============================================================
// MY APP
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ==========================================================
  // PROFESSIONAL LIGHT THEME
  // ==========================================================

  ThemeData _lightTheme() {
    const primary = Color(0xFF6C3CEB);
    const background = Color(0xFFF7F7FA);
    const surface = Colors.white;
    const textPrimary = Color(0xFF17151C);
    const textSecondary = Color(0xFF77737F);

    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      fontFamily: 'Roboto',

      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.light,
      ).copyWith(
        primary: primary,
        secondary: const Color(0xFF9B72FF),
        surface: surface,
      ),

      scaffoldBackgroundColor: background,

      // ======================================================
      // APP BAR
      // ======================================================

      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,

        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ======================================================
      // CARD
      // ======================================================

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,

        margin: EdgeInsets.zero,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // ======================================================
      // TEXT THEME
      // ======================================================

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),

        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),

        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),

        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),

        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),

        bodyLarge: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),

        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondary,
        ),

        bodySmall: TextStyle(
          fontSize: 12,
          color: textSecondary,
        ),
      ),

      // ======================================================
      // INPUT FIELDS
      // ======================================================

      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        hintStyle: const TextStyle(
          color: textSecondary,
          fontSize: 14,
        ),

        labelStyle: const TextStyle(
          color: textSecondary,
        ),

        prefixIconColor: textSecondary,

        suffixIconColor: textSecondary,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
      ),

      // ======================================================
      // ELEVATED BUTTON
      // ======================================================

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,

          foregroundColor: Colors.white,

          elevation: 0,

          minimumSize: const Size(
            double.infinity,
            54,
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 15,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      // ======================================================
      // OUTLINED BUTTON
      // ======================================================

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,

          minimumSize: const Size(
            double.infinity,
            54,
          ),

          side: const BorderSide(
            color: primary,
            width: 1.2,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ======================================================
      // TEXT BUTTON
      // ======================================================

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,

          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ======================================================
      // LIST TILE
      // ======================================================

      listTileTheme: const ListTileThemeData(
        iconColor: primary,

        textColor: textPrimary,

        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
      ),

      // ======================================================
      // DIVIDER
      // ======================================================

      dividerTheme: const DividerThemeData(
        color: Color(0xFFE9E7EE),

        thickness: 1,
      ),

      // ======================================================
      // CHIP
      // ======================================================

      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFFF0EBFF),

        selectedColor: primary,

        labelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        side: BorderSide.none,
      ),

      // ======================================================
      // BOTTOM NAVIGATION BAR
      // ======================================================

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,

        elevation: 8,

        height: 72,

        indicatorColor: const Color(0xFFE9DEFF),

        labelTextStyle: WidgetStatePropertyAll(
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ======================================================
      // SNACKBAR
      // ======================================================

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,

        backgroundColor: const Color(0xFF25222B),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),

        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),

      // ======================================================
      // DIALOG
      // ======================================================

      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,

        elevation: 10,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        titleTextStyle: const TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),

        contentTextStyle: const TextStyle(
          fontSize: 15,
          color: textSecondary,
        ),
      ),
    );
  }

  // ==========================================================
  // PROFESSIONAL DARK THEME
  // ==========================================================

  ThemeData _darkTheme() {
    const primary = Color(0xFF8B5CF6);

    const background = Color(0xFF0F0D13);

    const surface = Color(0xFF19171F);

    const surface2 = Color(0xFF211E28);

    const textPrimary = Color(0xFFF5F3F7);

    const textSecondary = Color(0xFFA7A2AE);

    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      fontFamily: 'Roboto',

      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: primary,
        secondary: const Color(0xFFB59AFF),
        surface: surface,
      ),

      scaffoldBackgroundColor: background,

      // ======================================================
      // APP BAR
      // ======================================================

      appBarTheme: const AppBarTheme(
        backgroundColor: background,

        foregroundColor: textPrimary,

        elevation: 0,

        scrolledUnderElevation: 0,

        centerTitle: false,

        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ======================================================
      // CARD
      // ======================================================

      cardTheme: CardThemeData(
        color: surface,

        elevation: 0,

        margin: EdgeInsets.zero,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // ======================================================
      // TEXT THEME
      // ======================================================

      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),

        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),

        headlineSmall: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),

        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),

        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),

        bodyLarge: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),

        bodyMedium: TextStyle(
          fontSize: 14,
          color: textSecondary,
        ),

        bodySmall: TextStyle(
          fontSize: 12,
          color: textSecondary,
        ),
      ),

      // ======================================================
      // INPUT FIELDS
      // ======================================================

      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        fillColor: surface2,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),

        hintStyle: const TextStyle(
          color: textSecondary,
        ),

        labelStyle: const TextStyle(
          color: textSecondary,
        ),

        prefixIconColor: textSecondary,

        suffixIconColor: textSecondary,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),

          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
        ),
      ),

      // ======================================================
      // BUTTONS
      // ======================================================

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,

          foregroundColor: Colors.white,

          elevation: 0,

          minimumSize: const Size(
            double.infinity,
            54,
          ),

          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 15,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,

          minimumSize: const Size(
            double.infinity,
            54,
          ),

          side: const BorderSide(
            color: primary,
            width: 1.2,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
        ),
      ),

      // ======================================================
      // LIST TILE
      // ======================================================

      listTileTheme: const ListTileThemeData(
        iconColor: primary,

        textColor: textPrimary,

        contentPadding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
      ),

      // ======================================================
      // DIVIDER
      // ======================================================

      dividerTheme: const DividerThemeData(
        color: Color(0xFF302C37),

        thickness: 1,
      ),

      // ======================================================
      // CHIP
      // ======================================================

      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF2A2435),

        selectedColor: primary,

        labelStyle: const TextStyle(
          color: textPrimary,

          fontWeight: FontWeight.w600,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),

        side: BorderSide.none,
      ),

      // ======================================================
      // BOTTOM NAVIGATION
      // ======================================================

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,

        elevation: 8,

        height: 72,

        indicatorColor: const Color(0xFF3A2A55),

        labelTextStyle: WidgetStatePropertyAll(
          const TextStyle(
            fontSize: 12,

            fontWeight: FontWeight.w600,

            color: textPrimary,
          ),
        ),
      ),

      // ======================================================
      // SNACKBAR
      // ======================================================

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,

        backgroundColor: const Color(0xFF29252F),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      // ======================================================
      // DIALOG
      // ======================================================

      dialogTheme: DialogThemeData(
        backgroundColor: surface,

        elevation: 10,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        titleTextStyle: const TextStyle(
          fontSize: 21,

          fontWeight: FontWeight.w700,

          color: textPrimary,
        ),

        contentTextStyle: const TextStyle(
          fontSize: 15,

          color: textSecondary,
        ),
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // AUTH
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        // PRODUCTS
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),

        // CART
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        // WISHLIST
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),

        // ORDERS
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),

        // THEME
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),

        // USER
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),

        // REVIEWS
        ChangeNotifierProvider(
          create: (_) => ReviewProvider(),
        ),
      ],

      child: Consumer<ThemeProvider>(
        builder: (
          context,
          themeProvider,
          child,
        ) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            title: 'E-Commerce Pro',

            // =================================================
            // LIGHT
            // =================================================

            theme: _lightTheme(),

            // =================================================
            // DARK
            // =================================================

            darkTheme: _darkTheme(),

            // =================================================
            // CURRENT MODE
            // =================================================

            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,

            // =================================================
            // SPLASH
            // =================================================

            home: const SplashScreen(),

            // =================================================
            // ROUTES
            // =================================================

            routes: {
              '/checkout': (context) =>
                  const CheckoutScreen(),
            },
          );
        },
      ),
    );
  }
}
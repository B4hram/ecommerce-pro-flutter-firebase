// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'home_screen.dart';
// import 'auth/login_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   @override
//   void initState() {
//     super.initState();

//     Future.delayed(const Duration(seconds: 2), () {
//       if (FirebaseAuth.instance.currentUser != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const HomeScreen()),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => LoginScreen()),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

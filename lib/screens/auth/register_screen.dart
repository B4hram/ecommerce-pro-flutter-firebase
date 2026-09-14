// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/auth_provider.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   bool obscurePassword = true;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _register() async {
//     final email = emailController.text.trim();
//     final password = passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Please enter email and password.',
//           ),
//         ),
//       );
//       return;
//     }

//     if (password.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Password must be at least 6 characters.',
//           ),
//         ),
//       );
//       return;
//     }

//     final auth = context.read<AuthProvider>();

//     try {
//       await auth.register(
//         email,
//         password,
//       );

//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Account created successfully!',
//           ),
//         ),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Registration failed: $e',
//           ),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final auth = context.watch<AuthProvider>();

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xff6A11CB),
//               Color(0xff2575FC),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 elevation: 12,
//                 child: Padding(
//                   padding: const EdgeInsets.all(25),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Icon(
//                         Icons.person_add,
//                         size: 80,
//                         color: Colors.deepPurple,
//                       ),

//                       const SizedBox(height: 15),

//                       const Text(
//                         'Create Account',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       Text(
//                         'Create your shopping account',
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       TextField(
//                         controller: emailController,
//                         keyboardType:
//                             TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           prefixIcon:
//                               const Icon(Icons.email),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       TextField(
//                         controller: passwordController,
//                         obscureText: obscurePassword,
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           prefixIcon:
//                               const Icon(Icons.lock),
//                           suffixIcon: IconButton(
//                             icon: Icon(
//                               obscurePassword
//                                   ? Icons.visibility
//                                   : Icons.visibility_off,
//                             ),
//                             onPressed: () {
//                               setState(() {
//                                 obscurePassword =
//                                     !obscurePassword;
//                               });
//                             },
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 25),

//                       SizedBox(
//                         width: double.infinity,
//                         height: 55,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 Colors.deepPurple,
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.circular(15),
//                             ),
//                           ),
//                           onPressed:
//                               auth.isLoading
//                                   ? null
//                                   : _register,
//                           child: auth.isLoading
//                               ? const SizedBox(
//                                   width: 25,
//                                   height: 25,
//                                   child:
//                                       CircularProgressIndicator(
//                                     color: Colors.white,
//                                     strokeWidth: 3,
//                                   ),
//                                 )
//                               : const Text(
//                                   'REGISTER',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight:
//                                         FontWeight.bold,
//                                   ),
//                                 ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text(
//                           'Already have an account? Login',
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // ==========================================
    // VALIDATION
    // ==========================================

    if (email.isEmpty) {
      _showMessage('Please enter your email.');
      return;
    }

    if (!email.contains('@')) {
      _showMessage('Please enter a valid email.');
      return;
    }

    if (password.isEmpty) {
      _showMessage('Please enter your password.');
      return;
    }

    if (password.length < 6) {
      _showMessage(
        'Password must be at least 6 characters.',
      );
      return;
    }

    // ==========================================
    // AUTH PROVIDER
    // ==========================================

    final auth = context.read<AuthProvider>();

    try {
      // New accounts are ALWAYS normal users.
      await auth.register(
        email,
        password,
      );

      if (!mounted) return;

      // ========================================
      // SUCCESS
      // ========================================

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account created successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Return to LoginScreen
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      String message = 'Registration failed.';

      final error = e.toString().toLowerCase();

      if (error.contains('email-already-in-use')) {
        message = 'This email is already registered.';
      } else if (error.contains('invalid-email')) {
        message = 'The email address is invalid.';
      } else if (error.contains('weak-password')) {
        message = 'The password is too weak.';
      } else if (error.contains('network-request-failed')) {
        message = 'Network error. Please check your internet.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6A11CB),
              Color(0xff2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Card(
                elevation: 12,

                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(25),

                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      // =================================
                      // ICON
                      // =================================

                      const Icon(
                        Icons.person_add,
                        size: 80,
                        color: Colors.deepPurple,
                      ),

                      const SizedBox(height: 15),

                      // =================================
                      // TITLE
                      // =================================

                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Create your shopping account',
                        style: TextStyle(
                          color:
                              Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // =================================
                      // EMAIL
                      // =================================

                      TextField(
                        controller:
                            emailController,

                        keyboardType:
                            TextInputType
                                .emailAddress,

                        decoration:
                            InputDecoration(
                          labelText: 'Email',

                          prefixIcon:
                              const Icon(
                            Icons.email,
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // =================================
                      // PASSWORD
                      // =================================

                      TextField(
                        controller:
                            passwordController,

                        obscureText:
                            obscurePassword,

                        decoration:
                            InputDecoration(
                          labelText: 'Password',

                          prefixIcon:
                              const Icon(
                            Icons.lock,
                          ),

                          suffixIcon:
                              IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility
                                  : Icons
                                      .visibility_off,
                            ),

                            onPressed: () {
                              setState(() {
                                obscurePassword =
                                    !obscurePassword;
                              });
                            },
                          ),

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // =================================
                      // REGISTER BUTTON
                      // =================================

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                Colors
                                    .deepPurple,

                            foregroundColor:
                                Colors.white,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                15,
                              ),
                            ),
                          ),

                          onPressed:
                              auth.isLoading
                                  ? null
                                  : _register,

                          child: auth.isLoading
                              ? const SizedBox(
                                  width: 25,
                                  height: 25,

                                  child:
                                      CircularProgressIndicator(
                                    color:
                                        Colors.white,

                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text(
                                  'REGISTER',

                                  style:
                                      TextStyle(
                                    color:
                                        Colors.white,

                                    fontSize: 18,

                                    fontWeight:
                                        FontWeight
                                            .bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =================================
                      // LOGIN
                      // =================================

                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },

                        child: const Text(
                          'Already have an account? Login',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
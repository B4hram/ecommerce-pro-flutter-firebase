// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../providers/auth_provider.dart';

// import '../home_screen.dart';
// import '../admin_screen.dart';

// import 'register_screen.dart';
// import 'forgot_password_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   bool obscurePassword = true;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   // ==========================================
//   // LOGIN
//   // ==========================================

//   Future<void> _login() async {
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

//     final auth = context.read<AuthProvider>();

//     try {
//       await auth.login(
//         email,
//         password,
//       );

//       if (!mounted) return;

//       // ========================================
//       // CHECK USER ROLE
//       // ========================================

//       if (auth.isAdmin) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const AdminScreen(),
//           ),
//         );
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => const HomeScreen(),
//           ),
//         );
//       }
//     } on Exception catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Login failed: $e',
//           ),
//         ),
//       );
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Login failed: $e',
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
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xff6A11CB),
//               Color(0xff2575FC),
//             ],
//           ),
//         ),

//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),

//               child: Card(
//                 elevation: 12,

//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(25),
//                 ),

//                 child: Padding(
//                   padding: const EdgeInsets.all(25),

//                   child: Column(
//                     mainAxisSize:
//                         MainAxisSize.min,

//                     children: [
//                       // =================================
//                       // ICON
//                       // =================================

//                       const Icon(
//                         Icons.shopping_bag,
//                         size: 80,
//                         color: Colors.deepPurple,
//                       ),

//                       const SizedBox(height: 10),

//                       // =================================
//                       // TITLE
//                       // =================================

//                       const Text(
//                         'Welcome Back',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight:
//                               FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 8),

//                       Text(
//                         'Login to continue shopping',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       // =================================
//                       // EMAIL
//                       // =================================

//                       TextField(
//                         controller:
//                             emailController,

//                         keyboardType:
//                             TextInputType.emailAddress,

//                         decoration:
//                             InputDecoration(
//                           labelText: 'Email',

//                           prefixIcon:
//                               const Icon(
//                             Icons.email,
//                           ),

//                           border:
//                               OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.circular(
//                               15,
//                             ),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 15),

//                       // =================================
//                       // PASSWORD
//                       // =================================

//                       TextField(
//                         controller:
//                             passwordController,

//                         obscureText:
//                             obscurePassword,

//                         decoration:
//                             InputDecoration(
//                           labelText: 'Password',

//                           prefixIcon:
//                               const Icon(
//                             Icons.lock,
//                           ),

//                           suffixIcon:
//                               IconButton(
//                             icon: Icon(
//                               obscurePassword
//                                   ? Icons.visibility
//                                   : Icons
//                                       .visibility_off,
//                             ),

//                             onPressed: () {
//                               setState(() {
//                                 obscurePassword =
//                                     !obscurePassword;
//                               });
//                             },
//                           ),

//                           border:
//                               OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.circular(
//                               15,
//                             ),
//                           ),
//                         ),
//                       ),

//                       // =================================
//                       // FORGOT PASSWORD
//                       // =================================

//                       Align(
//                         alignment:
//                             Alignment.centerRight,

//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,

//                               MaterialPageRoute(
//                                 builder: (_) =>
//                                     const ForgotPasswordScreen(),
//                               ),
//                             );
//                           },

//                           child: const Text(
//                             'Forgot Password?',
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 10),

//                       // =================================
//                       // LOGIN BUTTON
//                       // =================================

//                       SizedBox(
//                         width:
//                             double.infinity,

//                         height: 55,

//                         child:
//                             ElevatedButton(
//                           style:
//                               ElevatedButton
//                                   .styleFrom(
//                             backgroundColor:
//                                 Colors.deepPurple,

//                             shape:
//                                 RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius
//                                       .circular(
//                                 15,
//                               ),
//                             ),
//                           ),

//                           onPressed:
//                               auth.isLoading
//                                   ? null
//                                   : _login,

//                           child:
//                               auth.isLoading
//                                   ? const SizedBox(
//                                       width: 25,
//                                       height: 25,

//                                       child:
//                                           CircularProgressIndicator(
//                                         color:
//                                             Colors.white,
//                                         strokeWidth:
//                                             3,
//                                       ),
//                                     )
//                                   : const Text(
//                                       'LOGIN',

//                                       style:
//                                           TextStyle(
//                                         fontSize:
//                                             18,
//                                         color:
//                                             Colors.white,
//                                         fontWeight:
//                                             FontWeight
//                                                 .bold,
//                                       ),
//                                     ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // =================================
//                       // REGISTER
//                       // =================================

//                       Row(
//                         mainAxisAlignment:
//                             MainAxisAlignment
//                                 .center,

//                         children: [
//                           const Text(
//                             "Don't have an account?",
//                           ),

//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,

//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       const RegisterScreen(),
//                                 ),
//                               );
//                             },

//                             child:
//                                 const Text(
//                               'Register',
//                             ),
//                           ),
//                         ],
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

import '../../providers/auth_provider.dart';

import '../home_screen.dart';
import '../admin_screen.dart';

import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ==========================================
  // LOGIN
  // ==========================================

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final auth = context.read<AuthProvider>();

    try {
      await auth.login(email, password);

      if (!mounted) return;

      if (auth.isAdmin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (!mounted) return;

      String message = 'Login failed. Please try again.';

      final error = e.toString().toLowerCase();

      if (error.contains('user-not-found')) {
        message = 'No account found with this email.';
      } else if (error.contains('wrong-password') ||
          error.contains('invalid-credential')) {
        message = 'Incorrect email or password.';
      } else if (error.contains('invalid-email')) {
        message = 'Please enter a valid email address.';
      } else if (error.contains('user-disabled')) {
        message = 'This account has been disabled.';
      } else if (error.contains('network')) {
        message = 'Network error. Please check your internet connection.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(child: Text(message)),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  // ==========================================
  // INPUT DECORATION
  // ==========================================

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF252525)
          : Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  // ==========================================
  // LOGO
  // ==========================================

  Widget _buildLogo() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF7C3AED), Color(0xFF4F46E5)],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: const Icon(
        Icons.shopping_bag_rounded,
        color: Colors.white,
        size: 48,
      ),
    );
  }

  // ==========================================
  // BUILD
  // ==========================================

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? const [
                    Color(0xFF111111),
                    Color(0xFF1A1033),
                    Color(0xFF111111),
                  ]
                : const [
                    Color(0xFFF5F3FF),
                    Color(0xFFEDE9FE),
                    Color(0xFFF8FAFC),
                  ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    // ==================================
                    // LOGO
                    // ==================================
                    _buildLogo(),

                    const SizedBox(height: 24),

                    Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: isDark ? Colors.white : Colors.grey.shade900,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Sign in to continue shopping',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: isDark ? Colors.white60 : Colors.grey.shade600,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ==================================
                    // LOGIN CARD
                    // ==================================
                    Card(
                      elevation: isDark ? 4 : 12,
                      shadowColor: Colors.deepPurple.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(26),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? Colors.white
                                      : Colors.grey.shade900,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                'Enter your account details below.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark
                                      ? Colors.white60
                                      : Colors.grey.shade600,
                                ),
                              ),

                              const SizedBox(height: 25),

                              // ==========================
                              // EMAIL
                              // ==========================
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autocorrect: false,
                                decoration: _inputDecoration(
                                  label: 'Email Address',
                                  hint: 'Enter your email',
                                  icon: Icons.email_outlined,
                                ),
                                validator: (value) {
                                  final email = value?.trim() ?? '';

                                  if (email.isEmpty) {
                                    return 'Please enter your email';
                                  }

                                  if (!email.contains('@') ||
                                      !email.contains('.')) {
                                    return 'Please enter a valid email';
                                  }

                                  return null;
                                },
                              ),

                              const SizedBox(height: 18),

                              // ==========================
                              // PASSWORD
                              // ==========================
                              TextFormField(
                                controller: passwordController,
                                obscureText: obscurePassword,
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  if (!auth.isLoading) {
                                    _login();
                                  }
                                },
                                decoration: _inputDecoration(
                                  label: 'Password',
                                  hint: 'Enter your password',
                                  icon: Icons.lock_outline,
                                  suffixIcon: IconButton(
                                    tooltip: obscurePassword
                                        ? 'Show password'
                                        : 'Hide password',
                                    icon: Icon(
                                      obscurePassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        obscurePassword = !obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }

                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }

                                  return null;
                                },
                              ),

                              // ==========================
                              // FORGOT PASSWORD
                              // ==========================
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: auth.isLoading
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const ForgotPasswordScreen(),
                                            ),
                                          );
                                        },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 8),

                              // ==========================
                              // LOGIN BUTTON
                              // ==========================
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: auth.isLoading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                    foregroundColor: Colors.white,
                                    disabledBackgroundColor: Colors.deepPurple
                                        .withOpacity(0.5),
                                    elevation: 4,
                                    shadowColor: Colors.deepPurple.withOpacity(
                                      0.3,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: auth.isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.login_rounded, size: 21),
                                            SizedBox(width: 10),
                                            Text(
                                              'Sign In',
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),

                              const SizedBox(height: 25),

                              // ==========================
                              // DIVIDER
                              // ==========================
                              Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.withOpacity(0.25),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      'OR',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.white54
                                            : Colors.grey.shade500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Colors.grey.withOpacity(0.25),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 22),

                              // ==========================
                              // REGISTER
                              // ==========================
                              SizedBox(
                                width: double.infinity,
                                height: 54,
                                child: OutlinedButton(
                                  onPressed: auth.isLoading
                                      ? null
                                      : () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const RegisterScreen(),
                                            ),
                                          );
                                        },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.deepPurple,
                                    side: BorderSide(
                                      color: Colors.deepPurple.withOpacity(0.6),
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person_add_outlined, size: 20),
                                      SizedBox(width: 8),
                                      Text(
                                        'Create New Account',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ==================================
                    // FOOTER
                    // ==================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 15,
                          color: isDark ? Colors.white38 : Colors.grey.shade500,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Your account is protected',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark
                                ? Colors.white38
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'E-Commerce Pro',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white38 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

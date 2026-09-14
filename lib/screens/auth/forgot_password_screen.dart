// import 'package:flutter/material.dart';
// import '../../services/auth_service.dart';

// class ForgotPasswordScreen extends StatelessWidget {
//   ForgotPasswordScreen({super.key});

//   final email = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Forgot Password")),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             TextField(
//               controller: email,
//               decoration: const InputDecoration(labelText: "Email"),
//             ),
//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () async {
//                 await AuthService().resetPassword(email.text);

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Reset email sent")),
//                 );
//               },
//               child: const Text("Send Reset Email"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class ForgotPasswordScreen
    extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });

  @override
  State<ForgotPasswordScreen>
      createState() =>
          _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final emailController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth =
        context.watch<AuthProvider>();

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
              padding:
                  const EdgeInsets.all(24),
              child: Card(
                elevation: 12,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(
                    25,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    25,
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.lock_reset,
                        size: 80,
                        color:
                            Colors.deepPurple,
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      const Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      const Text(
                        "Enter your email and we'll send a reset link.",
                        textAlign:
                            TextAlign.center,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      TextField(
                        controller:
                            emailController,
                        decoration:
                            InputDecoration(
                          labelText:
                              "Email",
                          prefixIcon:
                              const Icon(
                            Icons.email,
                          ),
                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                              15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 55,
                        child:
                            ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors
                                    .deepPurple,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                15,
                              ),
                            ),
                          ),
                          onPressed:
                              auth.isLoading
                              ? null
                              : () async {
                                  await auth
                                      .resetPassword(
                                    emailController
                                        .text
                                        .trim(),
                                  );

                                  if (mounted) {
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text(
                                          "Password reset email sent",
                                        ),
                                      ),
                                    );
                                  }
                                },
                          child:
                              auth.isLoading
                              ? const CircularProgressIndicator(
                                  color:
                                      Colors
                                          .white,
                                )
                              : const Text(
                                  "SEND RESET LINK",
                                  style:
                                      TextStyle(
                                    color:
                                        Colors
                                            .white,
                                    fontSize:
                                        18,
                                  ),
                                ),
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
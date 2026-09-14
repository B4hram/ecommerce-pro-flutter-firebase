// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../providers/user_provider.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() =>
//       _EditProfileScreenState();
// }

// class _EditProfileScreenState
//     extends State<EditProfileScreen> {
//   final nameController = TextEditingController();
//   final imageController = TextEditingController();

//   bool _isSaving = false;

//   @override
//   void initState() {
//     super.initState();

//     final user =
//         FirebaseAuth.instance.currentUser;

//     if (user != null) {
//       nameController.text =
//           user.displayName ?? '';

//       imageController.text =
//           user.photoURL ?? '';
//     }

//     imageController.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     imageController.dispose();
//     super.dispose();
//   }

//   Future<void> _saveProfile() async {
//     final user =
//         FirebaseAuth.instance.currentUser;

//     if (user == null) {
//       return;
//     }

//     final name =
//         nameController.text.trim();

//     final image =
//         imageController.text.trim();

//     if (name.isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Please enter your name.',
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _isSaving = true;
//     });

//     try {
//       // Update Firebase Authentication
//       await user.updateDisplayName(name);

//       if (image.isNotEmpty) {
//         await user.updatePhotoURL(image);
//       } else {
//         await user.updatePhotoURL(null);
//       }

//       // Refresh Firebase user
//       await user.reload();

//       final updatedUser =
//           FirebaseAuth.instance.currentUser;

//       // Save to Firestore
//       await context
//           .read<UserProvider>()
//           .saveUser(
//             uid: user.uid,
//             name: name,
//             email:
//                 updatedUser?.email ??
//                     user.email ??
//                     '',
//             image: image,
//           );

//       if (!mounted) return;

//       ScaffoldMessenger.of(context)
//           .showSnackBar(
//         const SnackBar(
//           content: Text(
//             'Profile updated successfully!',
//           ),
//           backgroundColor: Colors.green,
//         ),
//       );

//       Navigator.pop(context, true);
//     } catch (e) {
//       if (!mounted) return;

//       ScaffoldMessenger.of(context)
//           .showSnackBar(
//         SnackBar(
//           content: Text(
//             'Failed to update profile: $e',
//           ),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isSaving = false;
//         });
//       }
//     }
//   }

//   Widget _buildPreview() {
//     final imageUrl =
//         imageController.text.trim();

//     if (imageUrl.isEmpty) {
//       return Container(
//         width: 120,
//         height: 120,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color:
//               Colors.deepPurple.withOpacity(0.1),
//           border: Border.all(
//             color: Colors.deepPurple,
//             width: 3,
//           ),
//         ),
//         child: const Icon(
//           Icons.person,
//           size: 65,
//           color: Colors.deepPurple,
//         ),
//       );
//     }

//     return Container(
//       width: 120,
//       height: 120,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: Colors.deepPurple,
//           width: 3,
//         ),
//       ),
//       child: ClipOval(
//         child: Image.network(
//           imageUrl,
//           width: 120,
//           height: 120,
//           fit: BoxFit.cover,
//           loadingBuilder:
//               (
//             context,
//             child,
//             loadingProgress,
//           ) {
//             if (loadingProgress == null) {
//               return child;
//             }

//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//           errorBuilder:
//               (
//             context,
//             error,
//             stackTrace,
//           ) {
//             return Container(
//               color:
//                   Colors.deepPurple.withOpacity(
//                 0.1,
//               ),
//               child: const Column(
//                 mainAxisAlignment:
//                     MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.broken_image,
//                     size: 35,
//                     color: Colors.red,
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     'Invalid image',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.red,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final user =
//         FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       backgroundColor:
//           Colors.grey.shade100,

//       appBar: AppBar(
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: ListView(
//         padding:
//             const EdgeInsets.all(20),

//         children: [
//           // =====================================
//           // PROFILE PHOTO PREVIEW
//           // =====================================

//           Center(
//             child: _buildPreview(),
//           ),

//           const SizedBox(height: 12),

//           const Center(
//             child: Text(
//               'Profile Photo',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),

//           const SizedBox(height: 5),

//           Center(
//             child: Text(
//               'Paste an image URL below',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ),

//           const SizedBox(height: 25),

//           // =====================================
//           // IMAGE URL FIELD
//           // =====================================

//           const Text(
//             'Profile Image URL',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 8),

//           TextField(
//             controller: imageController,
//             keyboardType:
//                 TextInputType.url,

//             decoration: InputDecoration(
//               hintText:
//                   'https://example.com/photo.jpg',

//               prefixIcon: const Icon(
//                 Icons.link,
//                 color: Colors.deepPurple,
//               ),

//               suffixIcon:
//                   imageController.text.isNotEmpty
//                       ? IconButton(
//                           icon: const Icon(
//                             Icons.clear,
//                           ),
//                           onPressed: () {
//                             imageController
//                                 .clear();
//                           },
//                         )
//                       : null,

//               filled: true,
//               fillColor: Colors.white,

//               contentPadding:
//                   const EdgeInsets.symmetric(
//                 vertical: 18,
//                 horizontal: 15,
//               ),

//               border: OutlineInputBorder(
//                 borderRadius:
//                     BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),

//               focusedBorder:
//                   OutlineInputBorder(
//                 borderRadius:
//                     BorderRadius.circular(16),
//                 borderSide:
//                     const BorderSide(
//                   color: Colors.deepPurple,
//                   width: 2,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 8),

//           Row(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.info_outline,
//                 size: 16,
//                 color: Colors.grey.shade600,
//               ),
//               const SizedBox(width: 6),
//               Expanded(
//                 child: Text(
//                   'Use a direct image URL. The image should be publicly accessible.',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color:
//                         Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 25),

//           // =====================================
//           // NAME
//           // =====================================

//           const Text(
//             'Full Name',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 8),

//           TextField(
//             controller: nameController,

//             textCapitalization:
//                 TextCapitalization.words,

//             decoration: InputDecoration(
//               hintText:
//                   'Enter your full name',

//               prefixIcon: const Icon(
//                 Icons.person_outline,
//                 color: Colors.deepPurple,
//               ),

//               filled: true,
//               fillColor: Colors.white,

//               contentPadding:
//                   const EdgeInsets.symmetric(
//                 vertical: 18,
//                 horizontal: 15,
//               ),

//               border: OutlineInputBorder(
//                 borderRadius:
//                     BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),

//               focusedBorder:
//                   OutlineInputBorder(
//                 borderRadius:
//                     BorderRadius.circular(16),
//                 borderSide:
//                     const BorderSide(
//                   color: Colors.deepPurple,
//                   width: 2,
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 20),

//           // =====================================
//           // EMAIL
//           // =====================================

//           const Text(
//             'Email',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 8),

//           TextField(
//             enabled: false,

//             controller:
//                 TextEditingController(
//               text: user?.email ?? '',
//             ),

//             decoration: InputDecoration(
//               prefixIcon: const Icon(
//                 Icons.email_outlined,
//               ),

//               filled: true,
//               fillColor:
//                   Colors.grey.shade200,

//               border: OutlineInputBorder(
//                 borderRadius:
//                     BorderRadius.circular(16),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),

//           const SizedBox(height: 35),

//           // =====================================
//           // SAVE BUTTON
//           // =====================================

//           SizedBox(
//             height: 55,

//             child: ElevatedButton(
//               onPressed:
//                   _isSaving
//                       ? null
//                       : _saveProfile,

//               style:
//                   ElevatedButton.styleFrom(
//                 backgroundColor:
//                     Colors.deepPurple,
//                 foregroundColor:
//                     Colors.white,

//                 shape:
//                     RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.circular(
//                     16,
//                   ),
//                 ),
//               ),

//               child: _isSaving
//                   ? const SizedBox(
//                       width: 25,
//                       height: 25,
//                       child:
//                           CircularProgressIndicator(
//                         color: Colors.white,
//                         strokeWidth: 3,
//                       ),
//                     )
//                   : const Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment
//                               .center,
//                       children: [
//                         Icon(
//                           Icons.save,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           'Save Profile',
//                           style: TextStyle(
//                             fontSize: 17,
//                             fontWeight:
//                                 FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),

//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController imageController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      nameController.text = user.displayName ?? '';

      imageController.text = user.photoURL ?? '';
    }

    imageController.addListener(_onImageChanged);
  }

  void _onImageChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    imageController.removeListener(_onImageChanged);

    nameController.dispose();
    imageController.dispose();

    super.dispose();
  }

  // ============================================================
  // SAVE PROFILE
  // ============================================================

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showMessage('No user is currently logged in.', isError: true);
      return;
    }

    final name = nameController.text.trim();

    final image = imageController.text.trim();

    setState(() {
      _isSaving = true;
    });

    try {
      // --------------------------------------------------------
      // UPDATE FIREBASE AUTHENTICATION
      // --------------------------------------------------------

      await user.updateDisplayName(name);

      if (image.isNotEmpty) {
        await user.updatePhotoURL(image);
      } else {
        await user.updatePhotoURL(null);
      }

      // --------------------------------------------------------
      // RELOAD FIREBASE USER
      // --------------------------------------------------------

      await user.reload();

      final updatedUser = FirebaseAuth.instance.currentUser;

      // --------------------------------------------------------
      // SAVE PROFILE TO FIRESTORE
      // --------------------------------------------------------

      await context.read<UserProvider>().saveUser(
        uid: user.uid,
        name: name,
        email: updatedUser?.email ?? user.email ?? '',
        image: image,
      );

      if (!mounted) {
        return;
      }

      _showMessage('Profile updated successfully!', isError: false);

      // Small delay so the success message can be seen.
      await Future.delayed(const Duration(milliseconds: 700));

      if (!mounted) {
        return;
      }

      Navigator.pop(context, true);
    } on FirebaseAuthException catch (e) {
      if (!mounted) {
        return;
      }

      String message;

      switch (e.code) {
        case 'requires-recent-login':
          message =
              'For security, please log out and log in again before updating your profile.';
          break;

        case 'network-request-failed':
          message = 'Network error. Please check your internet connection.';
          break;

        case 'invalid-display-name':
          message = 'The name you entered is not valid.';
          break;

        default:
          message = e.message ?? 'Failed to update your profile.';
      }

      _showMessage(message, isError: true);
    } catch (e) {
      if (!mounted) {
        return;
      }

      debugPrint('Edit Profile Error: $e');

      _showMessage('Something went wrong. Please try again.', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError
                  ? Icons.error_outline_rounded
                  : Icons.check_circle_outline_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ============================================================
  // IMAGE PREVIEW
  // ============================================================

  Widget _buildPreview() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final imageUrl = imageController.text.trim();

    final user = FirebaseAuth.instance.currentUser;

    final displayName = nameController.text.trim().isNotEmpty
        ? nameController.text.trim()
        : user?.displayName ?? '';

    // ----------------------------------------------------------
    // NO IMAGE
    // ----------------------------------------------------------

    if (imageUrl.isEmpty) {
      return Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              colorScheme.primary.withOpacity(0.15),
              colorScheme.secondary.withOpacity(0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: colorScheme.primary, width: 3),
        ),
        child: Center(
          child: displayName.isNotEmpty
              ? Text(
                  _getInitials(displayName),
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                )
              : Icon(
                  Icons.person_rounded,
                  size: 65,
                  color: colorScheme.primary,
                ),
        ),
      );
    }

    // ----------------------------------------------------------
    // IMAGE URL
    // ----------------------------------------------------------

    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.primary, width: 3),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.20),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: 130,
          height: 130,
          fit: BoxFit.cover,

          // ----------------------------------------------------
          // LOADING
          // ----------------------------------------------------
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: colorScheme.primary,
              ),
            );
          },

          // ----------------------------------------------------
          // ERROR
          // ----------------------------------------------------
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.broken_image_rounded,
                    size: 38,
                    color: Colors.red.shade400,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Invalid image',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // INITIALS
  // ============================================================

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }

    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(icon, size: 20, color: colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration({
    required String hintText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InputDecoration(
      hintText: hintText,

      prefixIcon: Icon(icon, color: colorScheme.primary),

      suffixIcon: suffixIcon,

      filled: true,

      fillColor: theme.colorScheme.surfaceContainerHighest.withOpacity(0.45),

      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),

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
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.red.shade400, width: 1.5),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.red.shade400, width: 2),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final user = FirebaseAuth.instance.currentUser;

    final email = user?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Form(
          key: _formKey,

          child: ListView(
            padding: const EdgeInsets.all(20),

            children: [
              // =================================================
              // PROFILE PREVIEW CARD
              // =================================================
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(22),

                  child: Column(
                    children: [
                      _buildPreview(),

                      const SizedBox(height: 16),

                      Text(
                        nameController.text.trim().isNotEmpty
                            ? nameController.text.trim()
                            : 'Your Profile',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        email,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.edit_rounded,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Edit your information',
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // PROFILE PHOTO
              // =================================================
              _buildSectionTitle(
                context,
                'Profile Photo',
                Icons.image_outlined,
              ),

              const SizedBox(height: 10),

              Text(
                'Add a publicly accessible image URL for your profile picture.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: imageController,

                enabled: !_isSaving,

                keyboardType: TextInputType.url,

                textInputAction: TextInputAction.next,

                decoration: _inputDecoration(
                  hintText: 'https://example.com/photo.jpg',
                  icon: Icons.link_rounded,
                  suffixIcon: imageController.text.isNotEmpty
                      ? IconButton(
                          tooltip: 'Clear image URL',
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: _isSaving
                              ? null
                              : () {
                                  imageController.clear();
                                },
                        )
                      : null,
                ),

                validator: (value) {
                  final image = value?.trim() ?? '';

                  if (image.isEmpty) {
                    return null;
                  }

                  final uri = Uri.tryParse(image);

                  if (uri == null ||
                      !uri.hasScheme ||
                      (uri.scheme != 'http' && uri.scheme != 'https')) {
                    return 'Please enter a valid image URL.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 18,
                      color: colorScheme.primary,
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        'Use a direct image URL. The image must be publicly accessible so Firebase and your app can load it.',
                        style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // PERSONAL INFORMATION
              // =================================================
              _buildSectionTitle(
                context,
                'Personal Information',
                Icons.person_outline_rounded,
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: nameController,

                enabled: !_isSaving,

                textCapitalization: TextCapitalization.words,

                textInputAction: TextInputAction.next,

                decoration: _inputDecoration(
                  hintText: 'Enter your full name',
                  icon: Icons.person_outline_rounded,
                ),

                onChanged: (_) {
                  setState(() {});
                },

                validator: (value) {
                  final name = value?.trim() ?? '';

                  if (name.isEmpty) {
                    return 'Please enter your name.';
                  }

                  if (name.length < 2) {
                    return 'Name must contain at least 2 characters.';
                  }

                  if (name.length > 50) {
                    return 'Name must be less than 50 characters.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 22),

              // =================================================
              // EMAIL
              // =================================================
              Text(
                'Email Address',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              TextFormField(
                initialValue: email,

                enabled: false,

                decoration: _inputDecoration(
                  hintText: 'Email address',
                  icon: Icons.email_outlined,
                  suffixIcon: const Icon(Icons.lock_outline_rounded),
                ),
              ),

              const SizedBox(height: 8),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Your email address is managed by Firebase Authentication and cannot be changed here.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // =================================================
              // ACCOUNT ID
              // =================================================
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.fingerprint_rounded,
                          color: colorScheme.primary,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'User ID',
                              style: theme.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              user?.uid ?? 'Unavailable',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // =================================================
              // SAVE BUTTON
              // =================================================
              SizedBox(
                height: 56,

                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveProfile,

                  child: _isSaving
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save_rounded),
                            SizedBox(width: 10),
                            Text(
                              'Save Profile',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 12),

              // =================================================
              // CANCEL BUTTON
              // =================================================
              SizedBox(
                height: 56,

                child: OutlinedButton(
                  onPressed: _isSaving
                      ? null
                      : () {
                          Navigator.pop(context);
                        },

                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

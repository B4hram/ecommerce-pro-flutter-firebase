// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/product_provider.dart';

// class HomeSearchBar extends StatefulWidget {
//   const HomeSearchBar({
//     super.key,
//   });

//   @override
//   State<HomeSearchBar> createState() =>
//       _HomeSearchBarState();
// }

// class _HomeSearchBarState
//     extends State<HomeSearchBar> {
//   late TextEditingController
//       controller;

//   @override
//   void initState() {
//     super.initState();

//     controller =
//         TextEditingController();
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider =
//         context.read<ProductProvider>();

//     return TextField(
//       controller: controller,
//       onChanged: (value) {
//         provider.setSearchQuery(
//           value,
//         );
//       },
//       decoration: InputDecoration(
//         hintText:
//             'Search products...',
//         prefixIcon: const Icon(
//           Icons.search,
//         ),

//         suffixIcon:
//             controller.text.isNotEmpty
//                 ? IconButton(
//                     icon: const Icon(
//                       Icons.clear,
//                     ),
//                     onPressed: () {
//                       controller.clear();

//                       provider
//                           .setSearchQuery(
//                         '',
//                       );

//                       setState(() {});
//                     },
//                   )
//                 : null,

//         filled: true,

//         fillColor:
//             Colors.grey.shade100,

//         border:
//             OutlineInputBorder(
//           borderRadius:
//               BorderRadius.circular(
//             18,
//           ),
//           borderSide:
//               BorderSide.none,
//         ),

//         focusedBorder:
//             OutlineInputBorder(
//           borderRadius:
//               BorderRadius.circular(
//             18,
//           ),
//           borderSide:
//               const BorderSide(
//             color:
//                 Colors.deepPurple,
//             width: 2,
//           ),
//         ),
//       ),
//     );
//   }
// }

// 1111111111111111111111111111111111111111111111111111111111111

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/product_provider.dart';

// class HomeSearchBar extends StatefulWidget {
//   const HomeSearchBar({
//     super.key,
//   });

//   @override
//   State<HomeSearchBar> createState() =>
//       _HomeSearchBarState();
// }

// class _HomeSearchBarState
//     extends State<HomeSearchBar> {
//   final controller =
//       TextEditingController();

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextField(
//       controller: controller,
//       onChanged: (value) {
//         context
//             .read<ProductProvider>()
//             .searchProducts(value);
//       },
//       decoration: InputDecoration(
//         hintText: 'Search products...',
//         prefixIcon: const Icon(
//           Icons.search,
//         ),
//         suffixIcon: controller.text.isNotEmpty
//             ? IconButton(
//                 icon: const Icon(
//                   Icons.clear,
//                 ),
//                 onPressed: () {
//                   controller.clear();

//                   context
//                       .read<ProductProvider>()
//                       .searchProducts('');

//                   setState(() {});
//                 },
//               )
//             : null,
//         filled: true,
//         border: OutlineInputBorder(
//           borderRadius:
//               BorderRadius.circular(16),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      onChanged: (value) {
        context.read<ProductProvider>().setSearchQuery(value);

        // Rebuild the search bar so the clear button
        // appears/disappears.
        setState(() {});
      },

      decoration: InputDecoration(
        hintText: 'Search products...',

        prefixIcon: const Icon(Icons.search),

        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();

                  context.read<ProductProvider>().setSearchQuery('');

                  setState(() {});
                },
              )
            : null,

        filled: true,

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
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
        ),
      ),
    );
  }
}

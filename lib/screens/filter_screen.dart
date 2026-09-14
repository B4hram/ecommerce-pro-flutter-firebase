// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/product_provider.dart';

// class FilterScreen extends StatefulWidget {
//   const FilterScreen({super.key});

//   @override
//   State<FilterScreen> createState() =>
//       _FilterScreenState();
// }

// class _FilterScreenState
//     extends State<FilterScreen> {
//   late RangeValues priceRange;

//   final double maximumPrice = 10000;

//   @override
//   void initState() {
//     super.initState();

//     final provider =
//         context.read<ProductProvider>();

//     priceRange = RangeValues(
//       provider.minPrice,
//       provider.maxPrice,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider =
//         context.watch<ProductProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Filters',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               provider.clearFilters();

//               setState(() {
//                 priceRange =
//                     const RangeValues(
//                   0,
//                   10000,
//                 );
//               });
//             },
//             child: const Text(
//               'Clear',
//               style: TextStyle(
//                 color: Colors.red,
//               ),
//             ),
//           ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         padding:
//             const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment:
//               CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Category',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 15),

//             Wrap(
//               spacing: 10,
//               runSpacing: 10,
//               children: [
//                 _categoryChip(
//                   provider,
//                   'All',
//                 ),
//                 _categoryChip(
//                   provider,
//                   'Phones',
//                 ),
//                 _categoryChip(
//                   provider,
//                   'Laptops',
//                 ),
//                 _categoryChip(
//                   provider,
//                   'Shoes',
//                 ),
//                 _categoryChip(
//                   provider,
//                   'Fashion',
//                 ),
//                 _categoryChip(
//                   provider,
//                   'Other',
//                 ),
//               ],
//             ),

//             const SizedBox(height: 35),

//             const Text(
//               'Price Range',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 10),

//             Text(
//               '\$${priceRange.start.toStringAsFixed(0)}'
//               ' - '
//               '\$${priceRange.end.toStringAsFixed(0)}',
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),

//             RangeSlider(
//               min: 0,
//               max: maximumPrice,
//               divisions: 100,
//               values: priceRange,
//               labels: RangeLabels(
//                 '\$${priceRange.start.toStringAsFixed(0)}',
//                 '\$${priceRange.end.toStringAsFixed(0)}',
//               ),
//               onChanged: (values) {
//                 setState(() {
//                   priceRange = values;
//                 });

//                 provider.setPriceRange(
//                   values.start,
//                   values.end,
//                 );
//               },
//             ),

//             const SizedBox(height: 35),

//             const Text(
//               'Sort By',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight:
//                     FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 15),

//             _sortOption(
//               provider,
//               'Default',
//             ),

//             _sortOption(
//               provider,
//               'Price: Low to High',
//             ),

//             _sortOption(
//               provider,
//               'Price: High to Low',
//             ),

//             const SizedBox(height: 30),

//             SizedBox(
//               width: double.infinity,
//               height: 55,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(
//                     context,
//                   );
//                 },
//                 style:
//                     ElevatedButton.styleFrom(
//                   shape:
//                       RoundedRectangleBorder(
//                     borderRadius:
//                         BorderRadius.circular(
//                       15,
//                     ),
//                   ),
//                 ),
//                 child: const Text(
//                   'Apply Filters',
//                   style: TextStyle(
//                     fontSize: 17,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _categoryChip(
//     ProductProvider provider,
//     String category,
//   ) {
//     final selected =
//         provider.selectedCategory ==
//             category;

//     return ChoiceChip(
//       label: Text(category),
//       selected: selected,
//       onSelected: (_) {
//         provider.setCategory(
//           category,
//         );
//       },
//     );
//   }

//   Widget _sortOption(
//     ProductProvider provider,
//     String option,
//   ) {
//     return RadioListTile<String>(
//       title: Text(option),
//       value: option,
//       groupValue:
//           provider.sortOption,
//       onChanged: (value) {
//         if (value != null) {
//           provider.setSortOption(
//             value,
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late RangeValues priceRange;

  @override
  void initState() {
    super.initState();

    final provider = context.read<ProductProvider>();

    priceRange = RangeValues(provider.minPrice, provider.maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter & Sort'),
        actions: [
          TextButton(
            onPressed: () {
              provider.clearFilters();

              setState(() {
                priceRange = const RangeValues(0, 10000);
              });
            },
            child: const Text('Clear'),
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // ==============================
          // CATEGORY
          // ==============================
          const Text(
            'Category',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['All', 'Phones', 'Laptops', 'Shoes', 'Fashion'].map((
              category,
            ) {
              return ChoiceChip(
                label: Text(category),

                selected: provider.selectedCategory == category,

                onSelected: (_) {
                  provider.setCategory(category);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 30),

          // ==============================
          // PRICE RANGE
          // ==============================
          const Text(
            'Price Range',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text(
            '\$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 5),

          RangeSlider(
            values: priceRange,

            min: 0,

            max: 10000,

            divisions: 100,

            labels: RangeLabels(
              '\$${priceRange.start.toInt()}',
              '\$${priceRange.end.toInt()}',
            ),

            onChanged: (values) {
              setState(() {
                priceRange = values;
              });
            },

            onChangeEnd: (values) {
              provider.setPriceRange(values.start, values.end);
            },
          ),

          const SizedBox(height: 30),

          // ==============================
          // SORT
          // ==============================
          const Text(
            'Sort By',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          DropdownButtonFormField<String>(
            initialValue: provider.sortOption,

            decoration: const InputDecoration(
              border: OutlineInputBorder(),

              prefixIcon: Icon(Icons.sort),

              labelText: 'Sort Products',
            ),

            items: const [
              DropdownMenuItem(value: 'Newest', child: Text('Newest')),

              DropdownMenuItem(
                value: 'Price: Low to High',
                child: Text('Price: Low to High'),
              ),

              DropdownMenuItem(
                value: 'Price: High to Low',
                child: Text('Price: High to Low'),
              ),

              DropdownMenuItem(
                value: 'Name: A to Z',
                child: Text('Name: A to Z'),
              ),

              DropdownMenuItem(
                value: 'Name: Z to A',
                child: Text('Name: Z to A'),
              ),
            ],

            onChanged: (value) {
              if (value != null) {
                provider.setSortOption(value);
              }
            },
          ),

          const SizedBox(height: 40),

          // ==============================
          // CURRENT FILTER SUMMARY
          // ==============================
          Card(
            elevation: 0,
            color: Colors.deepPurple.withOpacity(0.08),

            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    'Current Filters',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text('Category: ${provider.selectedCategory}'),

                  Text(
                    'Price: \$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}',
                  ),

                  Text('Sort: ${provider.sortOption}'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          // ==============================
          // APPLY FILTERS
          // ==============================
          SizedBox(
            height: 55,

            child: ElevatedButton.icon(
              onPressed: () {
                // Make sure the latest
                // price range is applied.
                provider.setPriceRange(priceRange.start, priceRange.end);

                Navigator.pop(context);
              },

              icon: const Icon(Icons.check),

              label: const Text(
                'Apply Filters',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // ==============================
          // RESET ALL
          // ==============================
          SizedBox(
            height: 50,

            child: OutlinedButton(
              onPressed: () {
                provider.clearFilters();

                setState(() {
                  priceRange = const RangeValues(0, 10000);
                });
              },

              child: const Text('Reset All Filters'),
            ),
          ),
        ],
      ),
    );
  }
}

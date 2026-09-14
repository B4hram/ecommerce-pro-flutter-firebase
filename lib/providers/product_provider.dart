


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../models/product_model.dart';

// class ProductProvider extends ChangeNotifier {
//   final FirebaseFirestore _firestore =
//       FirebaseFirestore.instance;

//   // ==========================================
//   // PRODUCTS
//   // ==========================================

//   List<ProductModel> _products = [];

//   List<ProductModel> get products => _products;

//   // ==========================================
//   // FILTERED PRODUCTS
//   // ==========================================

//   List<ProductModel> _filteredProducts = [];

//   List<ProductModel> get filteredProducts =>
//       _filteredProducts;

//   // ==========================================
//   // STATE
//   // ==========================================

//   bool isLoading = false;

//   String _searchQuery = '';

//   String get searchQuery => _searchQuery;

//   String selectedCategory = 'All';

//   double? minPrice;

//   double? maxPrice;

//   String sortOption = 'Default';

//   // ==========================================
//   // FETCH PRODUCTS
//   // ==========================================

//   Future<void> fetchProducts() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       final snapshot =
//           await _firestore
//               .collection('products')
//               .get();

//       _products = snapshot.docs.map((doc) {
//         return ProductModel.fromMap(
//           doc.data(),
//           doc.id,
//         );
//       }).toList();

//       _applyFilters();
//     } catch (e) {
//       debugPrint(
//         'Fetch Products Error: $e',
//       );
//     }

//     isLoading = false;
//     notifyListeners();
//   }

//   // ==========================================
//   // SEARCH
//   // ==========================================

//   void searchProducts(String query) {
//     _searchQuery = query.toLowerCase().trim();

//     _applyFilters();

//     notifyListeners();
//   }

//   // ==========================================
//   // CATEGORY
//   // ==========================================

//   void setCategory(String category) {
//     selectedCategory = category;

//     _applyFilters();

//     notifyListeners();
//   }

//   // ==========================================
//   // PRICE FILTER
//   // ==========================================

//   void setPriceRange(
//     double? min,
//     double? max,
//   ) {
//     minPrice = min;
//     maxPrice = max;

//     _applyFilters();

//     notifyListeners();
//   }

//   // ==========================================
//   // SORT
//   // ==========================================

//   void setSortOption(String option) {
//     sortOption = option;

//     _applyFilters();

//     notifyListeners();
//   }

//   // ==========================================
//   // APPLY ALL FILTERS
//   // ==========================================

//   void _applyFilters() {
//     List<ProductModel> result =
//         List.from(_products);

//     // ------------------------------------------
//     // SEARCH
//     // ------------------------------------------

//     if (_searchQuery.isNotEmpty) {
//       result = result.where((product) {
//         return product.name
//                 .toLowerCase()
//                 .contains(_searchQuery) ||
//             product.description
//                 .toLowerCase()
//                 .contains(_searchQuery);
//       }).toList();
//     }

//     // ------------------------------------------
//     // CATEGORY
//     // ------------------------------------------

//     if (selectedCategory != 'All') {
//       result = result.where((product) {
//         return product.category.toLowerCase() ==
//             selectedCategory.toLowerCase();
//       }).toList();
//     }

//     // ------------------------------------------
//     // MIN PRICE
//     // ------------------------------------------

//     if (minPrice != null) {
//       result = result.where((product) {
//         return product.price >= minPrice!;
//       }).toList();
//     }

//     // ------------------------------------------
//     // MAX PRICE
//     // ------------------------------------------

//     if (maxPrice != null) {
//       result = result.where((product) {
//         return product.price <= maxPrice!;
//       }).toList();
//     }

//     // ------------------------------------------
//     // SORT
//     // ------------------------------------------

//     switch (sortOption) {
//       case 'Price: Low to High':
//         result.sort(
//           (a, b) =>
//               a.price.compareTo(b.price),
//         );
//         break;

//       case 'Price: High to Low':
//         result.sort(
//           (a, b) =>
//               b.price.compareTo(a.price),
//         );
//         break;

//       case 'Name: A-Z':
//         result.sort(
//           (a, b) => a.name
//               .toLowerCase()
//               .compareTo(
//                 b.name.toLowerCase(),
//               ),
//         );
//         break;

//       case 'Name: Z-A':
//         result.sort(
//           (a, b) => b.name
//               .toLowerCase()
//               .compareTo(
//                 a.name.toLowerCase(),
//               ),
//         );
//         break;

//       default:
//         break;
//     }

//     _filteredProducts = result;
//   }

//   // ==========================================
//   // CLEAR FILTERS
//   // ==========================================

//   void clearFilters() {
//     _searchQuery = '';

//     selectedCategory = 'All';

//     minPrice = null;

//     maxPrice = null;

//     sortOption = 'Default';

//     _filteredProducts =
//         List.from(_products);

//     notifyListeners();
//   }

//   // ==========================================
//   // ADD PRODUCT
//   // ==========================================

//   Future<void> addProduct({
//     required String name,
//     required double price,
//     required String description,
//     required String image,
//     required String category,
//   }) async {
//     try {
//       await _firestore
//           .collection('products')
//           .add({
//         'name': name,
//         'price': price,
//         'description': description,
//         'image': image,
//         'category': category,
//       });

//       await fetchProducts();
//     } catch (e) {
//       debugPrint(
//         'Add Product Error: $e',
//       );
//     }
//   }

//   // ==========================================
//   // DELETE PRODUCT
//   // ==========================================

//   Future<void> deleteProduct(
//     String productId,
//   ) async {
//     try {
//       await _firestore
//           .collection('products')
//           .doc(productId)
//           .delete();

//       await fetchProducts();
//     } catch (e) {
//       debugPrint(
//         'Delete Product Error: $e',
//       );
//     }
//   }

//   Future<void> updateProduct({required String id, required String name, required String description, required double price, required String image, required String category}) async {}
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  List<ProductModel> products = [];

  bool isLoading = false;

  String searchQuery = '';

  String selectedCategory = 'All';

  double minPrice = 0;

  double maxPrice = 10000;

  String sortOption = 'Newest';

  List<ProductModel> get filteredProducts {
    List<ProductModel> result =
        List.from(products);

    // SEARCH
    if (searchQuery.isNotEmpty) {
      result = result.where((product) {
        final name =
            product.name.toLowerCase();

        final description =
            product.description.toLowerCase();

        return name.contains(
              searchQuery.toLowerCase(),
            ) ||
            description.contains(
              searchQuery.toLowerCase(),
            );
      }).toList();
    }

    // CATEGORY
    if (selectedCategory != 'All') {
      result = result.where((product) {
        return product.category.toLowerCase() ==
            selectedCategory.toLowerCase();
      }).toList();
    }

    // PRICE
    result = result.where((product) {
      return product.price >= minPrice &&
          product.price <= maxPrice;
    }).toList();

    // SORT
    switch (sortOption) {
      case 'Price: Low to High':
        result.sort(
          (a, b) => a.price.compareTo(b.price),
        );
        break;

      case 'Price: High to Low':
        result.sort(
          (a, b) => b.price.compareTo(a.price),
        );
        break;

      case 'Name: A to Z':
        result.sort(
          (a, b) => a.name.compareTo(b.name),
        );
        break;

      case 'Name: Z to A':
        result.sort(
          (a, b) => b.name.compareTo(a.name),
        );
        break;
    }

    return result;
  }

  // =========================
  // FETCH PRODUCTS
  // =========================

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final snapshot =
          await _firestore
              .collection('products')
              .get();

      products = snapshot.docs.map((doc) {
        return ProductModel.fromMap(
          doc.data(),
          doc.id,
        );
      }).toList();
    } catch (e) {
      debugPrint(
        'Fetch Products Error: $e',
      );
    }

    isLoading = false;
    notifyListeners();
  }

  // =========================
  // ADD PRODUCT
  // =========================

  Future<void> addProduct({
    required String name,
    required double price,
    required String description,
    required String category,
    required String image,
  }) async {
    await _firestore
        .collection('products')
        .add({
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    });

    await fetchProducts();
  }

  // =========================
  // UPDATE PRODUCT
  // =========================

  Future<void> updateProduct({
    required String id,
    required String name,
    required double price,
    required String description,
    required String category,
    required String image,
  }) async {
    await _firestore
        .collection('products')
        .doc(id)
        .update({
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    });

    await fetchProducts();
  }

  // =========================
  // DELETE PRODUCT
  // =========================

  Future<void> deleteProduct(
    String id,
  ) async {
    await _firestore
        .collection('products')
        .doc(id)
        .delete();

    products.removeWhere(
      (product) => product.id == id,
    );

    notifyListeners();
  }

  // =========================
  // SEARCH
  // =========================

  void setSearchQuery(
    String value,
  ) {
    searchQuery = value;
    notifyListeners();
  }

  // =========================
  // CATEGORY
  // =========================

  void setCategory(
    String category,
  ) {
    selectedCategory = category;
    notifyListeners();
  }

  // =========================
  // PRICE
  // =========================

  void setPriceRange(
    double min,
    double max,
  ) {
    minPrice = min;
    maxPrice = max;
    notifyListeners();
  }

  // =========================
  // SORT
  // =========================

  void setSortOption(
    String value,
  ) {
    sortOption = value;
    notifyListeners();
  }

  // =========================
  // CLEAR FILTERS
  // =========================

  void clearFilters() {
    searchQuery = '';
    selectedCategory = 'All';
    minPrice = 0;
    maxPrice = 10000;
    sortOption = 'Newest';

    notifyListeners();
  }
}
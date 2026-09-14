// import 'package:flutter/material.dart';

// import '../models/product_model.dart';

// class WishlistProvider extends ChangeNotifier {
//   final List<ProductModel> _wishlist = [];

//   List<ProductModel> get wishlist => _wishlist;

//   bool isFavorite(String productId) {
//     return _wishlist.any(
//       (product) => product.id == productId,
//     );
//   }

//   void toggleFavorite(
//     ProductModel product,
//   ) {
//     if (isFavorite(product.id)) {
//       _wishlist.removeWhere(
//         (item) => item.id == product.id,
//       );
//     } else {
//       _wishlist.add(product);
//     }

//     notifyListeners();
//   }
// }


import 'package:flutter/material.dart';

import '../models/product_model.dart';

class WishlistProvider
    extends ChangeNotifier {
  final List<ProductModel> _wishlist = [];

  List<ProductModel> get wishlist =>
      _wishlist;

  int get count => _wishlist.length;

  bool isFavorite(String productId) {
    return _wishlist.any(
      (product) => product.id == productId,
    );
  }

  void toggleFavorite(
    ProductModel product,
  ) {
    if (isFavorite(product.id)) {
      removeFromWishlist(product.id);
    } else {
      _wishlist.add(product);
      notifyListeners();
    }
  }

  void removeFromWishlist(
    String productId,
  ) {
    _wishlist.removeWhere(
      (product) =>
          product.id == productId,
    );

    notifyListeners();
  }

  void clearWishlist() {
    _wishlist.clear();
    notifyListeners();
  }
}
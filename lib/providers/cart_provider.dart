
// import 'package:flutter/material.dart';

// import '../models/cart_item.dart';
// import '../models/product_model.dart';

// class CartProvider extends ChangeNotifier {
//   final List<CartItem> _items = [];

//   List<CartItem> get items => _items;

//   void addToCart(ProductModel product) {
//     final index = _items.indexWhere(
//       (item) => item.product.id == product.id,
//     );

//     if (index >= 0) {
//       _items[index].quantity++;
//     } else {
//       _items.add(
//         CartItem(product: product),
//       );
//     }

//     notifyListeners();
//   }

//   void increaseQuantity(int index) {
//     _items[index].quantity++;
//     notifyListeners();
//   }

//   void decreaseQuantity(int index) {
//     if (_items[index].quantity > 1) {
//       _items[index].quantity--;
//     } else {
//       _items.removeAt(index);
//     }

//     notifyListeners();
//   }
//   void clearCart() {
//   _items.clear();
//   notifyListeners();
// }

//   void removeItem(int index) {
//     _items.removeAt(index);
//     notifyListeners();
//   }

//   double get totalPrice {
//     double total = 0;

//     for (final item in _items) {
//       total += item.totalPrice;
//     }

//     return total;
//   }
// }



import 'package:flutter/material.dart';

import '../models/product_model.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get subtotal {
    return product.price * quantity;
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount {
    int count = 0;

    for (final item in _items) {
      count += item.quantity;
    }

    return count;
  }

  double get totalPrice {
    double total = 0;

    for (final item in _items) {
      total += item.subtotal;
    }

    return total;
  }

  bool containsProduct(String productId) {
    return _items.any(
      (item) => item.product.id == productId,
    );
  }

  void addToCart(ProductModel product) {
    final index = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(
        CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(int index) {
    if (index < 0 || index >= _items.length) {
      return;
    }

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void removeProduct(String productId) {
    _items.removeWhere(
      (item) => item.product.id == productId,
    );

    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
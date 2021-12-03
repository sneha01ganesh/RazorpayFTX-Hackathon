import 'package:flutter/foundation.dart';

class CartItem {
  final String? id;
  final String? title;
  final int? price;
  final int? quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String productId, String title, int price) {
    if (_items.containsKey(productId)) {
      CartItem updatedCart;

      _items.update(
        productId,
        (existingCartItem) {
          updatedCart = CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            price: existingCartItem.price,
            quantity: existingCartItem.quantity! + 1,
          );

          return updatedCart;
        },
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    if (_items.containsKey(productId)) {
      final quantity = _items[productId]!.quantity;

      if (quantity == 1) {
        _items.remove(productId);
      } else {
        CartItem updatedItem;

        _items.update(
          productId,
          (existingCartItem) {
            updatedItem = CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity! - 1,
            );

            return updatedItem;
          },
        );
      }
    } else {
      // print('Removed');
    }

    notifyListeners();
  }

  int itemCount(String id) {
    int tot = 0;

    if (_items.containsKey(id)) {
      tot += _items[id]!.quantity!.toInt();
    }

    return tot;
  }

  int get totalCartItems {
    return _items.length;
  }

  int get totalAmount {
    int tot = 0;

    _items.forEach((key, value) {
      tot += value.price! * value.quantity!.toInt();
    });

    return tot;
  }

  void clearItems() {
    _items.clear();

    notifyListeners();
  }
}

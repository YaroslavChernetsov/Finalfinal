import 'package:flutter/material.dart';
import '../models/sock_model.dart';

class CartFavoriteProvider extends ChangeNotifier {
  final List<Sock> _cartItems = []; // Измените Sweet на Sock
  final List<Sock> _favoriteItems = []; // Измените Sweet на Sock

  List<Sock> get cartItems => _cartItems;
  List<Sock> get favoriteItems => _favoriteItems;

  void addToCart(Sock sock) {
    final index = _cartItems.indexWhere((item) => item.id == sock.id);
    if (index == -1) {
      _cartItems.add(sock.copyWith(quantity: 1));
    } else {
      final updatedItem = _cartItems[index].copyWith(
        quantity: _cartItems[index].quantity! + 1,
      );
      _cartItems[index] = updatedItem;
    }
    notifyListeners();
  }

  void removeFromCart(Sock sock) {
    _cartItems.removeWhere((item) => item.id == sock.id);
    notifyListeners();
  }

  void updateQuantity(Sock sock, int quantity) {
    final index = _cartItems.indexWhere((item) => item.id == sock.id);
    if (index != -1) {
      if (quantity <= 0) {
        removeFromCart(sock);
      } else {
        _cartItems[index] = sock.copyWith(quantity: quantity);
        notifyListeners();
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void addToFavorites(Sock sock) {
    if (!_favoriteItems.contains(sock)) {
      _favoriteItems.add(sock);
      notifyListeners();
    }
  }

  void removeFromFavorites(Sock sock) {
    _favoriteItems.remove(sock);
    notifyListeners();
  }

  bool isFavorite(Sock sock) {
    return _favoriteItems.contains(sock);
  }

  bool isInCart(Sock sock) {
    return _cartItems.any((item) => item.id == sock.id);
  }
}

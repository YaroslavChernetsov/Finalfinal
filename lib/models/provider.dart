import 'package:flutter/material.dart';
import 'sock_model.dart';

class SockProvider extends ChangeNotifier {
  final List<Sock> _cart = [];
  final List<Sock> _favorites = [];

  List<Sock> get cart => _cart;
  List<Sock> get favorites => _favorites;

  void addToCart(Sock sock) {
    if (!_cart.contains(sock)) {
      _cart.add(sock);
      notifyListeners();
    }
  }

  void removeFromCart(Sock sock) {
    _cart.remove(sock);
    notifyListeners();
  }

  void addToFavorites(Sock sock) {
    if (!_favorites.contains(sock)) {
      _favorites.add(sock);
      notifyListeners();
    }
  }

  void removeFromFavorites(Sock sock) {
    _favorites.remove(sock);
    notifyListeners();
  }
}

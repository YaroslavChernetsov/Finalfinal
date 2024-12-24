import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_favorite_provider.dart';
import '../models/sock_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteItems = context.watch<CartFavoriteProvider>().favoriteItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Любимые носки')),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('Ваш список носков пуст.'))
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final sock = favoriteItems[index];
          final isInCart =
          context.watch<CartFavoriteProvider>().isInCart(sock);

          return ListTile(
            leading: Image.network(sock.imageUrl, width: 50, height: 50),
            title: Text(sock.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Стоимость: ${sock.price.toStringAsFixed(2)} ₽'),
                if (isInCart)
                  const Text(
                    'Носки уже в корзине',
                    style: TextStyle(fontSize: 12, color: Colors.green),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    context
                        .read<CartFavoriteProvider>()
                        .removeFromFavorites(sock);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                    color: isInCart ? Colors.green : Colors.grey,
                  ),
                  onPressed: () {
                    if (isInCart) {
                      context
                          .read<CartFavoriteProvider>()
                          .removeFromCart(sock);
                    } else {
                      context
                          .read<CartFavoriteProvider>()
                          .addToCart(sock);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

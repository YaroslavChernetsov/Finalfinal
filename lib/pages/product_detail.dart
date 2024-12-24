import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/sock_model.dart';

class ProductDetail extends StatelessWidget {
  final Sock sock;

  const ProductDetail({Key? key, required this.sock}) : super(key: key);

  void _showEditSockDialog(BuildContext context, Sock sock) {
    final TextEditingController nameController = TextEditingController(text: sock.name);
    final TextEditingController descriptionController = TextEditingController(text: sock.description);
    final TextEditingController priceController = TextEditingController(text: sock.price.toString());
    final TextEditingController imageUrlController = TextEditingController(text: sock.imageUrl);
    final TextEditingController materialController = TextEditingController(text: sock.material);
    final TextEditingController sizeController = TextEditingController(text: sock.size);
    final TextEditingController brandController = TextEditingController(text: sock.brand);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Редактировать носки'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Название'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Описание'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Цена (₽)'),
                ),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'Ссылка на изображение'),
                ),
                TextField(
                  controller: materialController,
                  decoration: const InputDecoration(labelText: 'Материал'),
                ),
                TextField(
                  controller: sizeController,
                  decoration: const InputDecoration(labelText: 'Размер'),
                ),
                TextField(
                  controller: brandController,
                  decoration: const InputDecoration(labelText: 'Бренд'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () async {
                final String name = nameController.text.trim();
                final String description = descriptionController.text.trim();
                final double? price = double.tryParse(priceController.text.trim());
                final String imageUrl = imageUrlController.text.trim();
                final String material = materialController.text.trim();
                final String size = sizeController.text.trim();
                final String brand = brandController.text.trim();

                if (name.isEmpty || description.isEmpty || price == null || imageUrl.isEmpty || material.isEmpty || size.isEmpty || brand.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Пожалуйста, заполните все поля')),
                  );
                  return;
                }

                final updatedSock = Sock(
                  id: sock.id,
                  name: name,
                  description: description,
                  price: price,
                  imageUrl: imageUrl,
                  brand: brand,
                  material: material,
                  size: size,
                );

                try {
                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                      .collection('socks')
                      .where('id', isEqualTo: sock.id)
                      .get();

                  if (querySnapshot.docs.isNotEmpty) {
                    await FirebaseFirestore.instance
                        .collection('socks')
                        .doc(querySnapshot.docs.first.id)
                        .update(updatedSock.toJson());
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Носки успешно обновлены')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Носки не найдены в базе данных')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка: $e')),
                  );
                }
              },
              child: const Text('Обновить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(sock.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _showEditSockDialog(context, sock);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Фото носков
            Image.network(
              sock.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                sock.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Цена носков
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${sock.price.toStringAsFixed(2)} ₽',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Описание носков
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                sock.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // Размер носков
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    'Размер: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    sock.size,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // Бренд носков
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  const Text(
                    'Бренд: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    sock.brand,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            // Материал
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Материал:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    sock.material,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

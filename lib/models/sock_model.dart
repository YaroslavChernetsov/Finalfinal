class Sock {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String brand;
  final String material;
  final String size;
  final int? quantity;

  Sock({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.brand,
    required this.material,
    required this.size,
    this.quantity,
  });

  factory Sock.fromJson(Map<String, dynamic> json) {
    return Sock(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      brand: json['brand'] as String,
      material: json['material'] as String,
      size: json['size'] as String,
      quantity: json['quantity'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'brand': brand,
      'material': material,
      'size': size,
      'quantity': quantity,
    };
  }

  Sock copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    String? brand,
    String? material,
    String? size,
    int? quantity,
  }) {
    return Sock(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      brand: brand ?? this.brand,
      material: material ?? this.material,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Sock && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

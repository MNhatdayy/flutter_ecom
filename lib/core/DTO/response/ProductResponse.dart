class ProductResponse {
  final int id;
  final String name;
  final String? imageUrl;
  final double price;
  final String description;

  ProductResponse({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.price,
    required this.description
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl':imageUrl,
      'description': description,
    };
  }
}
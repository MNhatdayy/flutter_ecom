class ProductResponse {
  final int id;
  final String name;
  final String? imageUrl;
  final double price;

  ProductResponse({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.price,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : double.parse(json['price'].toString()),
      imageUrl: json['imageUrl'] as String?,
    );
  }
}
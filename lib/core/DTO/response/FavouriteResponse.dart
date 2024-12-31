class FavoriteResponse {
  final String imageUrl;
  final String name;
  final double price;

  FavoriteResponse({
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  // Factory method to create an instance from JSON
  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      imageUrl: json['product']['imageUrl'] ?? '',
      name: json['product']['name'] ?? '',
      price: json['product']['price']?.toDouble() ?? 0.0,
    );
  }
}
class CartResponse {
  final String username;
  final int productId;
  final int quantity;

  CartResponse({
    required this.username,
    required this.productId,
    required this.quantity,
  });

  // Factory method để tạo instance từ JSON
  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      username: json['username'] ?? '',
      productId: json['productId'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }
}

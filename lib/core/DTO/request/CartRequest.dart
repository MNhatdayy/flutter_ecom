class CartRequest {
  final String username;
  final int productId;
  final int quantity;

  CartRequest({
    required this.username,
    required this.productId,
    required this.quantity,
  });
  factory CartRequest.fromJson(Map<String, dynamic> json) {
    return CartRequest(
      username: json['username'] as String,
      productId: json['productId'] as int,
      quantity: json['quantity'] as int,
    );
  }

  // Phương thức chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'productId': productId,
      'quantity': quantity,
    };
  }
}

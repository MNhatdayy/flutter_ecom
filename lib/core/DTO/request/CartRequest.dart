class CartRequest {
  final String username;
  final int productId;
  final int quantity;

  CartRequest({
    required this.username,
    required this.productId,
    required this.quantity,
  });

  // Phương thức chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'productId': productId,
      'quantity': quantity,
    };
  }
}

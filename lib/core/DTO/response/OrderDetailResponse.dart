class OrderDetailResponse {
  final int id;
  final int quantity;
  final int orderId;
  final int productId;

  OrderDetailResponse({
    required this.id,
    required this.quantity,
    required this.orderId,
    required this.productId,
  });

  // Factory method để tạo instance từ JSON
  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponse(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
    );
  }
}

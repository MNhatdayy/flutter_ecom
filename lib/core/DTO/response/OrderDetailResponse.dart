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

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    print('Parsed JSON: $json'); // Log the parsed JSON to ensure the data is correct
    return OrderDetailResponse(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      orderId: json['orderId'] ?? 0,  // Make sure 'orderId' is correctly mapped
      productId: json['productId'] ?? 0,  // Ensure 'productId' is correctly mapped
    );
  }
}
class OrderResponse {
  final int id;
  final String customerAddress;
  final String customerName;
  final String customerPhone;
  final int paymentId;
  final int userId;

  OrderResponse({
    required this.id,
    required this.customerAddress,
    required this.customerName,
    required this.customerPhone,
    required this.paymentId,
    required this.userId,
  });

  // Factory method to create an instance from JSON
  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['id'] ?? 0,
      customerAddress: json['customer_address'] ?? '',
      customerName: json['customer_name'] ?? '',
      customerPhone: json['customer_phone'] ?? '',
      paymentId: json['payment_id'] ?? 0,
      userId: json['user_id'] ?? 0,
    );
  }
}
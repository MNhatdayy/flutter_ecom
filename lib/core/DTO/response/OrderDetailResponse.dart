import 'package:flutter_ecom/core/DTO/response/ProductResponse.dart';

class OrderDetailResponse {
  final int id;
  final int quantity;
  final int orderId;
  final ProductResponse product;

  OrderDetailResponse({
    required this.id,
    required this.quantity,
    required this.orderId,
    required this.product,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    print('Parsed JSON: $json'); // Log the parsed JSON to ensure the data is correct
    return OrderDetailResponse(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      orderId: json['orderId'] ?? 0,  // Make sure 'orderId' is correctly mapped
      product: ProductResponse.fromJson(json['product'] ?? {}),  // Ensure 'productId' is correctly mapped
    );
  }
}
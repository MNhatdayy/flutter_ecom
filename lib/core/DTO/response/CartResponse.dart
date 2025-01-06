import 'package:flutter_ecom/core/DTO/response/ProductResponse.dart';

class CartResponse {
  final int id;
  final String username;
  final ProductResponse product;
  int quantity;

  CartResponse({
    required this.id,
    required this.username,
    required this.product,
    required this.quantity,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      id: json['id'],
      username: json['username'] ?? '',
      product: ProductResponse.fromJson(json['product']),
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}

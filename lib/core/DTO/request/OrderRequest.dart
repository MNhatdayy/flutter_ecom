import 'package:flutter_ecom/core/DTO/response/CartResponse.dart';

class OrderRequest {
  int userId;
  String customerName;
  String customerAddress;
  String customerPhone;
  int paymentId;
  List<CartResponse> cartItems; // Change to CartResponse

  OrderRequest({
    required this.userId,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.paymentId,
    required this.cartItems,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) {
    var list = json['cartItems'] as List;
    List<CartResponse> cartItemsList = list.map((i) => CartResponse.fromJson(i)).toList(); // Corrected to CartResponse
    return OrderRequest(
      userId: json['userId'] as int,
      customerName: json['customerName'] as String,
      customerAddress: json['customerAddress'] as String,
      customerPhone: json['customerPhone'] as String,
      paymentId: json['paymentId'] as int,
      cartItems: cartItemsList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> cartItemsJson = cartItems.map((item) => item.toJson()).toList();

    return {
      'userId': userId,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'paymentId': paymentId,
      'cartItems': cartItemsJson,
    };
  }
}
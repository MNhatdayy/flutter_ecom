import 'package:flutter_ecom/core/DTO/response/ProductResponse.dart';
import 'package:flutter_ecom/core/DTO/response/userResponse.dart';

class FavoriteResponse {
  final int id;
  final ProductResponse product;
  final UserResponse user;

  FavoriteResponse({
    required this.id,
    required this.product,
    required this.user,
  });

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) {
    return FavoriteResponse(
      id: json['id'],
      product: ProductResponse.fromJson(json['product']),
      user: UserResponse.fromJson(json['user']),
    );
  }
}
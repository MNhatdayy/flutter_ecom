import 'OrderDetailDTO.dart';

class OrderDTO {
  final int id;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final List<OrderDetailDTO> orderDetails;
  final String? paymentType;

  OrderDTO({
    required this.id,
    required this.customerName,
    required this.customerAddress,
    required this.customerPhone,
    required this.orderDetails,
    this.paymentType,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      id: json['id'],
      customerName: json['customerName'],
      customerAddress: json['customerAddress'],
      customerPhone: json['customerPhone'],
      orderDetails: (json['orderDetails'] as List)
          .map((detail) => OrderDetailDTO.fromJson(detail))
          .toList(),
      paymentType: json['payment']?['paymentType'],
    );
  }
}
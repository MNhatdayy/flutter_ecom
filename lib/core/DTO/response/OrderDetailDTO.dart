class OrderDetailDTO {
  final int id;
  final int quantity;

  OrderDetailDTO({required this.id, required this.quantity});

  factory OrderDetailDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailDTO(
      id: json['id'],
      quantity: json['quantity'],
    );
  }
}
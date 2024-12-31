class OrderRequest {
  int userId;
  String customerName;
  String customerAddress;
  String customerPhone;
  int paymentId;

  OrderRequest({required this.userId,required this.customerName,required this.customerAddress,
                required this.customerPhone, required this.paymentId});

  factory OrderRequest.fromJson(Map<String, dynamic> json){
    return OrderRequest(
        userId: json['userId'] as int,
        customerName: json['customerName'] as String,
        customerAddress: json['customerAddress'] as String,
        customerPhone: json['customerPhone'] as String,
        paymentId: json['paymentId'] as int
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'userId': userId,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'paymentId': paymentId
    };
  }
}
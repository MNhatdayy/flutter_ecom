import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/DTO/response/ProductResponse.dart';
import 'package:flutter_ecom/core/services/ProductService.dart';
import '../../../core/DTO/response/OrderDetailResponse.dart';
import '../../../core/services/OrderDetailService.dart';

class OrderDetailScreen extends StatelessWidget {
  final int orderid;  // We only need the orderid to fetch the details
  final ProductService _productService = ProductService();
  OrderDetailScreen({Key? key, required this.orderid}) : super(key: key);

  Future<ProductResponse> _fetchProductDetails(int productId) async {
    return await _productService.GetProductById(productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết đơn hàng"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<OrderDetailResponse>>(
          future: OrderDetailService().GetAllOrderProducts(orderid),  // Fetch order details from the service
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());  // Show loading indicator
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));  // Show error if any
              } else if (snapshot.hasData) {
                final orderDetails = snapshot.data!;
                print('Order details: $orderDetails'); // Log the order details received

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mã đơn hàng: $orderid", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text("Chi tiết sản phẩm:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: orderDetails.length,
                        itemBuilder: (context, index) {
                          final detail = orderDetails[index];
                          return ListTile(
                            title: Text("Mã sản phẩm: ${detail.id}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Số lượng: ${detail.quantity}"),
                                Text("Mã sản phẩm: ${detail.productId}"), // Display productId
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('Không có dữ liệu'));  // No data available
              }
            }

        ),
      ),
    );
  }
}
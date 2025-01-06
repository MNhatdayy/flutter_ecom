import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/services/OrderService.dart';

import '../../../core/DTO/response/OrderDTO.dart';
import 'orderhistory_screen.dart';

class ListOrderScreen extends StatefulWidget {
  final String username;

  const ListOrderScreen({Key? key, required this.username}) : super(key: key);

  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<ListOrderScreen> {
  late Future<List<OrderDTO>> _ordersFuture;
  final OrderSerivce _orderSerivce = OrderSerivce();

  @override
  void initState() {
    super.initState();
    _ordersFuture = _orderSerivce.GetAllOrderByName(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách đơn hàng"),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<OrderDTO>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có đơn hàng nào."),
            );
          } else {
            final orders = snapshot.data!;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text("Mã đơn hàng: ${order.id}"),
                  subtitle: Text(
                      "Tên khách hàng: ${order.customerName}\nĐịa chỉ: ${order.customerAddress}\nSố điện thoại: ${order.customerPhone}"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailScreen(orderid: order.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
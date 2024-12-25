import 'package:flutter/material.dart';

// Example Cart Item model
class CartItem {
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class CartItemScreen extends StatelessWidget {
  // Example list of cart items
  final List<CartItem> cartItems = [
    CartItem(name: "Điện thoại", price: 500, quantity: 1),
    CartItem(name: "Máy tính", price: 1500, quantity: 1),
    CartItem(name: "Phụ kiện", price: 200, quantity: 3),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total price
    double totalPrice = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ Hàng"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Giỏ hàng của bạn hiện tại đang trống"))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart items list
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  CartItem item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(item.name),
                      subtitle: Text("Số lượng: ${item.quantity}"),
                      trailing: Text("${item.price * item.quantity} VND"),
                    ),
                  );
                },
              ),
            ),
            // Total price section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Tổng cộng: ${totalPrice.toStringAsFixed(2)} VND",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Checkout button
            ElevatedButton(
              onPressed: () {
                // You can navigate to the checkout page or handle checkout logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen(totalPrice: totalPrice)),
                );
              },
              child: const Text("Tiến Hành Thanh Toán"),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;

  const CheckoutScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thanh Toán"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tổng tiền cần thanh toán: ${totalPrice.toStringAsFixed(2)} VND",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement payment logic here
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Thanh Toán Thành Công"),
                    content: const Text("Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Đóng"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Thanh Toán"),
            ),
          ],
        ),
      ),
    );
  }
}
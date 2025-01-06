import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/DTO/request/CartRequest.dart';
import '../../../core/DTO/response/CartResponse.dart';
import '../../../core/DTO/response/ProductResponse.dart';
import '../../../core/services/CartService.dart';
import '../../../core/config/number_formart.dart';
import '../checkout/checkout_screen.dart';

class CartItemScreen extends StatefulWidget {
  final String username; // Add username parameter to the constructor
  const CartItemScreen({Key? key, required this.username}) : super(key: key);

  @override
  _CartItemScreenState createState() => _CartItemScreenState();
}

class _CartItemScreenState extends State<CartItemScreen> {
  final CartService _cartService = CartService();
  List<CartResponse> cartItems = [];
  late Future<List<CartResponse>> cartResponse;

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() async {
    try {
      final items = await _cartService.GetAllCartItems(widget.username);
      setState(() {
        cartItems = items;
      });
    } catch (e) {
      print("Error loading cart items: $e");
    }
  }

  void _deleteItem(int id) async {
    try {
      bool success = await _cartService.RemoveFromCart(id);

      if (success) {
        setState(() {
          cartItems.removeWhere((item) => item.id == id);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sản phẩm đã được xóa khỏi giỏ hàng")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Không thể xóa sản phẩm khỏi giỏ hàng")),
        );
      }
    } catch (e) {
      print("Error removing item: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lỗi khi xóa sản phẩm")),
      );
    }
  }

  double get totalPrice => cartItems.fold(
      0, (sum, item) => sum + (item.product.price * item.quantity));

  void _updateCartItem(CartResponse item, int change) async {
    int newQuantity = item.quantity + change;

    // Remove item if quantity <= 0
    if (newQuantity <= 0) {
      _deleteItem(item.id);
      return;
    }

    try {
      setState(() {
        item.quantity = newQuantity;
      });

      bool success = await _cartService.UpdateCart(
          item.id,          // cartId
          widget.username,  // username
          item.product.id,  // productId
          newQuantity       // quantity
      );

      // Check if the update was successful
      if (!success) {
        // Rollback the UI update if the service fails
        setState(() {
          item.quantity -= change;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Không thể cập nhật số lượng sản phẩm")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Số lượng sản phẩm đã được cập nhật")),
        );
        print('Cart updated successfully');
      }
    } catch (e) {
      // Rollback the UI update in case of an exception
      setState(() {
        item.quantity -= change;
      });
      print('Error updating cart: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lỗi khi cập nhật số lượng sản phẩm")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ Hàng", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Giỏ hàng của bạn hiện tại đang trống",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                radius: 30,
                                child: const Icon(Icons.shopping_bag,
                                    color: Colors.blue, size: 30),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      formatCurrency(item.product.price),
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: item.quantity > 1 ? () => _updateCartItem(item, -1) : null,
                                        ),
                                        Text(
                                          "${item.quantity}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () =>
                                              _updateCartItem(item, 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    formatCurrency(
                                        item.product.price * item.quantity),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _deleteItem(item.id),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Tổng số tiền:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formatCurrency(totalPrice),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                totalPrice: totalPrice,
                                username: widget.username,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Tiến hành thanh toán",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

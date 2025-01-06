import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/DTO/response/OrderResponse.dart';
import 'package:flutter_ecom/core/services/AuthService.dart';
import 'package:flutter_ecom/core/services/OrderService.dart';
import 'package:flutter_ecom/core/config/number_formart.dart';
import '../../../core/DTO/request/OrderRequest.dart';
import '../../../core/DTO/response/CartResponse.dart';
import '../../../core/services/CartService.dart';
import '../explore/explore_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;
  final String username;

  const CheckoutScreen({Key? key, required this.totalPrice, required this.username}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final OrderSerivce _orderService = OrderSerivce();
  final AuthService _authService = AuthService();
  final CartService _cartService = CartService();
  List<CartResponse> _cartItems = [];

  String? _customerName;
  String? _customerAddress;
  String? _customerPhone;
  String? _selectedPaymentMethod;
  bool _isLoading = false;

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final paymentId = _selectedPaymentMethod == 'QR' ? 1 : (_selectedPaymentMethod == 'COD' ? 2 : null);
    if (paymentId == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Lỗi"),
          content: const Text("Vui lòng chọn phương thức thanh toán."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Đóng"),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String? token = await _authService.getToken();
    final user = await _authService.getCurrentUser(token);

    try {
      final request = OrderRequest(
          userId: user.id,
          customerName: user.username,
          customerAddress: _customerAddress!,
          customerPhone: _customerPhone!,
          paymentId: paymentId,
          cartItems: _cartItems // Đảm bảo dữ liệu cartItems được nạp đúng
      );

      final response = await _orderService.SubmitOrder(request);
      // Xử lý kết quả trả về từ API (có thể là mã đơn hàng)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Thành công"),
          content: Text("Đơn hàng của bạn đã được tạo thành công! Vui lòng đợi để xác nhận đơn hàng."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
                // Chuyển hướng về trang ExploreScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ExploreScreen()),
                );
              },
              child: const Text("Đóng"),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Thành công"),
          content: Text("Đơn hàng của bạn đã được tạo thành công! Vui lòng đợi để xác nhận đơn hàng."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
                // Chuyển hướng về trang ExploreScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ExploreScreen()),
                );
              },
              child: const Text("Đóng"),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      _cartItems = await _cartService.GetAllCartItems(widget.username);
    } catch (e) {
      print('Failed to load cart items: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Thanh Toán", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Chi tiết giỏ hàng:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _cartItems.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = _cartItems[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: item.product.imageUrl != null
                                  ? Image.network(
                                item.product.imageUrl!,
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              )
                                  : const Icon(Icons.image, size: 60, color: Colors.grey),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Số lượng: ${item.quantity}",
                                    style: const TextStyle(color: Colors.black54),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              formatCurrency(item.product.price * item.quantity),
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Tổng tiền cần thanh toán:",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      formatCurrency(widget.totalPrice),
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
                const Divider(thickness: 1, color: Colors.grey),
                const SizedBox(height: 20),
                const Text("Vui lòng nhập thông tin:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Địa chỉ"),
                  validator: (value) => value == null || value.isEmpty ? "Vui lòng nhập địa chỉ" : null,
                  onSaved: (value) => _customerAddress = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Số điện thoại"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? "Vui lòng nhập số điện thoại" : null,
                  onSaved: (value) => _customerPhone = value,
                ),
                const SizedBox(height: 20),
                const Text("Chọn phương thức thanh toán:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                RadioListTile<String>(
                  value: 'QR',
                  groupValue: _selectedPaymentMethod,
                  activeColor: Colors.black,
                  title: const Text("Thanh Toán qua QR"),
                  onChanged: (value) => setState(() => _selectedPaymentMethod = value),
                ),
                if (_selectedPaymentMethod == 'QR')
                  Center(
                    child: Image.asset(
                      'assets/qr.jpg',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                RadioListTile<String>(
                  value: 'COD',
                  groupValue: _selectedPaymentMethod,
                  activeColor: Colors.black,
                  title: const Text("Thanh Toán Tiền Mặt khi nhận hàng"),
                  onChanged: (value) => setState(() => _selectedPaymentMethod = value),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _isLoading ? null : _submitOrder,
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Xác Nhận Đơn Hàng", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
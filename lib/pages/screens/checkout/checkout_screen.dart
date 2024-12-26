import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalPrice;

  const CheckoutScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // To keep track of the selected payment method
  String? _selectedPaymentMethod;

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
              "Tổng tiền cần thanh toán: ${widget.totalPrice.toStringAsFixed(2)} VND",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Payment Methods Section
            const Text(
              "Chọn phương thức thanh toán:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Radio button for QR Payment
            Row(
              children: [
                Radio<String>(
                  value: 'QR',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
                const Text("Thanh Toán qua QR"),
              ],
            ),
            // Radio button for Cash on Delivery
            Row(
              children: [
                Radio<String>(
                  value: 'COD',
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                ),
                const Text("Thanh Toán Tiền Mặt khi nhận hàng"),
              ],
            ),
            const SizedBox(height: 20),
            // Proceed Button
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMethod != null) {
                  String paymentMethod = _selectedPaymentMethod == 'QR'
                      ? "Thanh Toán qua QR"
                      : "Thanh Toán Tiền Mặt khi nhận hàng";
                  // Show the selected payment method in a dialog or proceed with the payment process
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Xác Nhận"),
                      content: const Text("Bạn có chắc chắn đồng ý với phương thức thanh toán này?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Proceed with the selected payment method
                            Navigator.pop(context);
                            // Optionally, you can handle payment process here
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(paymentMethod),
                                content: Text(
                                  "Bạn đã chọn phương thức thanh toán: $paymentMethod",
                                ),
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
                          child: const Text("Có"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Cancel and close the confirmation dialog
                            Navigator.pop(context);
                          },
                          child: const Text("Không"),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Show a warning if no payment method is selected
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Chưa chọn phương thức thanh toán"),
                      content: const Text("Vui lòng chọn một phương thức thanh toán."),
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
                }
              },
              child: const Text("Xác Nhận Thanh Toán"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
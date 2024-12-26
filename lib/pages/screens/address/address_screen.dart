import 'package:flutter/material.dart';

class AddressScreen extends StatelessWidget {
  final TextEditingController _addressController = TextEditingController();

  AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm Địa Chỉ"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input field for address
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: "Nhập địa chỉ",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 20),
            // Save button
            ElevatedButton(
              onPressed: () {
                String address = _addressController.text.trim();
                if (address.isNotEmpty) {
                  // Save address logic here
                  print("Địa chỉ đã lưu: $address");

                  // Go back to the previous screen with a success message
                  Navigator.pop(context, "Địa chỉ đã được lưu.");
                } else {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Vui lòng nhập địa chỉ hợp lệ.")),
                  );
                }
              },
              child: const Text("Lưu Địa Chỉ"),
            ),
          ],
        ),
      ),
    );
  }
}
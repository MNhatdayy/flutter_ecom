import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liên hệ với Shop",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Name Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Tên",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Phone Field
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Số điện thoại",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Description Field
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Mô tả",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Send Button
            ElevatedButton(
              onPressed: () {
                // Handle sending the message
                final String name = _nameController.text;
                final String email = _emailController.text;
                final String phone = _phoneController.text;
                final String description = _descriptionController.text;

                if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty && description.isNotEmpty) {
                  // You can add functionality to send the data to the shop or server
                  // For now, just show a confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Thông báo"),
                      content: const Text("Tin nhắn đã được gửi đến Shop!"),
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
                } else {
                  // Show error if fields are empty
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Lỗi"),
                      content: const Text("Vui lòng điền đầy đủ thông tin!"),
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
              child: const Text(
                "Gửi Tin Nhắn",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.black,
              ),

            ),
          ],
        ),
      ),
    );
  }
}

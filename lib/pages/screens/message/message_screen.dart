import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nhắn tin"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: const Text(
          "Chưa có tin nhắn mới!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
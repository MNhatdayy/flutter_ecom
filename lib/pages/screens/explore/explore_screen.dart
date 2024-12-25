import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/layout/component/header.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text("${index + 1}"),
              ),
              title: Text("Sản phẩm ${index + 1}"),
              subtitle: const Text("Mô tả sản phẩm"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}
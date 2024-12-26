import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/layout/component/header.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite, size: 80, color: Colors.red),
            SizedBox(height: 20),
            Text("Danh sách yêu thích của bạn trống!", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/auth/LoginScreen.dart';
import 'package:flutter_ecom/pages/HomeScreen.dart'; // Import HomeScreen (giả sử bạn có màn hình chính)

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Đặt tuyến ban đầu là LoginScreen
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(), // Thêm HomeScreen để điều hướng sau khi đăng nhập
      },
    );
  }
}

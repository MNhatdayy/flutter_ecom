import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/DTO/response/userResponse.dart';
import 'package:flutter_ecom/pages/screens/cartitem/cartitem_screen.dart';
import 'package:flutter_ecom/pages/screens/order/listorder_screen.dart';
import 'package:flutter_ecom/pages/screens/profile/user/updateuser_screen.dart';

import '../../../core/services/AuthService.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();

  Future<UserResponse> _fetchUserData() async {
    String? token = await _authService.getToken();

    return await _authService.getCurrentUser(token);
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Đăng xuất'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await _authService.logout();
      await _authService.deleteToken();
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<UserResponse>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Lỗi khi tải dữ liệu người dùng."));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            final avatarUrl = user.avatar ?? '';

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Phần avatar và thông tin người dùng
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          backgroundImage: avatarUrl.isNotEmpty
                              ? NetworkImage(avatarUrl)
                              : null,
                          child: avatarUrl.isEmpty
                              ? const Icon(Icons.person, size: 40, color: Colors.black)
                              : null,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          user.username ?? 'Không có tên',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user.email ?? 'Không có email',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Các phần khác của giao diện
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Cài đặt tài khoản",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person, color: Colors.black), // Icon for user profile
                    title: const Text("Cập nhật thông tin cá nhân", style: TextStyle(color: Colors.black)),
                    subtitle: const Text("Chỉnh sửa thông tin người dùng của bạn", style: TextStyle(color: Colors.grey)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateUserScreen(user: user), // Passing user object to UpdateUserScreen
                        ),
                      ).then((value){
                        if(value == true){
                          setState(() {});
                        }
                      });
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart, color: Colors.black),
                    title: const Text("Giỏ hàng", style: TextStyle(color: Colors.black)),
                    subtitle: const Text("Thêm và xóa sản phẩm khỏi giỏ hàng", style: TextStyle(color: Colors.grey)),
                    onTap: () async {
                      final String? token = await _authService.getToken();
                      if (token != null) {
                        final username = await _authService.getCurrentUser(token);
                        print("Username: $username");
                        // Check if username is valid before passing it
                        if (username != null && username.username != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartItemScreen(username: username.username),
                            ),
                          );
                        } else {
                          // Handle the case where username is not valid or null
                          print("Username is null or invalid.");
                        }
                      } else {
                        // Handle the case where token is null
                        print("Token is null.");
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history, color: Colors.black),
                    title: const Text("Lịch sử đơn hàng", style: TextStyle(color: Colors.black)),
                    subtitle: const Text("Xem lịch sử các đơn hàng của bạn", style: TextStyle(color: Colors.grey)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ListOrderScreen(username: user.username,)), // Chuyển đến OrderHistoryScreen
                      );
                    },
                  ),
                  // Các mục khác...
                  // Phần Cài đặt ứng dụng
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Cài đặt ứng dụng",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dark_mode, color: Colors.black),
                    title: const Text("Nền tối", style: TextStyle(color: Colors.black)),
                    subtitle: const Text("Chỉnh màu nền của ứng dụng", style: TextStyle(color: Colors.grey)),
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                      activeColor: Colors.black,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.help, color: Colors.black),
                    title: const Text("Hướng dẫn sử dụng", style: TextStyle(color: Colors.black)),
                    subtitle: const Text("Xem video hướng dẫn sử dụng ứng dụng", style: TextStyle(color: Colors.grey)),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.policy, color: Colors.black),
                    title: const Text("Chính sách tài khoản", style: TextStyle(color: Colors.black)),
                    subtitle: const Text("Xem chính sách tài khoản", style: TextStyle(color: Colors.grey)),
                    onTap: () {},
                  ),
                  // Nút Đăng xuất
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        _showLogoutConfirmation(context);
                      },
                      child: const Text(
                        "Đăng xuất",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text("Không có dữ liệu người dùng."));
          }
        },
      ),
    );
  }
}

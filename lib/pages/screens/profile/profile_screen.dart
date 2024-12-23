import 'package:flutter/material.dart';

import '../../../core/services/authService.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _authService = AuthService();
  Future<void> _showLogoutConfirmation(BuildContext context) async {
    // Hiển thị modal xác nhận
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xác nhận'),
          content: Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Không đăng xuất
              },
              child: Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Xác nhận đăng xuất
              },
              child: Text('Đăng xuất'),
            ),
          ],
        );
      },
    );

    // Kiểm tra kết quả từ modal
    if (shouldLogout == true) {
      await _authService.logout(); // Gọi hàm logout
      await _authService.deleteToken(); // Xóa token khỏi bộ nhớ

      // Điều hướng về màn hình đăng nhập (hoặc xử lý tùy theo ứng dụng của bạn)
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Phần avatar và thông tin người dùng
            Container(
              padding: const EdgeInsets.all(20),
              alignment: Alignment.center,
              color: Colors.black,
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.black),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Nguyễn Văn A",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "example@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Phần Cài đặt tài khoản
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Cài đặt tài khoản",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.black),
              title: const Text("Địa chỉ", style: TextStyle(color: Colors.black)),
              subtitle: const Text("Thêm địa chỉ giao hàng", style: TextStyle(color: Colors.grey)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.black),
              title: const Text("Giỏ hàng", style: TextStyle(color: Colors.black)),
              subtitle: const Text("Thêm và xóa sản phẩm khỏi giỏ hàng", style: TextStyle(color: Colors.grey)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.receipt, color: Colors.black),
              title: const Text("Đơn đặt hàng", style: TextStyle(color: Colors.black)),
              subtitle: const Text("Xem thông tin đơn đặt hàng", style: TextStyle(color: Colors.grey)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.card_giftcard, color: Colors.black),
              title: const Text("Mã giảm giá", style: TextStyle(color: Colors.black)),
              subtitle: const Text("Xem danh sách mã giảm giá", style: TextStyle(color: Colors.grey)),
              onTap: () {},
            ),

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
      ),
    );
  }
}
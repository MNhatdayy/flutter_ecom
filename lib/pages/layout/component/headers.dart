import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/screens/favorite/favorite_screen.dart';

import '../../screens/cartitem/cartitem_screen.dart';

class Headers extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black, // Nền AppBar màu đen
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[900], // Nền hộp tìm kiếm màu xám đậm
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white), // Biểu tượng tìm kiếm màu trắng
                onPressed: () {
                  _showSearchDialog(context);
                },
              ),
            ),
            Flexible(
              child: const Text(
                "Tìm kiếm sản phẩm",
                style: TextStyle(color: Colors.white, fontSize: 14), // Văn bản tìm kiếm màu trắng
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite, color: Colors.white), // Biểu tượng yêu thích màu trắng
          onPressed: () {
            // Add your favorite button functionality here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoriteScreen()),
            );

          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // Hộp thoại tìm kiếm
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900], // Nền hộp thoại màu xám đậm
          title: const Text(
            "Tìm kiếm sản phẩm",
            style: TextStyle(color: Colors.white), // Văn bản tiêu đề màu trắng
          ),
          content: TextField(
            autofocus: true,
            style: const TextStyle(color: Colors.white), // Văn bản nhập liệu màu trắng
            decoration: InputDecoration(
              hintText: "Nhập từ khóa tìm kiếm...",
              hintStyle: TextStyle(color: Colors.grey[500]), // Gợi ý màu xám nhạt
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Đường viền khi tập trung màu trắng
              ),
            ),
            onChanged: (value) {
              print("Searching for: $value");
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Đóng",
                style: TextStyle(color: Colors.redAccent), // Nút đóng màu đỏ
              ),
            ),
            TextButton(
              onPressed: () {
                print("Search action triggered");
                Navigator.of(context).pop();
              },
              child: const Text(
                "Tìm Kiếm",
                style: TextStyle(color: Colors.white), // Nút tìm kiếm màu trắng
              ),
            ),
          ],
        );
      },
    );
  }
}

// Modal thông báo
class NotificationModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900], // Nền hộp thoại màu xám đậm
      title: const Text(
        "Thông báo",
        style: TextStyle(color: Colors.white), // Tiêu đề màu trắng
      ),
      content: const Text(
        "Bạn có các thông báo mới!",
        style: TextStyle(color: Colors.white), // Nội dung màu trắng
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Đóng",
            style: TextStyle(color: Colors.white), // Nút đóng màu trắng
          ),
        ),
      ],
    );
  }
}
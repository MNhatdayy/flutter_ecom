import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/services/AuthService.dart';

import '../../../core/DTO/response/ProductResponse.dart';
import '../../../core/services/ProductService.dart';
import '../../screens/cartitem/cartitem_screen.dart';
import '../../screens/search/searchproduct_screen.dart';
import 'headers.dart';


class Header extends StatelessWidget implements PreferredSizeWidget {
  final ProductService productService = ProductService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.black,
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  _showSearchDialog(context);
                },
              ),
            ),
            Flexible(
              child: const Text(
                "Tìm kiếm sản phẩm",
                style: TextStyle(color: Colors.white, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.white),
          onPressed: () async {
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
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => NotificationModal(),
            );
          },
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  // Show search dialog
  void _showSearchDialog(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            "Tìm kiếm sản phẩm",
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: searchController,
            autofocus: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Nhập từ khóa tìm kiếm...",
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Đóng",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () async {
                String query = searchController.text;
                if (query.isNotEmpty) {
                  // Search for products
                  List<ProductResponse> products =
                  await productService.GetProductByName(query);

                  if (products.isEmpty) {
                    Navigator.of(context).pop();
                    _showNoResultsScreen(context);
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchProductScreen(products: products),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                "Tìm Kiếm",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  // Show no results screen if no products found
  void _showNoResultsScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            "Không có sản phẩm",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Không có sản phẩm nào với tên này.",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Đóng",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/screens/cartitem/cartitem_screen.dart';
import '../../../core/DTO/response/ProductResponse.dart';
import '../../../core/services/CartService.dart';
import '../detail/productdetail_screen.dart';

class SearchProductScreen extends StatelessWidget {
  final List<ProductResponse> products;
  final CartService _cartService = CartService();

  SearchProductScreen({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kết quả tìm kiếm"),
        backgroundColor: Colors.white,
      ),
      body: products.isEmpty
          ? Center(
        child: const Text(
          "Không có sản phẩm nào.",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            shadowColor: Colors.grey.withOpacity(0.3),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: SizedBox(
                width: 80, // Adjust the width as needed
                height: 80, // Adjust the height as needed
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.imageUrl ?? "https://via.placeholder.com/150?text=No+Image",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                "Giá: ${product.price.toStringAsFixed(2)} VND",
                style: const TextStyle(color: Colors.black54),
              ),
              trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () async {
                try {
                  bool success = await _cartService.AddToCart(product.id);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Text("Đã thêm vào giỏ hàng."),
                          ],
                        ),
                        backgroundColor: Colors.black87,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Thêm vào giỏ hàng thất bại."),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          const Icon(Icons.error, color: Colors.red),
                          const SizedBox(width: 8),
                          Text("Có lỗi xảy ra: $e"),
                        ],
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
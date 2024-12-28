import 'package:flutter/material.dart';

import '../../../core/DTO/response/ProductResponse.dart';
import '../../../core/DTO/response/CategoryResponse.dart';
import '../../../core/services/ProductService.dart';
import '../../../core/services/CategoryService.dart';
import '../../layout/component/header.dart';

class ExploreScreen extends StatelessWidget {
  final CategoryService _categoryService = CategoryService();
  final ProductService _productService = ProductService();

  final List<String> carouselImages = [
    "https://authentic-shoes.com/wp-content/uploads/2024/01/adidas_Gazelle_evergreen_assetsP-1536x468.webp",
    "https://authentic-shoes.com/wp-content/uploads/2024/10/20240926111113-0.webp",
    "https://authentic-shoes.com/wp-content/uploads/2023/09/image-54-2048x711-2.webp",
    "https://authentic-shoes.com/wp-content/uploads/2024/12/Giay-Nau.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Carousel
            SizedBox(
              height: 200,
              width: double.infinity,
              child: PageView.builder(
                itemCount: carouselImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(carouselImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Categories
            FutureBuilder<List<CategoryResponse>>(
              future: _categoryService.GetAllCategory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Lỗi khi lấy danh mục"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text("Không có danh mục"));
                } else {
                  List<CategoryResponse> categories = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            onPressed: () {
                              // Action when a category is selected
                            },
                            child: Text(
                              category.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            // Title and Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Giày Tennis chính hãng",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Mua ngay các phiên bản giày Pickedball và Tennis mới nhất đến từ các thương hiệu Asics, Nike, Lacoste,... chính hãng 2024",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16),

            // Products
            FutureBuilder<List<ProductResponse>>(
              future: _productService.GetAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Lỗi khi lấy sản phẩm"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("Không có sản phẩm"));
                } else {
                  List<ProductResponse> products = snapshot.data!;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Image
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: Image.network(
                                    product.imageUrl ??
                                        "https://via.placeholder.com/150?text=No+Image",
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "${product.price.toStringAsFixed(2)} VND",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
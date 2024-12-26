import 'package:flutter/material.dart';

import '../../layout/component/header.dart';

class ExploreScreen extends StatelessWidget {
  final List<String> carouselImages = [
    "https://authentic-shoes.com/wp-content/uploads/2024/01/adidas_Gazelle_evergreen_assetsP-1536x468.webp",
    "https://authentic-shoes.com/wp-content/uploads/2024/10/20240926111113-0.webp",
    "https://authentic-shoes.com/wp-content/uploads/2023/09/image-54-2048x711-2.webp",
    "https://authentic-shoes.com/wp-content/uploads/2024/12/Giay-Nau.webp",
  ];

  final List<String> categories = [
    "Giày Sneaker",
    "Quần Áo",
    "Phụ Kiện",
    "Vợt Picked Ball",
  ];

  final List<Map<String, String>> products = [
    {
      "name": "Giày Nike Air Zoom",
      "image": "https://authentic-shoes.com/wp-content/uploads/2023/07/dr6191-101_blanc_1-600x268.png",
    },
    {
      "name": "Giày Asics",
      "image": "https://authentic-shoes.com/wp-content/uploads/2023/04/image__75__cc6b82033896498bbbfad5b30e04cd57.png",
    },

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
            // Danh mục sản phẩm
            SingleChildScrollView(
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
                        // Hành động khi bấm vào danh mục
                      },
                      child: Text(
                        category,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            // Tiêu đề
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Giày Tennis chính hãng",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
            // Danh sách sản phẩm
            Container(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true, // Prevent the GridView from expanding infinitely
                physics: const NeverScrollableScrollPhysics(), // Disable inner scrolling
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
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
                              product["image"]!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product["name"]!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Mô tả sản phẩm",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
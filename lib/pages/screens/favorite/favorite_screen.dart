import 'package:flutter/material.dart';
import 'package:flutter_ecom/core/DTO/request/FavouriteRequest.dart';
import 'package:flutter_ecom/core/DTO/response/FavouriteResponse.dart';
import '../../../core/config/number_formart.dart';
import '../../../core/services/FavouriteSerivce.dart';

class FavoriteScreen extends StatefulWidget {
  final String userName;

  const FavoriteScreen({Key? key, required this.userName}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final FavouriteService _favouriteService = FavouriteService();
  late Future<List<FavoriteResponse>> _favoriteProducts;

  @override
  void initState() {
    super.initState();
    _favoriteProducts = _loadFavorites();
  }

  Future<List<FavoriteResponse>> _loadFavorites() async {
    try {
      return await _favouriteService.GetFavouriteProduct(widget.userName);
    } catch (e) {
      print("Error loading favorites: $e");
      return [];
    }
  }

  void _removeFavorite(int productId) async {
    try {
      final request = FavouriteRequest(
          productId: productId, username: widget.userName);
      bool success = await _favouriteService.UnlikeProduct(request);
      if (success) {
        setState(() {
          _favoriteProducts = _loadFavorites();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đã xóa khỏi danh sách yêu thích!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(
              "Không thể xóa sản phẩm khỏi danh sách yêu thích.")),
        );
      }
    } catch (e) {
      print("Error removing favorite: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Có lỗi xảy ra khi xóa sản phẩm.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách yêu thích"),
      ),
      body: FutureBuilder<List<FavoriteResponse>>(
        future: _favoriteProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("Có lỗi xảy ra khi tải danh sách yêu thích!"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  SizedBox(height: 20),
                  Text("Danh sách yêu thích của bạn trống!",
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }

          final favorites = snapshot.data!;
          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: favorite.product.imageUrl != null
                            ? Image.network(
                          favorite.product.imageUrl!,
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )
                            : const Icon(
                            Icons.image, size: 60, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favorite.product.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formatCurrency(favorite.product.price),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _removeFavorite(favorite.product.id),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: "Xóa khỏi danh sách yêu thích",
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

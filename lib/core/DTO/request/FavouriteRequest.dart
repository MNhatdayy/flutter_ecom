class FavouriteRequest {
  int productId;
  String username;
  FavouriteRequest({required this.productId, required this.username});
  factory FavouriteRequest.fromJson(Map<String, dynamic> json){
    return FavouriteRequest(
      productId: json['productId'] as int,
      username: json['username'] as String
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'productId': productId,
      'username': username
    };
  }
}
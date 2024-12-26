class CategoryResponse {
  int id;
  String name;
  CategoryResponse({required this.id, required this.name});
  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}
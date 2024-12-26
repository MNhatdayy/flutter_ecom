class UserResponse {
  int id;
  String name;
  String email;
  String avatar;
  String phone;
  UserResponse({required this.id, required this.name, required this.email, required this.avatar, required this.phone});
  factory UserResponse.fromJson(Map<String, dynamic> json){
    return UserResponse(
        id: json['id'] as int,
        name: json['name'] as String,
        email: json['email'] as String,
        avatar: json['avatar'] as String,
        phone: json['phone'] as String
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar
    };
  }

}
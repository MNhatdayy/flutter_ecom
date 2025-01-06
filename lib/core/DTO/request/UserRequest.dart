class UserRequest {
  String name;
  String email;
  String avatar;
  String phone;
  UserRequest({ required this.name, required this.email, required this.avatar, required this.phone});
  factory UserRequest.fromJson(Map<String, dynamic> json){
    return UserRequest(
        name: json['name'] as String,
        email: json['email'] as String,
        avatar: json['avatar'] as String,
        phone: json['phone'] as String
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar
    };
  }

}
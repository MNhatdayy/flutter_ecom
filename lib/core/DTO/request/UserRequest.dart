class UserRequest {
  String username;
  String email;
  String avatar;
  String phone;
  UserRequest({ required this.username, required this.email, required this.avatar, required this.phone});
  factory UserRequest.fromJson(Map<String, dynamic> json){
    return UserRequest(
        username: json['username'] as String,
        email: json['email'] as String,
        avatar: json['avatar'] as String,
        phone: json['phone'] as String
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'avatar': avatar
    };
  }

}
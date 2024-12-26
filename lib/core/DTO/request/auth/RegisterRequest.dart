class RegisterRequest {
  String username;
  String email;
  String phone;
  String password;

  // Constructor
  RegisterRequest({
    required this.username,
    required this.email,
    required this.phone,
    required this.password,
  });

  // Factory constructor để khởi tạo từ JSON (nếu cần)
  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'RegisterRequest(username: $username, email: $email, phone: $phone, password: $password)';
  }
}

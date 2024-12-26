class TokenResponse {
  String token;

  // Constructor
  TokenResponse({required this.token});

  // Factory constructor để khởi tạo từ JSON
  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      token: json['token'] as String,
    );
  }

  // Phương thức chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }

  @override
  String toString() {
    return 'TokenResponse(token: $token)';
  }
}

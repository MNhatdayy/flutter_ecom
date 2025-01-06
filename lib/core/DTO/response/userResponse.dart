class UserResponse {
  final int id;
  final String username;
  final String password;
  final String email;
  final String phone;
  final List<dynamic> cartItemList;
  final List<dynamic> favouriteList;
  final String role;
  final int otp;
  final String? otpExpiration; // Để kiểu Nullable
  final String avatar;
  final bool enabled;
  final bool accountNonLocked;
  final bool credentialsNonExpired;
  final bool accountNonExpired;

  UserResponse({
    required this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.phone,
    required this.cartItemList,
    required this.favouriteList,
    required this.role,
    required this.otp,
    this.otpExpiration,  // Có thể null
    required this.avatar,
    required this.enabled,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
    required this.accountNonExpired,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      cartItemList: json['cartItemList'] ?? [],
      favouriteList: json['favouriteList'] ?? [],
      role: json['role'] ?? '',
      otp: json['otp'] ?? 0,
      otpExpiration: json['otpExpiration'],
      avatar: json['avatar'] ?? '',
      enabled: json['enabled'] ?? false,
      accountNonLocked: json['accountNonLocked'] ?? true,
      credentialsNonExpired: json['credentialsNonExpired'] ?? true,
      accountNonExpired: json['accountNonExpired'] ?? true,
    );
  }
}

class LoginPayload {
  String email;
  String password;

  LoginPayload({required this.email, required this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}

class RegisterPayload {
  String email;
  String password;

  RegisterPayload({required this.email, required this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}

class UserData {
  String id;
  String email;

  UserData({required this.id, required this.email});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      UserData(id: json['id'], email: json['email']);
}

class LoginData {
  String accessToken;
  int accessTokenExpiresAt;
  String refreshToken;
  int refreshTokenExpiresAt;
  String tokenType;
  UserData user;

  LoginData({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    required this.refreshToken,
    required this.refreshTokenExpiresAt,
    required this.tokenType,
    required this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    accessToken: json['access_token'],
    accessTokenExpiresAt: json['access_token_expires_at'],
    refreshToken: json['refresh_token'],
    refreshTokenExpiresAt: json['refresh_token_expires_at'],
    tokenType: json['token_type'],
    user: UserData.fromJson(json['user']),
  );
}

class RegisterData {
  String id;
  String email;

  RegisterData({required this.id, required this.email});

  factory RegisterData.fromJson(Map<String, dynamic> json) =>
      RegisterData(id: json['id'], email: json['email']);
}

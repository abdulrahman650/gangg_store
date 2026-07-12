class LoginModel {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAtUtc;

  const LoginModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAtUtc,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      expiresAtUtc: DateTime.parse(json["expiresAtUtc"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "expiresAtUtc": expiresAtUtc.toIso8601String(),
    };
  }
}
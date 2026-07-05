class RegisterModel {
  final String message;

  const RegisterModel({
    required this.message,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      message: json['message'],
    );
  }
}
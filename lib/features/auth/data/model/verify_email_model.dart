class VerifyEmailModel {
  final String message;

  const VerifyEmailModel({
    required this.message,
  });

  factory VerifyEmailModel.fromJson(Map<String, dynamic> json) {
    return VerifyEmailModel(
      message: json["message"],
    );
  }
}
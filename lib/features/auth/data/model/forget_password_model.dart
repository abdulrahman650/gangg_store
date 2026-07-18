class ForgotPasswordModel {
  final String message;

  ForgotPasswordModel({
    required this.message,
  });

  factory ForgotPasswordModel.fromJson(String message) {
    return ForgotPasswordModel(
      message: message,
    );
  }
}
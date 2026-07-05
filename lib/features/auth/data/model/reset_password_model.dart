class ResetPasswordModel {
  final String message;

  const ResetPasswordModel({
    required this.message,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      message: json["message"],
    );
  }
}
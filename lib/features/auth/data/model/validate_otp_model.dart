class ValidateOtpModel {
  final String message;

  const ValidateOtpModel({
    required this.message,
  });

  factory ValidateOtpModel.fromJson(Map<String, dynamic> json) {
    return ValidateOtpModel(
      message: json["message"],
    );
  }
}
class ValidateOtpModel {
  final String message;

  const ValidateOtpModel({
    required this.message,
  });

  factory ValidateOtpModel.fromJson(dynamic json) {
    return ValidateOtpModel(
      message: json.toString(),
    );
  }
}
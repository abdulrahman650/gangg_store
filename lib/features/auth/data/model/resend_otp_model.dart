class ResendOtpModel {
  final String message;

  const ResendOtpModel({
    required this.message,
  });

  factory ResendOtpModel.fromJson(Map<String, dynamic> json) {
    return ResendOtpModel(
      message: json["message"],
    );
  }
}
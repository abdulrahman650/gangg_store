class VerifyEmailModel {
  final String message;

  const VerifyEmailModel({
    required this.message,
  });

  factory VerifyEmailModel.fromResponse(dynamic response) {
    if (response is String) {
      return VerifyEmailModel(message: response);
    }

    return VerifyEmailModel(
      message: response["message"] ?? "",
    );
  }
}
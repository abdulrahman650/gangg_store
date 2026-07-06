class ResetPasswordModel {
  final String message;

  const ResetPasswordModel({
    required this.message,
  });

  factory ResetPasswordModel.fromResponse(dynamic response) {
    if (response is String) {
      return ResetPasswordModel(message: response);
    }

    return ResetPasswordModel(
      message: response["message"],
    );
  }
}
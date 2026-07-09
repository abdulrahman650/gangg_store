class ChangePasswordModel {
  final String message;

  const ChangePasswordModel({
    required this.message,
  });

  factory ChangePasswordModel.fromResponse(dynamic response) {
    if (response is String) {
      return ChangePasswordModel(message: response);
    }

    return ChangePasswordModel(
      message: response["message"] ?? "Password changed successfully",
    );
  }
}
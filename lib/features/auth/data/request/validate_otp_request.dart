class ValidateOtpRequest {
  final String email;
  final String otp;

  const ValidateOtpRequest({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "otp": otp,
    };
  }
}
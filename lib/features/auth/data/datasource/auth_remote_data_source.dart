import '../../../../core/network/api_consumer.dart';
import '../../../../core/network/api_endpoints.dart';
import '../model/forget_password_model.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';
import '../model/resend_otp_model.dart';
import '../model/reset_password_model.dart';
import '../model/user_model.dart';
import '../model/validate_otp_model.dart';
import '../model/verify_email_model.dart';
import '../request/forget_password_request.dart';
import '../request/login_request.dart';
import '../request/register_request.dart';
import '../request/resend_otp_request.dart';
import '../request/reset_password_request.dart';
import '../request/validate_otp_request.dart';
import '../request/verify_email_request.dart';


abstract class AuthRemoteDataSource {
  Future<LoginModel> login(LoginRequest request);
  Future<RegisterModel> register(RegisterRequest request);

  Future<VerifyEmailModel> verifyEmail(
      VerifyEmailRequest request,
      );
  Future<ValidateOtpModel> validateOtp(
      ValidateOtpRequest request,
      );

  Future<ResendOtpModel> resendOtp(
      ResendOtpRequest request,
      );

  Future<ResetPasswordModel> resetPassword(
      ResetPasswordRequest request,
      );

  Future<UserModel> getMe();

  Future<ForgotPasswordModel> forgotPassword(
      ForgotPasswordRequest request,
      );

}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSourceImpl(this.api);

  @override
  Future<LoginModel> login(
      LoginRequest request,
      ) async {
    final response = await api.post(
      EndPoints.login,
      data: request.toJson(),
    );

    return LoginModel.fromJson(response);
  }

  @override
  Future<RegisterModel> register(RegisterRequest request) async {
    final response = await api.post(
      EndPoints.register,
      data: request.toJson(),
    );

    return RegisterModel.fromJson(response);
  }
  @override
  Future<VerifyEmailModel> verifyEmail(
      VerifyEmailRequest request,
      ) async {
    final response = await api.post(
      EndPoints.verifyEmail,
      data: request.toJson(),
    );

    return VerifyEmailModel.fromJson(response);
  }

  @override
  Future<ResendOtpModel> resendOtp(
      ResendOtpRequest request,
      ) async {
    final response = await api.post(
      EndPoints.resendOtp,
      data: request.toJson(),
    );

    return ResendOtpModel.fromJson(response);
  }

  @override
  Future<ValidateOtpModel> validateOtp(
      ValidateOtpRequest request,
      ) async {
    final response = await api.post(
      EndPoints.validateOtp,
      data: request.toJson(),
    );
    print(response);
    print(response.runtimeType);
    return ValidateOtpModel.fromJson(response);
  }

  @override
  Future<ResetPasswordModel> resetPassword(
      ResetPasswordRequest request,
      ) async {
    final response = await api.post(
      EndPoints.resetPassword,
      data: request.toJson(),
    );

    print(response);
    print(response.runtimeType);

    return ResetPasswordModel.fromResponse(response);
  }

  @override
  Future<UserModel> getMe() async {
    final response = await api.get(
      EndPoints.me,
    );

    return UserModel.fromJson(response);
  }
  @override
  Future<ForgotPasswordModel> forgotPassword(
      ForgotPasswordRequest request,
      ) async {
    final response = await api.post(
      EndPoints.forgotPassword,
      data: request.toJson(),
    );

    return ForgotPasswordModel.fromJson(response);
  }
}

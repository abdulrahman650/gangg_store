import '../../../profile/data/model/change_password_model.dart';
import '../../../profile/data/request/change_password_request.dart';
import '../datasource/auth_remote_data_source.dart';
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
import '../request/change_password_request.dart';

abstract class AuthRepository {
  Future<LoginModel> login(LoginRequest request);
  Future<RegisterModel> register(RegisterRequest request);
  Future<ForgotPasswordModel> forgotPassword(
      ForgotPasswordRequest request,
      );

  Future<VerifyEmailModel> verifyEmail(
      VerifyEmailRequest request,
      );

  Future<ResendOtpModel> resendOtp(
      ResendOtpRequest request,
      );
  Future<ValidateOtpModel> validateOtp(
      ValidateOtpRequest request,
      );

  Future<ResetPasswordModel> resetPassword(
      ResetPasswordRequest request,
      );

  Future<ChangePasswordModel> changePassword(
      ChangePasswordRequest request,
      );
  Future<UserModel> getMe();

}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  ///login
  @override
  Future<LoginModel> login(
      LoginRequest request,
      ) async {
    return await remoteDataSource.login(request);
  }
///register
  @override
  Future<RegisterModel> register(RegisterRequest request) {
    return remoteDataSource.register(request);
  }

  ///verifyEmail
  @override
  Future<VerifyEmailModel> verifyEmail(
      VerifyEmailRequest request,
      ) {
    return remoteDataSource.verifyEmail(request);
  }

  ///resendOtp
  @override
  Future<ResendOtpModel> resendOtp(
      ResendOtpRequest request,
      ) {
    return remoteDataSource.resendOtp(request);
  }

///validateOtp
  @override
  Future<ValidateOtpModel> validateOtp(
      ValidateOtpRequest request,
      ) {
    return remoteDataSource.validateOtp(request);
  }

  ///forgotPassword
  @override
  Future<ForgotPasswordModel> forgotPassword(
      ForgotPasswordRequest request,
      ) {
    return remoteDataSource.forgotPassword(request);
  }

  ///resetPassword
  @override
  Future<ResetPasswordModel> resetPassword(
      ResetPasswordRequest request,
      ) {
    return remoteDataSource.resetPassword(request);
  }

  ///changePassword
  @override
  Future<ChangePasswordModel> changePassword(
      ChangePasswordRequest request,
      ) {
    return remoteDataSource.changePassword(request);
  }

  ///getMe
  @override
  Future<UserModel> getMe() {
    return remoteDataSource.getMe();
  }


}
import '../../data/model/login_model.dart';
import '../../data/model/user_model.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}
/// Login
class LoginSuccess extends AuthState {
  final LoginModel loginModel;

  const LoginSuccess(this.loginModel);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}

///Register
class RegisterSuccess extends AuthState {
  final String message;

  const RegisterSuccess(this.message);
}
///VerifyEmail
class VerifyEmailSuccess extends AuthState {
  final String message;

  const VerifyEmailSuccess(this.message);
}
///ResendOtp
class ResendOtpSuccess extends AuthState {
  final String message;

  const ResendOtpSuccess(this.message);
}

class ValidateOtpSuccess extends AuthState {
  final String message;

  const ValidateOtpSuccess(this.message);
}
///ResetPassword
class ResetPasswordSuccess extends AuthState {
  final String message;

  const ResetPasswordSuccess(this.message);
}
class GetUserSuccess extends AuthState {
  final UserModel user;

  const GetUserSuccess(this.user);
}

///ForgotPassword
class ForgotPasswordSuccess extends AuthState {
  final String message;

  const ForgotPasswordSuccess(this.message);
}

///ChangePassword
class ChangePasswordSuccess extends AuthState {
  final String message;

  const ChangePasswordSuccess(this.message);
}
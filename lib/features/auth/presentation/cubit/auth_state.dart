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

class LoginSuccess extends AuthState {
  final LoginModel loginModel;

  const LoginSuccess(this.loginModel);
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);
}
class RegisterSuccess extends AuthState {
  final String message;

  const RegisterSuccess(this.message);
}
class VerifyEmailSuccess extends AuthState {
  final String message;

  const VerifyEmailSuccess(this.message);
}

class ResendOtpSuccess extends AuthState {
  final String message;

  const ResendOtpSuccess(this.message);
}

class ValidateOtpSuccess extends AuthState {
  final String message;

  const ValidateOtpSuccess(this.message);
}

class ResetPasswordSuccess extends AuthState {
  final String message;

  const ResetPasswordSuccess(this.message);
}
class GetUserSuccess extends AuthState {
  final UserModel user;

  const GetUserSuccess(this.user);
}
class ForgotPasswordSuccess extends AuthState {
  final String message;

  const ForgotPasswordSuccess(this.message);
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/cache_keys.dart';

import '../../../profile/data/request/change_password_request.dart';
import '../../data/model/user_model.dart';
import '../../data/repos/auth_repository.dart';
import '../../data/request/forget_password_request.dart';
import '../../data/request/login_request.dart';
import '../../data/request/register_request.dart';
import '../../data/request/resend_otp_request.dart';
import '../../data/request/reset_password_request.dart';
import '../../data/request/validate_otp_request.dart';
import '../../data/request/verify_email_request.dart';
import 'auth_state.dart';
import '../../data/request/change_password_request.dart';
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(const AuthInitial());

  /// Login
  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();

  final lastNameController = TextEditingController();
  final otpController = TextEditingController();
  UserModel? currentUser;
  final newPasswordController = TextEditingController();

  final currentPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    emit(const AuthLoading());

    try {
      final response = await repository.login(
        LoginRequest(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );

      await CacheHelper.saveData(
        key: CacheKeys.accessToken,
        value: response.accessToken,
      );

      await CacheHelper.saveData(
        key: CacheKeys.refreshToken,
        value: response.refreshToken,
      );

      await CacheHelper.saveData(
        key: CacheKeys.isLoggedIn,
        value: true,
      );
      await CacheHelper.saveData(
        key: CacheKeys.isGuest,
        value: false,
      );

      emit(LoginSuccess(response));
      debugPrint("====== LOGIN SUCCESS ======");
    } on RemoteException catch (e) {
      emit(AuthError(e.message));
    } catch (_) {
      emit(const AuthError("Something went wrong"));
    }
  }
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;

    emit(const AuthLoading());

    try {
      final response = await repository.register(
        RegisterRequest(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );

      emit(RegisterSuccess(response.message));
    } on RemoteException catch (e) {
      emit(AuthError(e.message));
    } catch (_) {
      emit(const AuthError("Something went wrong"));
    }
  }
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    otpController.dispose();
    newPasswordController.dispose();

    return super.close();
  }
  Future<void> verifyEmail({
    required String email,
  }) async {
    emit(AuthLoading());

    try {
      final response = await repository.verifyEmail(
        VerifyEmailRequest(
          email: email,
          otp: otpController.text,
        ),
      );

      emit(
        VerifyEmailSuccess(
          response.message,
        ),
      );
    } on AppException catch (e) {
      emit(
        AuthError(
          e.message,
        ),
      );
    }
  }
  Future<void> resendOtp({
    required String email,
  }) async {
    emit(AuthLoading());

    try {
      final response = await repository.resendOtp(
        ResendOtpRequest(
          email: email,
        ),
      );

      emit(
        ResendOtpSuccess(
          response.message,
        ),
      );
    } on AppException catch (e) {
      emit(
        AuthError(
          e.message,
        ),
      );
    }
  }
  Future<void> validateOtp({
    required String email,
  }) async {

    emit(AuthLoading());

    try {

      final response = await repository.validateOtp(
        ValidateOtpRequest(
          email: email,
          otp: otpController.text,
        ),
      );

      emit(
        ValidateOtpSuccess(
          response.message,
        ),
      );

    } on AppException catch (e) {

      emit(
        AuthError(
          e.message,
        ),
      );

    }
  }
  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(const AuthLoading());

    try {
      final response = await repository.forgotPassword(
        ForgotPasswordRequest(
          email: email,
        ),
      );

      emit(
        ForgotPasswordSuccess(
          response.message,
        ),
      );
    } on AppException catch (e) {
      emit(
        AuthError(
          e.message,
        ),
      );
    }
  }
  Future<void> resetPassword({
    required String email,
  }) async {
    emit(AuthLoading());

    try {
      final response = await repository.resetPassword(
        ResetPasswordRequest(
          email: email,
          otp: otpController.text,
          newPassword: newPasswordController.text,
        ),
      );

      emit(
        ResetPasswordSuccess(
          response.message,
        ),
      );
    } on AppException catch (e) {
      emit(
        AuthError(
          e.message,
        ),
      );
    }
  }

  Future<void> changePassword() async {
    emit(const AuthLoading());

    try {
      final response = await repository.changePassword(
        ChangePasswordRequest(
          currentPassword: currentPasswordController.text,
          newPassword: newPasswordController.text,
          confirmNewPassword: confirmNewPasswordController.text,
        ),
      );

      emit(
        ChangePasswordSuccess(
          response.message,
        ),
      );
    } on AppException catch (e) {
      emit(
        AuthError(
          e.message,
        ),
      );
    }
  }
  Future<void> getMe() async {
    emit(AuthLoading());

    try {
      final response = await repository.getMe();

      currentUser = response;

      emit(
        GetUserSuccess(response),
      );
    } on AppException catch (e) {
      emit(
        AuthError(e.message),
      );
    }
  }
  bool get isLoggedIn {
    return CacheHelper.getData(CacheKeys.accessToken) != null;
  }

}
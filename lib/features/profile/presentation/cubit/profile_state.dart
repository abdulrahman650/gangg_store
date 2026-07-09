import '../../../auth/data/model/user_model.dart';
import 'package:image_picker/image_picker.dart';
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel user;

  ProfileSuccess(this.user);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
class LogoutLoading extends ProfileState {}

class LogoutSuccess extends ProfileState {}

class LogoutError extends ProfileState {
  final String message;

  LogoutError(this.message);
}
class PickImageSuccess extends ProfileState {
  final XFile image;

  PickImageSuccess(this.image);
}
class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {}

class UpdateProfileError extends ProfileState {
  final String message;

  UpdateProfileError(this.message);
}
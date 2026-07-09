import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/profile/presentation/cubit/profile_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/cache_keys.dart';
import '../../../auth/data/datasource/auth_remote_data_source.dart';
import '../../../auth/data/model/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.remote) : super(ProfileInitial());

  final AuthRemoteDataSource remote;
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final user = await remote.getMe();

      final cachedName =
          CacheHelper.getData(CacheKeys.fullName) ?? user.fullName;

      final cachedEmail =
          CacheHelper.getData(CacheKeys.email) ?? user.email;

      emit(
        ProfileSuccess(
          UserModel(
            userId: user.userId,
            fullName: cachedName,
            email: cachedEmail,
            profilePicture: user.profilePicture,
          ),
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
///logout
  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      await CacheHelper.removeData(CacheKeys.accessToken);
      await CacheHelper.removeData(CacheKeys.refreshToken);
      await CacheHelper.removeData(CacheKeys.user);
      await CacheHelper.removeData(CacheKeys.email);
      await CacheHelper.removeData(CacheKeys.isLoggedIn);

      emit(LogoutSuccess());
    } catch (e) {
      emit(
        LogoutError(
          e.toString(),
        ),
      );
    }
  }
  ///pickImage
  Future<void> pickImage() async {
    final image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    selectedImage = image;

    await CacheHelper.saveData(
      key: CacheKeys.profileImage,
      value: image.path,
    );

    emit(
      PickImageSuccess(image),
    );
  }

  Future<void> updateProfile({
    required String fullName,
    required String email,
  }) async {
    emit(UpdateProfileLoading());

    try {
      await CacheHelper.saveData(
        key: CacheKeys.fullName,
        value: fullName,
      );

      await CacheHelper.saveData(
        key: CacheKeys.email,
        value: email,
      );

      emit(UpdateProfileSuccess());

      getProfile();
    } catch (e) {
      emit(
        UpdateProfileError(
          e.toString(),
        ),
      );
    }
  }
}
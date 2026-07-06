import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/profile/presentation/cubit/profile_state.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/cache_keys.dart';
import '../../../auth/data/datasource/auth_remote_data_source.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.remote) : super(ProfileInitial());

  final AuthRemoteDataSource remote;

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final user = await remote.getMe();

      emit(ProfileSuccess(user));
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
}
// core/services/service_locators.dart

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../network/api_consumer.dart';
import '../network/dio_consumer.dart';
import '../../features/auth/data/datasource/auth_remote_data_source.dart';
import '../../features/category/data/datasource/category_remote_data_source.dart';
import '../../features/category/data/datasource/category_remote_data_source_impl.dart';

import '../../features/category/data/repos/repo.dart';

import '../../features/category/presentation/cubit/category_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {

  getIt.registerLazySingleton<Dio>(
        () => Dio(),
  );

  getIt.registerLazySingleton<ApiConsumer>(
        () => DioConsumer(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
      getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
    ),
  );

  getIt.registerFactory<AuthCubit>(
        () => AuthCubit(
      getIt<AuthRepository>(),
    ),
  );

  getIt.registerFactory<ProfileCubit>(
        () => ProfileCubit(getIt()),
  );
    getIt.registerLazySingleton<CategoryRemoteDataSource>(
        () => CategoryRemoteDataSourceImpl(
      getIt<ApiConsumer>(),
    ),
  );


  getIt.registerLazySingleton<CategoryRepository>(
        () => CategoryRepositoryImpl(
      getIt<CategoryRemoteDataSource>(),
    ),
  );


  getIt.registerFactory<CategoryCubit>(
        () => CategoryCubit(
      getIt<CategoryRepository>(),
    ),
  );
  
}
import 'package:dio/dio.dart';
import 'package:gangg_store/features/cart/data/datasource/Cart_Remote_Data_Source.dart';
import 'package:gangg_store/features/cart/data/repos/cart_repositry.dart';
import 'package:gangg_store/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repos/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../network/api_consumer.dart';
import '../network/dio_consumer.dart';
import '../../features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:gangg_store/features/reviews/data/datasource/rewies_remote_data_source.dart';
import 'package:gangg_store/features/reviews/data/repos/review_repository.dart';
import 'package:gangg_store/features/reviews/presentation/cubit/review_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );

  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));

  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
  getIt.registerLazySingleton<ReviewRemoteDataSource>(
    () => ReviewRemoteDataSourceImpl(getIt<ApiConsumer>()),
  );

  getIt.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(getIt<ReviewRemoteDataSource>()),
  );

  getIt.registerFactory<ReviewCubit>(
    () => ReviewCubit(getIt<ReviewRepository>()),
  );
}

 getIt.registerLazySingleton<CartRemoteDataSource>(
  () => CartRemoteDataSourceImpl(
    getIt<ApiConsumer>(),
  ),
);

getIt.registerLazySingleton<CartRepositry>(
  () => CartRepositryImpl(
    getIt<CartRemoteDataSource>(),
  ),
);

getIt.registerFactory<CartCubit>(
  () => CartCubit(
     repositry: getIt<CartRepositry>(),
  ),
);
}

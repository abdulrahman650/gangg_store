import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/search/presentation/cubit/search_cubit.dart';
import '../network/api_consumer.dart';
import '../network/dio_consumer.dart';

import '../../features/auth/data/datasource/auth_remote_data_source.dart';
import '../../features/auth/data/repos/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';

import '../../features/home/data/repos/home_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';

import '../../features/profile/presentation/cubit/profile_cubit.dart';

import '../../features/prodeuct_details/data/repos/product_details_repository.dart';
import '../../features/prodeuct_details/presentation/cubit/product_details_cubit.dart';

import '../../features/cart/data/datasource/Cart_Remote_Data_Source.dart';
import '../../features/cart/data/repos/cart_repositry.dart';
import '../../features/cart/presentation/cubit/cart_cubit.dart';

import 'package:gangg_store/features/reviews/data/datasource/rewies_remote_data_source.dart';
import 'package:gangg_store/features/reviews/data/repos/review_repository.dart';
import 'package:gangg_store/features/reviews/presentation/cubit/review_cubit.dart';

import '../../features/favourites/presentation/cubit/wishlist_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ===================== Dio =====================

  getIt.registerLazySingleton<Dio>(
        () => Dio(),
  );

  // ===================== Api Consumer =====================

  getIt.registerLazySingleton<ApiConsumer>(
        () => DioConsumer(
      dio: getIt<Dio>(),
    ),
  );

  // ===================== Auth =====================

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

  // ===================== Home =====================

  getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(
      getIt<ApiConsumer>(),
    ),
  );

  getIt.registerFactory<HomeCubit>(
        () => HomeCubit(
      getIt<HomeRepository>(),
    ),
  );

  // ===================== Product Details =====================

  getIt.registerLazySingleton<ProductDetailsRepository>(
        () => ProductDetailsRepositoryImpl(
      getIt<ApiConsumer>(),
    ),
  );

  getIt.registerFactory<ProductDetailsCubit>(
        () => ProductDetailsCubit(
      getIt<ProductDetailsRepository>(),
      getIt<ReviewRepository>(),
    ),
  );

  // ===================== Profile =====================

  getIt.registerFactory<ProfileCubit>(
        () => ProfileCubit(
      getIt<AuthRemoteDataSource>(),
    ),
  );

  // ===================== Reviews =====================

  getIt.registerLazySingleton<ReviewRemoteDataSource>(
        () => ReviewRemoteDataSourceImpl(
      getIt<ApiConsumer>(),
    ),
  );

  getIt.registerLazySingleton<ReviewRepository>(
        () => ReviewRepositoryImpl(
      getIt<ReviewRemoteDataSource>(),
    ),
  );

  getIt.registerFactory<ReviewCubit>(
        () => ReviewCubit(
      getIt<ReviewRepository>(),
    ),
  );

// ===================== Cart =====================

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

  getIt.registerLazySingleton<CartCubit>(
        () => CartCubit(
      repositry: getIt<CartRepositry>(),
    ),
  );

  // ===================== Wishlist =====================

  getIt.registerSingleton<WishlistCubit>(
    WishlistCubit(),
  );


// ===================== Search =====================

  getIt.registerFactory<SearchCubit>(
        () => SearchCubit(
      getIt<HomeRepository>(),
    ),
  );
}

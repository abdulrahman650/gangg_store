import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/cache_helper.dart';
import 'core/services/service_locators.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/cart/presentation/cubit/cart_cubit.dart';
import 'features/cart/presentation/screens/check_order_sereen.dart';
import 'features/category/presentation/cubit/category_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/layout/presentation/screens/layout_screen.dart';
import 'features/profile/presentation/cubit/profile_cubit.dart';
import 'features/reviews/presentation/cubit/review_cubit.dart';
import 'features/reviews/presentation/screens/reviews_screen.dart';
import 'features/favourites/presentation/cubit/wishlist_cubit.dart';
import 'features/search/presentation/cubit/search_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),

        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),

        BlocProvider(
          create: (_) => getIt<ProfileCubit>(),
        ),

        BlocProvider(
          create: (_) => getIt<HomeCubit>()..fetchHomeData(),
        ),

        BlocProvider<CartCubit>(
          create: (_) {
            print("CartCubit Created");

            return getIt<CartCubit>();
          },
        ),
        BlocProvider<CategoryCubit>(
          create: (_) => getIt<CategoryCubit>(),
        ),

        BlocProvider<WishlistCubit>(
          create: (_) => getIt<WishlistCubit>(),
        ),
        BlocProvider<SearchCubit>(
          create: (_) => getIt<SearchCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          final authCubit = context.read<AuthCubit>();

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.customLightTheme,
            darkTheme: AppTheme.customDarkTheme,
            themeMode: themeMode,
            // home: authCubit.isLoggedIn
            //     ? const Layout()
            //     : const LoginView(),
              home:LoginView(),
          );
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/cache_helper.dart';
import 'core/services/service_locators.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/layout/presentation/screens/layout_screen.dart';
>>>>>>> Stashed changes




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
<<<<<<< Updated upstream
    return MaterialApp(
    themeMode: ThemeMode.light,
      home: Scaffold(),
=======
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => getIt<AuthCubit>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
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
            home: const LoginView(),
          );
        },
      ),
>>>>>>> Stashed changes
    );
  }
}
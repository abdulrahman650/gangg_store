import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class ThemeCubit extends Cubit<ThemeMode> {
//   ThemeCubit() : super(ThemeMode.dark);
//
//   bool get isDark => state == ThemeMode.dark;
//
//   void toggleTheme() {
//     emit(isDark ? ThemeMode.light : ThemeMode.dark);
//   }
// }
//
// extension ThemeCubitX on BuildContext {
//   ThemeCubit get theme => read<ThemeCubit>();
//   bool get isDark => watch<ThemeCubit>().state == ThemeMode.dark;
// }
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light);

  bool get isDark => state == ThemeMode.dark;

  void toggleTheme() {
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}

extension ThemeCubitX on BuildContext {
  ThemeCubit get theme => read<ThemeCubit>();

  bool get isDark =>
      watch<ThemeCubit>().state == ThemeMode.dark;
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/services/service_locators.dart';
import '../cubit/category_cubit.dart';
import '../widgets/category_grid..dart';
import '../widgets/category_header.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CategoryCubit>()..getCategories(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [

                CategoryHeader(),
                SizedBox(height: 20),
                Expanded(
                  child: CategoryGrid(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
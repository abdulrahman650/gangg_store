import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/home_body.dart';
import '../widgets/home_error_widget.dart';
import '../widgets/shimmer/home_loading_shimmer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const HomeLoadingShimmer();
            }

            if (state is HomeError) {
              return HomeErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<HomeCubit>().fetchHomeData();
                },
              );
            }

            if (state is HomeSuccess) {
              return HomeBody(state: state);
            }

            return const HomeLoadingShimmer();
          },
        ),
      ),
    );
  }
}
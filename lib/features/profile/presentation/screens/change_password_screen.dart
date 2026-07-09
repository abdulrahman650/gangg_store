import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/utils/app_snack_bar.dart';
import 'package:gangg_store/core/utils/default_elevated_button.dart';
import 'package:gangg_store/core/utils/default_text_form_field.dart';
import 'package:gangg_store/core/utils/validator.dart';
import 'package:gangg_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:gangg_store/features/auth/presentation/cubit/auth_state.dart';
import 'package:gangg_store/features/auth/presentation/widgets/CustomAppBar.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            AppSnackBar.success(
              context,
              state.message,
            );

            cubit.currentPasswordController.clear();
            cubit.newPasswordController.clear();
            cubit.confirmNewPasswordController.clear();

            Navigator.pop(context);
          }

          if (state is AuthError) {
            AppSnackBar.error(
              context,
              state.message,
            );
          }
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                        key: formKey,
                        child: Column(
                            children: [
                            const SizedBox(height: 24),
                        const CustomAppBar(),
                        const SizedBox(height: 50),

                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(.08),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                            const Icon(
                            Icons.lock_reset_rounded,
                            size: 70,
                            color: AppColors.primary,
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "Change Password",
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Enter your current password then choose a new password.",
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium,
                          ),

                          const SizedBox(height: 30),
                          DefaultTextFormField(
                            hintText: 'Current Password',
                            controller: cubit.currentPasswordController,
                            prefixIconImageName: 'lock',
                            validator: Validators.validatePassword,
                            isPassword: true,
                          ),

                          const SizedBox(height: 16),

                          DefaultTextFormField(
                            hintText: 'New Password',
                            controller: cubit.newPasswordController,
                            prefixIconImageName: 'lock',
                            validator: Validators.validatePassword,
                            isPassword: true,
                          ),

                          const SizedBox(height: 16),

                          DefaultTextFormField(
                            hintText: 'Confirm New Password',
                            controller: cubit.confirmNewPasswordController,
                            prefixIconImageName: 'lock',
                            validator: (value) {
                              if (value != cubit.newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return Validators.validatePassword(value);
                            },
                            isPassword: true,
                          ),

                          const SizedBox(height: 30),

                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              if (state is AuthLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return DefaultElevatedButton(
                                label: 'Update Password',
                                backgroundColor: AppColors.primary,
                                onPressed: () {
                                  if (!formKey.currentState!.validate()) return;

                                  cubit.changePassword();
                                },
                              );
                            },
                          ),
                            ],
                          ),
                        ),
                            ],
                        ),
                    ),
                ),
            ),
        ),
    );
  }
}
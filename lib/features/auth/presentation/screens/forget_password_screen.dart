import 'package:flutter/material.dart';
import 'package:gangg_store/features/auth/presentation/screens/verifay_account_screen.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../../../../core/utils/default_text_form_field.dart';
import '../widgets/CustomAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          AppSnackBar.success(context, state.message);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VerifyAccountView(
                isFromForgotPassword: true,
                email: emailController.text.trim(),
              ),
            ),
          );
        }

        if (state is AuthError) {
          AppSnackBar.error(context, state.message);
        }
      },
  child: Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(),
              const SizedBox(height: 20),

              Image.asset(
                'assets/images/imageForgetPassScreen.png',
                width: double.infinity,
              ),

              const SizedBox(height: 24),

              Text(
                'Forgot Password?',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Don\'t worry! It happens. Please enter the address associated with your account.',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.darkGray,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              DefaultTextFormField(
                hintText: 'Email Address',
                controller: emailController,
                prefixIconImageName: 'email',
              ),

              const SizedBox(height: 24),

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return DefaultElevatedButton(
                    prefixSvgPath: "assets/icons/arrowRight.svg",
                    label: 'Send Code',
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      if (emailController.text.trim().isEmpty) {
                        AppSnackBar.error(
                          context,
                          "Please enter your email",
                        );
                        return;
                      }

                      context.read<AuthCubit>().forgotPassword(
                        email: emailController.text.trim(),
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 24),

              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.logout,
                      color: AppColors.primary,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Back to Login',
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
);
  }
}
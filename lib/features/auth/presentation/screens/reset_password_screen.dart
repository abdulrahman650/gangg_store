import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/auth/presentation/widgets/CustomAppBar.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../../../../core/utils/default_text_form_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'login_screen.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email});
  final String email;


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cubit = context.read<AuthCubit>();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {

        if(state is ResetPasswordSuccess){

          AppSnackBar.success(
            context,
            state.message,
          );

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginView(),
            ),
                (_) => false,
          );

        }

        if(state is AuthError){

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
                CustomAppBar(),
                const SizedBox(height: 70),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.09),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      // Illustration
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.simony,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_reset,
                          color: AppColors.primary,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Reset Password
                      Text(
                        'Reset Password',
                        style: textTheme.headlineSmall?.copyWith(
                          // color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create a new, strong password to secure your account.',
                        style: textTheme.titleSmall?.copyWith(
                          color: AppColors.darkGray,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // New Password
                      DefaultTextFormField(
                        hintText: 'New Password',
                        controller: cubit.newPasswordController,
                        prefixIconImageName: 'lock',
                        validator: Validators.validatePassword,
                        isPassword: true,
                      ),
                      const SizedBox(height: 16),
                      // Confirm New Password
                      DefaultTextFormField(
                        hintText: 'Confirm New Password',
                        controller: confirmPasswordController,
                        prefixIconImageName: 'lock',
                        validator: (value) {
                          if (value != cubit.newPasswordController.text){
                            return 'Passwords do not match';
                          }
                          return Validators.validatePassword(value);
                        },
                        isPassword: true,
                      ),
                      const SizedBox(height: 32),
                      // Reset Password Button
                      DefaultElevatedButton(
                        label: 'Reset Password',
                        prefixSvgPath: "assets/icons/arrowRight.svg",
                        backgroundColor: AppColors.primary,
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;

                          cubit.resetPassword(
                            email: email,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      // Back to Sign In
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginView()),
                                (route) => false,
                          );
                        },
                        child: Text(
                          'Back to Sign In',
                          style: textTheme.titleSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

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
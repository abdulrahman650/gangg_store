import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../../../../core/utils/default_text_form_field.dart';
import '../../../../core/utils/validator.dart';
import '../../../layout/presentation/screens/layout_screen.dart';
import '../../data/model/auth_model.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../screens/forget_password_screen.dart';
import 'package:provider/provider.dart';
class SectionFelidLogin extends StatelessWidget {
  const SectionFelidLogin({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    // final authVM = Provider.of<AuthViewModel>(context);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        // Email
        DefaultTextFormField(
          hintText: 'Email Address',
          controller: cubit.emailController,
          prefixIconImageName: 'email',
          validator: Validators.validateEmail,
        ),
        const SizedBox(height: 16),
        // Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>  ForgotPasswordView(),
                ),
              );
            },
            child: Text(
              'Forgot?',
              style: textTheme.titleSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Password
        DefaultTextFormField(
          hintText: 'Password',
          controller: cubit.passwordController,
          prefixIconImageName: 'lock',
          validator: Validators.validatePassword,
          isPassword: true,

        ),
        const SizedBox(height: 24),
        // Login Button
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return DefaultElevatedButton(
              prefixSvgPath: 'assets/icons/login.svg',
              label: 'Login',
              backgroundColor: AppColors.primary,
              onPressed: () {
                context.read<AuthCubit>().login();
              },
            );
          },
        ),

         SizedBox(height: 24),

      ],
    );
  }
}

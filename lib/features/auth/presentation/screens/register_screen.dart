import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gangg_store/features/auth/presentation/screens/verifay_account_screen.dart';
import 'package:gangg_store/features/auth/presentation/widgets/CustomAppBar.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../../../../core/utils/default_text_form_field.dart';
import '../../../../core/utils/validator.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/Bottom_Registrer_screen.dart';
import '../widgets/header_Registrer_screen.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AppSnackBar.success(context, state.message);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => VerifyAccountView(
                email: cubit.emailController.text,
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
          child: Column(
            children: [
              const CustomAppBar(),
              const Gap(24),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: cubit.registerFormKey,
                      child: Column(
                        children: [
                          const HeaderRegisterScreen(),

                          DefaultTextFormField(
                            hintText: 'First Name',
                            controller: cubit.firstNameController,
                            prefixIconImageName: 'person',
                            validator: Validators.validateName,
                          ),

                          const SizedBox(height: 16),

                          DefaultTextFormField(
                            hintText: 'Last Name',
                            controller: cubit.lastNameController,
                            prefixIconImageName: 'person',
                            validator: Validators.validateName,
                          ),

                          const SizedBox(height: 16),

                          DefaultTextFormField(
                            hintText: 'Email Address',
                            controller: cubit.emailController,
                            prefixIconImageName: 'email',
                            validator: Validators.validateEmail,
                          ),

                          const SizedBox(height: 16),

                          DefaultTextFormField(
                            hintText: 'Password',
                            controller: cubit.passwordController,
                            prefixIconImageName: 'lock',
                            validator: Validators.validatePassword,
                            isPassword: true,
                          ),

                          const SizedBox(height: 24),

                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              final isLoading = state is AuthLoading;

                              return isLoading
                                  ? const CircularProgressIndicator()
                                  : DefaultElevatedButton(
                                label: 'Create Account',
                                onPressed: () {
                                  if (cubit.registerFormKey.currentState!
                                      .validate()) {
                                    cubit.register();
                                  }
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 16),
                          const BottomRegisterScreen(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
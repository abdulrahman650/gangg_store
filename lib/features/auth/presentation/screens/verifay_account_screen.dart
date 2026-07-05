import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gangg_store/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:gangg_store/features/auth/presentation/widgets/CustomAppBar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class VerifyAccountView extends StatefulWidget {
  final bool isFromForgotPassword;
  final String email;

  const VerifyAccountView({
    super.key,
    required this.email,
    this.isFromForgotPassword = false,
  });


  @override
  State<VerifyAccountView> createState() => _VerifyAccountViewState();
}

class _VerifyAccountViewState extends State<VerifyAccountView> {


  final List<TextEditingController> _controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {

        if (state is VerifyEmailSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );

          Navigator.popUntil(context, (route) => route.isFirst);
        }

        if (state is ValidateOtpSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ResetPasswordView(email: widget.email),
            ),
          );
        }

        if (state is ResendOtpSuccess) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );

        }

        if (state is AuthError) {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );

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
              const SizedBox(height: 70),
              // Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(25),
                ),
                child:

                CircleAvatar(
                  backgroundColor: AppColors.simony,
                  child: SvgPicture.asset('assets/icons/message.svg',
                  width: 40,
                    height: 40,

                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Verify Your Account
              Text(
                'Verify Your Account',
                style: textTheme.headlineSmall?.copyWith(
                  // color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the 4-digit code sent to your email.',
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.darkGray,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.black,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.simony,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              // Resend Code
              GestureDetector(
                onTap: () {
                  context.read<AuthCubit>().resendOtp(
                    email: widget.email,
                  );

                },
                child: Text(
                  'Resend Code',
                  style: textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Verify Button
              DefaultElevatedButton(
                prefixSvgPath: 'assets/icons/verifyIcon.svg',
                label: 'Verify',
                backgroundColor: AppColors.primary,
                onPressed: () {

                  final otp = _controllers.map((e) => e.text).join();

                  if (otp.length != 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter the 4-digit code"),
                      ),
                    );
                    return;
                  }

                  context.read<AuthCubit>().otpController.text = otp;

                  if (widget.isFromForgotPassword) {

                    context.read<AuthCubit>().validateOtp(
                      email: widget.email,
                    );

                  } else {

                    context.read<AuthCubit>().verifyEmail(
                      email: widget.email,
                    );

                  }
                },
              ),
              // DefaultElevatedButton(
              //   prefixSvgPath: 'assets/icons/verifyIcon.svg',
              //   label: 'Verify',
              //     backgroundColor: AppColors.primary,
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => const ResetPasswordView(),
              //       ),
              //     );
              //   }
              //   // {
              //   //   final code = _controllers.map((c) => c.text).join();
              //   //   if (code.length == 4) {
              //   //     if (widget.isFromForgotPassword) {
              //   //       Navigator.push(
              //   //         context,
              //   //         MaterialPageRoute(
              //   //           builder: (_) => const ResetPasswordView(),
              //   //         ),
              //   //       );
              //   //     } else {
              //   //       // TODO: Verify account creation
              //   //     }
              //   //   }
              //   // },
              // ),
              const SizedBox(height: 24),
              // Back to Login
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.arrow_back,
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
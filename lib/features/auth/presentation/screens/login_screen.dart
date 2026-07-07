import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/section_switch_theme.dart';
import '../../../layout/presentation/screens/layout_screen.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/Bottom_Login_screen.dart';
import '../widgets/Google_Button.dart';
import '../widgets/header_login_screen.dart';
import '../widgets/section_felid_login.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final text = Theme.of(context).textTheme;


    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        debugPrint(state.runtimeType.toString());
        if (state is LoginSuccess) {

          AppSnackBar.success(
            context,
            "Login Successfully",
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const Layout(),
            ),
          );
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
      // backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              //header Texts
              HeaderLoginScreen(),
              //email and password fields
              Form(
                key: context.read<AuthCubit>().loginFormKey,
                child: const SectionFelidLogin(),
              ),
              // OR CONTINUE WITH
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.darkGray)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: textTheme.titleSmall?.copyWith(
                        color: AppColors.darkGray,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.gray)),
                ],
              ),
              const SizedBox(height: 16),
              // Google Login Button
              GoogleButton(),
              //go to register screen & continue as guest
              BottomRegisterScreen(),
              Gap(180),
              SectionSwitchTheme(),
            ],
          ),
        ),
      ),
    ),
);
  }
}

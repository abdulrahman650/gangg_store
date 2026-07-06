import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/widgets/section_switch_theme.dart';
import 'package:gangg_store/features/profile/presentation/widgets/logout_batton.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../../../../core/utils/default_text_form_field.dart';
import '../../../../core/utils/validator.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../../../auth/presentation/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final fullNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passController = TextEditingController();

  bool _isDataLoaded = false;

  Widget svgIcon(
      String name, {
        double size = 22,
        Color? color,
      }) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: size,
      height: size,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
    );
  }

  Widget pngIcon(
      String name, {
        double size = 22,
      }) {
    return Image.asset(
      'assets/icons/$name.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
  @override
  void dispose() {
    fullNameController.dispose();
    emailAddressController.dispose();
    phoneNumberController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getProfile();
    });
  }
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {

        if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => LoginView(),
            ),
                (route) => false,
          );
        }

        if (state is LogoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }

        if (state is ProfileSuccess) {
          fullNameController.text = state.user.fullName;
          emailAddressController.text = state.user.email;
        }
      },
  builder: (context, state) {
    if (state is ProfileLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (state is ProfileError) {
      return Scaffold(
        body: Center(
          child: Text(state.message),
        ),
      );
    }

    final user = state is ProfileSuccess ? state.user : null;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 18),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xffF2B9A8),
                              width: 1.5,
                            ),
                          ),
                          child: ClipOval(
                            child: user?.profilePicture != null &&
                                user!.profilePicture!.isNotEmpty
                                ? Image.network(
                              user.profilePicture!,
                              fit: BoxFit.cover,
                            )
                                : Image.asset(
                              'assets/images/profile_man.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: -2,
                          bottom: 2,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: svgIcon(
                                'camera',
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      user?.fullName ?? '',
                      style: textTheme.headlineSmall?.copyWith(
                        // color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 34),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Appearance',
                       style:  textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ///switch theme
                    SectionSwitchTheme(),
                    const SizedBox(height: 26),
                    ///name
                    DefaultTextFormField(
                      borderColor: AppColors.primary,
                      hintText: 'Full Name',
                      controller: fullNameController,
                      prefixIconImageName: 'person',
                      validator: Validators.validateName,
                    ), const SizedBox(height: 18),
                    ///email
                    DefaultTextFormField(
                      hintText: 'Email Address',
                      borderColor: AppColors.primary,
                      controller: emailAddressController,
                      prefixIconImageName: 'email',
                      validator: Validators.validateName,
                    ),const SizedBox(height: 18),
                    ///phone
                    DefaultTextFormField(
                      hintText: 'Phone Number',
                      borderColor: AppColors.primary,
                      controller: phoneNumberController,
                      prefixIconImageName: 'phone',
                      validator: Validators.validateName,
                    ),const SizedBox(height: 18),
                    ///password
                    DefaultTextFormField(
                      hintText: 'Password',
                      controller: passController,
                      borderColor: AppColors.primary,
                      prefixIconImageName: 'lock',
                      validator: Validators.validateName,
                    ),const SizedBox(height: 18),
                    ///save change
                    DefaultElevatedButton(
                      label: 'Save Changes',
                      backgroundColor: AppColors.primary,
                      onPressed: () {
                      },
                    ),


                    const SizedBox(height: 16),
                    state is LogoutLoading
                        ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: CircularProgressIndicator(),
                    )
                        : const LogoutButton(),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 58,
                    //   child: OutlinedButton(
                    //     onPressed: () {},
                    //     style: OutlinedButton.styleFrom(
                    //       side: const BorderSide(
                    //         color: ProfileStyles.redLogout,
                    //         width: 1.5,
                    //       ),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(16),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         svgIcon(
                    //           'loguot',
                    //           size: 18,
                    //           color: ProfileStyles.redLogout,
                    //         ),
                    //         const SizedBox(width: 8),
                    //         Text(
                    //           'Logout',
                    //           style: ProfileStyles.logoutText(context),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);
  }
}
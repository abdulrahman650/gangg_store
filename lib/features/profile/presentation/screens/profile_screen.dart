import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/core/theme/app_colors.dart';
import 'package:gangg_store/core/widgets/section_switch_theme.dart';
import 'package:gangg_store/features/profile/presentation/widgets/logout_batton.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/services/cache_helper.dart';
import '../../../../core/services/cache_keys.dart';
import '../../../../core/utils/default_elevated_button.dart';
import '../../../../core/utils/default_text_form_field.dart';
import '../../../../core/utils/validator.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import 'change_password_screen.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  XFile? selectedImage;
final isLoading= false;


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
    final imagePath = CacheHelper.getData(CacheKeys.profileImage);

    if (imagePath != null) {
      selectedImage = XFile(imagePath);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getProfile();
    });
  }
  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile updated successfully"),
            ),
          );
        }

        if (state is UpdateProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }

        if (state is PickImageSuccess) {
          setState(() {
            selectedImage = state.image;
          });
        }

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
      body: Skeletonizer(
        enabled: isLoading,
        child: SafeArea(
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
                              child: selectedImage != null
                                  ? Image.file(
                                File(selectedImage!.path),
                                fit: BoxFit.cover,
                              )
                                  : user?.profilePicture != null &&
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
                            child: GestureDetector(
                              onTap: () {
                                context.read<ProfileCubit>().pickImage();
                              },
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/camera.svg',
                                    width: 15,
                                    color: Colors.white,
                                  ),
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
                      // DefaultTextFormField(
                      //   hintText: 'Phone Number',
                      //   borderColor: AppColors.primary,
                      //   controller: phoneNumberController,
                      //   prefixIconImageName: 'phone',
                      //   validator: Validators.validateName,
                      // ),const SizedBox(height: 18),
                      ///password
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: SvgPicture.asset(
                            'assets/icons/lock.svg',
                            width: 22,
                          ),
                          title: const Text('Change Password',style: TextStyle(color: AppColors.darkGray),),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChangePasswordView(),
                              ),
                            );
                          },
                        ),
                      ),
                      // DefaultTextFormField(
                      //   hintText: 'Password',
                      //   controller: passController,
                      //   borderColor: AppColors.primary,
                      //   prefixIconImageName: 'lock',
                      //   validator: Validators.validateName,
                      // ),const SizedBox(height: 18),
                      const SizedBox(height: 18),
                      ///save change
                      state is UpdateProfileLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : DefaultElevatedButton(
                        label: 'Save Changes',
                        backgroundColor: AppColors.primary,
                        onPressed: () {
                          context.read<ProfileCubit>().updateProfile(
                            fullName: fullNameController.text.trim(),
                            email: emailAddressController.text.trim(),
                          );
                        },
                      ),


                      const SizedBox(height: 16),
                      state is LogoutLoading
                          ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: CircularProgressIndicator(),
                      )
                          : const LogoutButton(),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
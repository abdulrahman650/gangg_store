import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'style.dart';
import 'widgets_field.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileStyles.pageBg,
      appBar: AppBar(
        backgroundColor: ProfileStyles.pageBg,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 58,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: GestureDetector(
            onTap: () {},
            child: Center(
              child: svgIcon(
                'arrowBack',
                size: 22
              ),
            ),
          ),
        ),
        title: Text(
          'Gang Store',
          style: ProfileStyles.appTitle(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: svgIcon(
                  'bag',
                  size: 24,
                  color: ProfileStyles.brown,
                ),
              ),
            ),
          ),
        ],
      ),
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
                            child: Image.asset(
                              'assets/images/profile_man.png',
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
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
                              color: ProfileStyles.brown,
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
                      'Julian Thorne',
                      style: ProfileStyles.name(context),
                    ),
                    const SizedBox(height: 34),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Appearance',
                        style: ProfileStyles.label(context),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 58,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ProfileStyles.lightBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          pngIcon(
                            'mode',
                            size: 22,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Dark Mode',
                              style: ProfileStyles.fieldText(context),
                            ),
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: Switch(
                              value: true,
                              onChanged: (value) {},
                              activeColor: Colors.white,
                              activeTrackColor: ProfileStyles.brown,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: ProfileStyles.lightBorder,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    ProfileField(
                      label: 'Full Name',
                      icon: svgIcon(
                        'person',
                        size: 22,
                        color: ProfileStyles.brown,
                      ),
                      text: 'Julian Thorne',
                    ),
                    const SizedBox(height: 18),
                    ProfileField(
                      label: 'Email Address',
                      icon: svgIcon(
                        'email',
                        size: 22,
                        color: ProfileStyles.brown,
                      ),
                      text: 'julian.thorne@luxedetail.com',
                    ),
                    const SizedBox(height: 18),
                    ProfileField(
                      label: 'Phone Number',
                      icon: svgIcon(
                        'phone',
                        size: 22,
                        color: ProfileStyles.brown,
                      ),
                      text: '+1 (555) 012-3456',
                    ),
                    const SizedBox(height: 18),
                    ProfileField(
                      label: 'Password',
                      icon: svgIcon(
                        'lock',
                        size: 22,
                        color: ProfileStyles.brown,
                      ),
                      text: 'password123',
                      suffixIcon: svgIcon(
                        'eye',
                        size: 22,
                        color: ProfileStyles.brown,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProfileStyles.brown,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Save Changes',
                          style: ProfileStyles.buttonText(context),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: ProfileStyles.redLogout,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            svgIcon(
                              'loguot',
                              size: 18,
                              color: ProfileStyles.redLogout,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Logout',
                              style: ProfileStyles.logoutText(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: ProfileStyles.pageBg,
                border: Border(
                  top: BorderSide(
                    color: ProfileStyles.lightBorder,
                    width: 0.7,
                  ),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: 3,
                type: BottomNavigationBarType.fixed,
                backgroundColor: ProfileStyles.pageBg,
                elevation: 0,
                selectedItemColor: ProfileStyles.brown,
                unselectedItemColor: ProfileStyles.brown,
                selectedLabelStyle: ProfileStyles.navText(context),
                unselectedLabelStyle: ProfileStyles.navText(context),
                items: [
                  BottomNavigationBarItem(
                    icon: svgIcon(
                      'Home',
                      size: 22,
                      color: ProfileStyles.brown,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon(
                      'category',
                      size: 22,
                      color: ProfileStyles.brown,
                    ),
                    label: 'Category',
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon(
                      'love',
                      size: 22,
                      color: ProfileStyles.brown,
                    ),
                    label: 'Wishlist',
                  ),
                  BottomNavigationBarItem(
                    icon: svgIcon(
                      'profile',
                      size: 22,
                      color: ProfileStyles.brown,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
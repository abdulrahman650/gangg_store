
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gangg_store/features/search/presentation/screens/search_screen.dart';
import '../../../../core/services/service_locators.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../core/utils/guest_guard.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../category/presentation/screens/category_screen.dart';
import '../../../favourites/presentation/screens/wishlist_tab.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../search/presentation/cubit/search_cubit.dart';


class Layout extends StatefulWidget {
  const Layout({super.key});

  static _LayoutState? of(BuildContext context) {
    return context.findAncestorStateOfType<_LayoutState>();
  }
  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with TickerProviderStateMixin {
  late PageController controller;
  late List<AnimationController> iconControllers;
  late List<Widget> screen;
  int currentScreen = 0;

  @override
  void initState() {
    super.initState();
    screen = [HomeScreen(), CategoryScreen(), WishlistScreen(), ProfileScreen()];
    controller = PageController(initialPage: 0);
  }

  void changeTab(int index) {
    setState(() {
      currentScreen = index;
    });

    controller.jumpToPage(index);
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PopScope(
        canPop: false,
        child: Scaffold(
          body: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentScreen = index;
              });
            },
            children: screen,
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
               color:   context.isDark
                   ?  Theme.of(context).scaffoldBackgroundColor : AppColors.backgroundWhite ,
              // color: AppColors.backgroundWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.11),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.darkGray,
              currentIndex: currentScreen,
              onTap: (index) {
                if (index == 0) {
                  setState(() {
                    currentScreen = index;
                  });

                  controller.jumpToPage(index);
                  return;
                }

                GuestGuard.run(
                  context,
                  onAuthenticated: () {
                    setState(() {
                      currentScreen = index;
                    });

                    controller.jumpToPage(index);
                  },
                );
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home, size: 20),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.square_grid_2x2, size: 20),
                  label: "Category",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border,size: 20),
                  label: "Favorite",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled, size: 20),
                  label: "Profile",
                ),
              ],
            ),
          ),

            appBar: AppBar(
              backgroundColor:  context.isDark
                ?  Theme.of(context).scaffoldBackgroundColor : AppColors.backgroundWhite ,
              elevation: 0,
              leading: currentScreen == 0
                  ? null
                  : IconButton(
                icon: const Icon(Icons.arrow_back),
                color: AppColors.primary,
                  onPressed: () {
                    controller.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
              ),
              title: Text(
                'Gang Store',
                style: textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  color: AppColors.primary,
                  onPressed: () {
                    GuestGuard.run(
                      context,
                      onAuthenticated: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => getIt<SearchCubit>(),
                              child: const SearchScreen(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.card_travel),
                  color: AppColors.primary,
                  onPressed: () {
                    GuestGuard.run(
                      context,
                      onAuthenticated: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CartScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            )
        )
    );
  }
}



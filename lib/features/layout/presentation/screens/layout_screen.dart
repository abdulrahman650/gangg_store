
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gangg_store/features/search/presentation/search_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../../category/presentation/screens/category_screen.dart';
import '../../../category/presentation/screens/category_tab.dart';
import '../../../favourites/presentation/screens/wishlist_tab.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../home/presentation/screens/home_tab.dart';
import '../../../profile/presentation/screens/profile_screen.dart';


class Layout extends StatefulWidget {
  const Layout({super.key});

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
    screen = [HomeScreen(), CategoryScreen(), WishListTab(), ProfileScreen()];
    controller = PageController(initialPage: 0);
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
                setState(() {
                  currentScreen = index;
                });
                controller.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home, size: 20),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.cart, size: 20),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border, size: 20),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SearchScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.card_travel),
                  color: AppColors.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CartScreen(),
                      ),
                    );
                  },
                ),
              ],
              //   currentScreen == 0
              //       ? "Home"
              //       : currentScreen == 1
              //           ? "Category"
              //           : currentScreen == 2
              //               ? "Wishlist"
              //               : "Profile",
              //   style: const TextStyle(
              //     color: AppColors.primary,
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // centerTitle: true,
            )
        )
    );
  }
}



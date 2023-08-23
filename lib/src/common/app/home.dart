import 'dart:ui';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:iconly/iconly.dart';

import '../../features/feeds/presentation/screens/feeds.dart';
import '../../features/profile/presentation/screens/profile.dart';
import '../../features/search_users/presentation/screens/search.dart';
import '../../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.selectedIndex});
  final int selectedIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  List<Widget> selectedScreens = [
    const FeedsScreen(),
    const SearchScreen(),
    const Center(),
    const UserProfileScreen(isOwnProfile: true),
    const UserProfileScreen(isOwnProfile: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Pellet.kBackgroundGradient,
      ),
      child: ColorfulSafeArea(
        color: Colors.transparent,
        top: selectedIndex == 0 ? true : false,
        bottom: false,
        child: Scaffold(
          extendBody: true,
          body: selectedScreens[selectedIndex],
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      IconlyLight.home,
                    ),
                    activeIcon: GlowIcon(
                      IconlyBold.home,
                      glowColor: Pellet.kWhite,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyLight.search),
                    activeIcon: GlowIcon(
                      IconlyBold.search,
                      glowColor: Pellet.kWhite,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      child: Icon(
                        Icons.add,
                        color: Pellet.kWhite,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Pellet.kSecondary,
                      ),
                    ),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyLight.notification),
                    activeIcon: GlowIcon(
                      IconlyBold.notification,
                      glowColor: Pellet.kWhite,
                    ),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyLight.profile),
                    activeIcon: GlowIcon(
                      IconlyBold.profile,
                      glowColor: Pellet.kWhite,
                    ),
                    label: 'Profile',
                  ),
                ],
                selectedItemColor: Pellet.kWhite,
                unselectedItemColor: Pellet.kGrey,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                backgroundColor:
                    Pellet.kBackgroundGradient.colors[1].withOpacity(0.5),
                elevation: 0,
                currentIndex: selectedIndex,
                onTap: (index) {
                  if (index == 2) {
                    Navigator.pushNamed(context, '/create-post');
                  } else {
                    setState(() {
                      selectedIndex = index;
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import '../../features/feeds/presentation/screens/feeds.dart';
import '../../features/profile/presentation/screens/profile.dart';
import '../../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> selectedScreens = [
    const FeedsScreen(),
    const UserProfileScreen(isOwnProfile: false),
    const SizedBox(),
    const UserProfileScreen(isOwnProfile: true),
    const UserProfileScreen(isOwnProfile: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Pellete.kBackgroundGradient,
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
                      glowColor: Pellete.kWhite,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyLight.search),
                    activeIcon: GlowIcon(
                      IconlyBold.search,
                      glowColor: Pellete.kWhite,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      child: Icon(
                        Icons.add,
                        color: Pellete.kWhite,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Pellete.kSecondary,
                      ),
                    ),
                    label: 'Add',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyLight.notification),
                    activeIcon: GlowIcon(
                      IconlyBold.notification,
                      glowColor: Pellete.kWhite,
                    ),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(IconlyLight.profile),
                    activeIcon: GlowIcon(
                      IconlyBold.profile,
                      glowColor: Pellete.kWhite,
                    ),
                    label: 'Profile',
                  ),
                ],
                selectedItemColor: Pellete.kWhite,
                unselectedItemColor: Pellete.kGrey,
                type: BottomNavigationBarType.fixed,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                backgroundColor:
                    Pellete.kBackgroundGradient.colors[1].withOpacity(0.5),
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

import 'dart:ui';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:connectopia/src/features/notifications/presentation/screens/notifications.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:connectopia/src/features/profile/presentation/screens/personal_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:iconly/iconly.dart';

import '../../features/feeds/presentation/screens/feeds.dart';
import '../../features/search_users/presentation/screens/search.dart';
import '../../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.selectedIndex,
    required this.user,
    this.posts,
  });
  final int selectedIndex;
  final User user;
  final List<Post>? posts;

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

  @override
  Widget build(BuildContext context) {
    List<Widget> selectedScreens = [
      FeedsScreen(
        user: widget.user,
        posts: widget.posts!,
      ),
      SearchScreen(
        userId: widget.user.id,
      ),
      const Center(
        child: Text('Add'),
      ),
      const NotificationView(),
      PersonalProfileScreen(),
    ];
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
                    Navigator.pushNamed(
                      context,
                      '/create-post',
                      arguments: {
                        'username': widget.user.username,
                      },
                    );
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

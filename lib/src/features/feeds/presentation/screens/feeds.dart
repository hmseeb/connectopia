import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  late final _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return PageView(
      controller: _pageController,
      children: [
        SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Good Mornin',
                      style: TextStyle(
                        fontSize: _width * ScreenSize.kSpaceXL,
                        fontWeight: FontWeight.bold,
                        color: Pellet.kWhite,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Icon(
                        IconlyLight.chat,
                        color: Pellet.kWhite,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _height * 3,
              ),
              // TODO: Add Single Post List View

              // To avoid the unreadable last post
              SizedBox(
                height: _height * 10,
              ),
            ],
          ),
        ),
        Center(
          child: Text(
            'Chat',
            style: TextStyle(
              fontSize: _width * ScreenSize.kSpaceXL,
              fontWeight: FontWeight.bold,
              color: Pellet.kWhite,
            ),
          ),
        ),
      ],
    );
  }
}

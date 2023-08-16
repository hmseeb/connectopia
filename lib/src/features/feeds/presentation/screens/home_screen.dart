import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Container(
      decoration: BoxDecoration(
        gradient: Pellete.kBackgroundGradient,
      ),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(_height * ScreenSize.kSpaceL),
          child: Column(
            children: [
              SizedBox(height: _height * ScreenSize.kSpaceXL),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Good Morning, Siri',
                    style: TextStyle(
                      fontSize: _width * ScreenSize.kSpaceXL,
                      fontWeight: FontWeight.bold,
                      color: Pellete.kWhite,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      Assets.getRandomAvatar(),
                      height: _height * ScreenSize.kSpaceXL,
                      width: _height * ScreenSize.kSpaceXL,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

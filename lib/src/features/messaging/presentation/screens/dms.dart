import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class DmsView extends StatelessWidget {
  const DmsView({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  fontSize: _width * ScreenSize.kSpaceXL,
                  fontWeight: FontWeight.bold,
                  color: Pellet.kWhite,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  IconlyLight.add_user,
                  color: Pellet.kWhite,
                ),
              )
            ],
          ),
          SizedBox(height: _height * 2),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: _height * 5,
            decoration: BoxDecoration(
                color: Pellet.kDark, borderRadius: BorderRadius.circular(32)),
            child: TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Search for a person or message',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../views/single_post.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Good Morning, Haseeb',
                  style: TextStyle(
                    fontSize: _width * ScreenSize.kSpaceXL,
                    fontWeight: FontWeight.bold,
                    color: Pellete.kWhite,
                  ),
                ),
                Icon(
                  IconlyLight.chat,
                  color: Pellete.kWhite,
                )
              ],
            ),
          ),
          SizedBox(
            height: _height * 3,
          ),
          SinglePostTemplate(
            username: 'Haseeb Azhar',
            location: 'New York',
            time: '2h',
            caption: 'Watchu doin\' son?',
            totalLikes: 99,
            totalComments: 23,
            totalShares: 10,
          ),
          SinglePostTemplate(
            username: 'Yahya Khan',
            location: 'Pakistan',
            time: '2h',
            caption:
                'Sunt amet dolore voluptate exercitation ipsum duis irure nisi elit. Cupidatat irure minim est et pariatur sunt sunt dolor aute reprehenderit commodo adipisicing nulla laboris. Aliquip eu adipisicing minim nisi aliquip officia exercitation enim minim pariatur sunt fugiat consequat ad. Irure proident cupidatat culpa anim aute incididunt minim officia quis sunt nostrud ipsum pariatur. Cupidatat in nulla cillum reprehenderit.',
            images: [
              Assets.randomImage,
              Assets.randomImage,
              Assets.randomImage,
            ],
            totalLikes: 99,
            totalComments: 23,
            totalShares: 10,
          ),
          SinglePostTemplate(
            username: 'John Doe',
            location: 'New York',
            time: '2h',
            caption:
                'Anim nisi tempor do nostrud eiusmod. Lorem occaecat nostrud ea elit irure commodo ad ipsum mollit. Magna deserunt quis elit amet eiusmod velit ut officia magna. Labore proident eiusmod tempor commodo nulla irure aliqua id cupidatat.',
            totalLikes: 99,
            totalComments: 23,
            totalShares: 10,
          ),
          SinglePostTemplate(
            username: 'John Smith',
            location: 'Dubai',
            time: '2h',
            images: [
              Assets.randomImage,
            ],
            totalLikes: 99,
            totalComments: 23,
            totalShares: 10,
          ),
        ],
      ),
    );
  }
}

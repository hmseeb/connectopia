import 'package:connectopia/src/features/feeds/data/feeds_repo.dart';
import 'package:connectopia/src/features/feeds/presentation/views/single_post.dart';
import 'package:connectopia/src/features/messaging/presentation/screens/chats.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key, required this.user, required this.posts});
  final User user;
  final List<Post> posts;

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
              SizedBox(height: _height * 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${FeedsRepo.getGreeting()}, ${widget.user.name.isEmpty ? widget.user.username : widget.user.name}',
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
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Badge(
                        child: Icon(IconlyLight.chat),
                        isLabelVisible: true,
                        backgroundColor: Colors.red,
                        textColor: Pellet.kWhite,
                        label: Text('1'),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: _height * 2),
              widget.posts.isNotEmpty
                  ? SizedBox(
                      height: _height * 90,
                      child: ListView.builder(
                        itemCount: widget.posts.length,
                        itemBuilder: (context, index) {
                          return SinglePostTemplate(
                            post: widget.posts[index],
                            isOwnPost: false,
                            posts: widget.posts,
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      height: _height * 70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HintColumn(
                            text: 'Your feed is empty',
                            icon: FontAwesomeIcons.globe,
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Follow people to see their posts',
                          ),
                        ],
                      ),
                    )
            ],
          ),
        ),
        DmsView(),
      ],
    );
  }
}

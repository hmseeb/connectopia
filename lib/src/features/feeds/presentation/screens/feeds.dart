import 'package:connectopia/src/features/feeds/data/feeds_repo.dart';
import 'package:connectopia/src/features/feeds/presentation/views/single_post.dart';
import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:flutter/material.dart';
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
              SizedBox(height: _height * 2),
              SizedBox(
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

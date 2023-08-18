import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:iconly/iconly.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, required this.isOwnProfile});
  final bool isOwnProfile;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController;
  late final _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.isOwnProfile ? 4 : 2, vsync: this);
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset > 100) {
          if (!_isScrolled) {
            setState(() {
              _isScrolled = true;
            });
          }
        } else {
          if (_isScrolled) {
            setState(() {
              _isScrolled = false;
            });
          }
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              AspectRatio(
                aspectRatio: 2,
                child: FullScreenWidget(
                  disposeLevel: DisposeLevel.High,
                  child: Image.network(
                    Assets.randomImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: _height * -5,
                left: _width * 38,
                child: SizedBox(
                  height: _height * 10,
                  width: _height * 10,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: FullScreenWidget(
                      disposeLevel: DisposeLevel.High,
                      child: Image.asset(
                        Assets.getRandomAvatar(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.isOwnProfile)
                Positioned(
                  bottom: _height * -5,
                  left: _width * 53,
                  child: SizedBox(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Pellete.kBlack.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        IconlyBold.camera,
                        color: Pellete.kWhite,
                        size: 16,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: _height * 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Haseeb',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add logic if email account is verified add this badge
                  SizedBox(width: _width * 2),
                  Icon(Icons.verified, color: Colors.blue),
                ],
              ),
              SizedBox(height: _height * 2),
              Text(
                'Mollit quis incididunt ex cillum aute cillum duis velit consectetur irure. Minim anim minim mollit dolor qui qui fugiat amet.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: _height * 2),
              widget.isOwnProfile
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _width * 10,
                            vertical: _height * 1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1, color: Pellete.kWhite),
                          ),
                          child: Text('Edit Profile',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: _width * 2),
                        // share profile icon
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _width * 10,
                            vertical: _height * 1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1, color: Pellete.kWhite),
                          ),
                          child: Text('Share Profile',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _width * 10,
                            vertical: _height * 1,
                          ),
                          decoration: BoxDecoration(
                            gradient: Pellete.kFlashBackgroundGradient,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text('Message',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: _width * 2),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _width * 10,
                            vertical: _height * 1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 1, color: Pellete.kWhite),
                          ),
                          child: Text('Following',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(width: _width * 2),
                        Icon(Icons.more_vert_outlined),
                      ],
                    ),
              SizedBox(height: _height * 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '1.5k',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Followers'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '1.5k',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Following'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '1.5k',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Likes'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SliverAppBar(
          backgroundColor: _isScrolled ? Color(0xff221128) : Colors.transparent,
          elevation: 1,
          toolbarHeight: 0,
          floating: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(_height * 6),
            child: Container(
              child: TabBar(
                  controller: _tabController,
                  indicatorColor: Pellete.kWhite,
                  labelColor: Pellete.kWhite,
                  unselectedLabelColor: Pellete.kWhite.withOpacity(0.5),
                  tabs: [
                    Tab(
                      icon: Icon(Icons.grid_on),
                    ),
                    if (widget.isOwnProfile)
                      Tab(
                        icon: Icon(Icons.favorite_border_outlined),
                      ),
                    Tab(
                      icon: Icon(Icons.person_pin_outlined),
                    ),
                    if (widget.isOwnProfile)
                      Tab(
                        icon: Icon(Icons.bookmark_border_outlined),
                      ),
                  ]),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: AutoScaleTabBarView(
            children: [
              GridPostView(),
              GridPostView(),
              if (widget.isOwnProfile) GridPostView(),
              if (widget.isOwnProfile) GridPostView(),
            ],
            controller: _tabController,
          ),
        ),
      ],
    );
  }
}

class GridPostView extends StatelessWidget {
  const GridPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 40,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemBuilder: (context, index) {
        return FullScreenWidget(
          disposeLevel: DisposeLevel.High,
          child: Image.network(
            Assets.randomImage,
            fit: BoxFit.contain,
          ),
        );
      },
    );
  }
}

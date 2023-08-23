import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/page_title.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/search_prople_list.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../constants/sizing.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: _height * 5),
            SearchTextField(),
            SizedBox(height: _height * 2),
            PageHeading('Search'),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(
                  text: 'Trending',
                ),
                Tab(
                  text: 'People',
                ),
                Tab(
                  text: 'Media',
                ),
              ],
            ),
            AutoScaleTabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: Center(
                    child: Text('Trending'),
                  ),
                ),
                SizedBox(
                  height: _height * 69,
                  child: PeopleSearchListView(),
                ),
                Container(
                  child: Center(
                    child: Text('Media'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

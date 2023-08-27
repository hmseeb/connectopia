import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:connectopia/src/features/search_users/presentation/views/search_media_grid.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/sizing.dart';
import '../views/search_people_list.dart';
import '../widgets/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.userId});
  final String userId;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController;
  late final _searchController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: _height * 5),
                SearchTextField(
                  onChanged: (value) {
                    context.read<SearchBloc>().add(SearchUsersEvent(value));
                  },
                  controller: _searchController,
                ),
                SizedBox(height: _height * 2),
                TabBar(
                  indicatorColor: Pellet.kWhite,
                  labelColor: Pellet.kWhite,
                  unselectedLabelColor: Pellet.kWhite.withOpacity(0.5),
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'People'),
                    Tab(text: 'Media'),
                  ],
                ),
                AutoScaleTabBarView(
                  controller: _tabController,
                  children: [
                    SizedBox(
                      height: _height * 69,
                      child: PeopleSearchListView(),
                    ),
                    SizedBox(
                      height: _height * 69,
                      child: MediaGridView(
                        userId: widget.userId,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

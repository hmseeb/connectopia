import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class PeopleSearchListView extends StatelessWidget {
  const PeopleSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchLoadedState) {}
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is SearchLoading,
          containersColor: Pellet.kDark,
          child: context.read<SearchBloc>().hasFoundUsers
              ? ListView.builder(
                  itemCount:
                      state is SearchLoadedState ? state.users.length : 10,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: Pellet.kDark,
                        backgroundImage: state is SearchLoadedState &&
                                state.users[index].avatar.isNotEmpty
                            ? MemoryImage(ProfileRepo.decodeBase64(
                                state.users[index].avatar))
                            : Image.asset(Assets.avatarPlaceholder).image,
                      ),
                      title: Text(state is SearchLoadedState
                          ? state.users[index].name.isEmpty
                              ? state.users[index].username
                              : state.users[index].name
                          : 'User Name'),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/profile');
                        },
                        child: Container(
                          width: _width * 25,
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: index % 2 == 0
                                ? Pellet.kSecondary
                                : Pellet.kDark.withOpacity(0.5),
                          ),
                          child: Text(index % 2 == 0 ? 'Add' : 'Remove',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    );
                  },
                )
              : state is SearchInitial
                  ? HintColumn(
                      text: 'Search for people',
                      icon: IconlyLight.user_1,
                    )
                  : HintColumn(
                      text: 'No people found',
                      icon: FontAwesomeIcons.solidFaceMeh,
                    ),
        );
      },
    );
  }
}

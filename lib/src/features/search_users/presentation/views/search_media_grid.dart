import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectopia/src/features/profile/presentation/widgets/fake_grid_view.dart';
import 'package:connectopia/src/features/search_users/application/bloc/search_bloc.dart';
import 'package:connectopia/src/features/search_users/presentation/widgets/hint_col.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MediaGridView extends StatelessWidget {
  const MediaGridView({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Skeletonizer(
            enabled: state is SearchLoading,
            child: context.read<SearchBloc>().hasFoundMedia
                ? GridView.builder(
                    itemCount:
                        state is SearchLoadedState ? state.media.length : 20,
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/single-post',
                            arguments: {
                              'posts': state is SearchLoadedState
                                  ? state.media
                                  : null,
                              'post': state is SearchLoadedState
                                  ? state.media[index]
                                  : null,
                              'isOwnPost': state is SearchLoadedState
                                  ? state.media[index].expand.user.id == userId
                                  : null,
                            },
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(),
                            child: state is SearchLoadedState &&
                                    state.media[index].image.isEmpty
                                ? DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: Pellet.kDark,
                                    ),
                                    child: Center(
                                      child: Text(
                                        state.media[index].caption,
                                        style: TextStyle(
                                          color: Pellet.kWhite,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                  )
                                : state is SearchLoadedState
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            '${dotenv.env['POCKETBASE_URL']}/api/files/${state.media[index].collectionId}/${state.media[index].id}/${state.media[index].image[0]}/',
                                        fit: BoxFit.cover,
                                      )
                                    : SizedBox()),
                      );
                    })
                : state is SearchLoading
                    ? FakeGridView()
                    : state is SearchInitial
                        ? HintColumn(
                            text: 'Search for Media',
                            icon: IconlyLight.image_2,
                          )
                        : HintColumn(
                            text: 'No media found',
                            icon: FontAwesomeIcons.faceMehBlank,
                          ));
      },
    );
  }
}

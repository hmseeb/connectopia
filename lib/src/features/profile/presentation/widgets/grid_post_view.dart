import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../domain/models/post.dart';

class GridPostView extends StatelessWidget {
  const GridPostView({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: posts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
          ),
          itemBuilder: (context, index) {
            if (posts[index].image.isEmpty)
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/single-post',
                    arguments: {
                      'post': posts[index],
                    },
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(child: Text(posts[index].caption)),
                ),
              );
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/single-post',
                      arguments: {
                        'post': posts[index],
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            '${dotenv.env['BASE_IMAGE_URL']}/${posts[index].collectionId}/${posts[index].id}/${posts[index].image[0]}/'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                if (posts[index].image.length > 1)
                  Positioned(
                      top: 10,
                      right: 10,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 3,
                            left: 3,
                            child: Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                )),
                          ),
                          Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
              ],
            );
          },
        ),
      ],
    );
  }
}

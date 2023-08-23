import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../feeds/presentation/views/single_post.dart';
import '../../domain/models/post.dart';

class SinglePostView extends StatelessWidget {
  const SinglePostView({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: Pellete.kBackgroundGradient,
      ),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: SinglePostTemplate(
            post: post,
          ),
        ),
      ),
    );
  }
}

import '../../../../constants/assets.dart';
import 'package:flutter/material.dart';

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
        ;
        return Image.network(
          Assets.randomImage,
          fit: BoxFit.contain,
        );
      },
    );
  }
}

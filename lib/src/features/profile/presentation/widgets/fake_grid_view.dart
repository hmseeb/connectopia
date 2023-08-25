import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class FakeGridView extends StatelessWidget {
  const FakeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Pellet.kDark,
          ),
        );
      },
    );
  }
}

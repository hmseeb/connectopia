import 'dart:math';

import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/notifications/presentation/widgets/day_seperator.dart';
import 'package:flutter/material.dart';

class NotificationsListView extends StatelessWidget {
  const NotificationsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return SizedBox(
        height: _height * 75,
        child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: 20,
            itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      Assets.avatarPlaceholder,
                    ),
                  ),
                  title: Text('Haseeb liked your post'),
                  subtitle: Text('20 min ago'),
                  trailing: SizedBox(
                    child: Image.asset(
                      Assets.bannerPlaceholder,
                    ),
                    width: 70,
                  ),
                ),
            separatorBuilder: (context, index) {
              return index % 5 == 0
                  ? DaySeparator(
                      day: 'yesterday',
                      notificationsCount: Random().nextInt(30),
                    )
                  : SizedBox();
            }));
  }
}

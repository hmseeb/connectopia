import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/notifications/presentation/widgets/day_seperator.dart';
import 'package:connectopia/src/features/notifications/views/notifications_list.dart';
import 'package:connectopia/src/features/notifications/views/page_title.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: _height * 6),
          PageTitleView(),
          SizedBox(height: _height * 2),
          DaySeparator(
            day: 'today',
            notificationsCount: 21,
          ),
          NotificationsListView(),
        ],
      ),
    );
  }
}

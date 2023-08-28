import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

class DaySeparator extends StatelessWidget {
  const DaySeparator({
    super.key,
    required this.day,
    required this.notificationsCount,
  });
  final String day;
  final int notificationsCount;

  @override
  Widget build(BuildContext context) {
    String formattedDay = formatDay(day);
    final _width = ScreenSize.width(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formattedDay,
            style: TextStyle(
              fontSize: _width * ScreenSize.kSpaceXL,
              fontWeight: FontWeight.bold,
              color: Pellet.kGrey,
            ),
          ),
          Text(
            notificationsCount.toString(),
            style: TextStyle(
              fontSize: _width * ScreenSize.kSpaceXL,
              fontWeight: FontWeight.bold,
              color: Pellet.kGrey,
            ),
          ),
        ],
      ),
    );
  }

  String formatDay(String day) {
    String mappedDay = day.characters.map((c) => c.toUpperCase()).toString();
    String removeCommas = (mappedDay.replaceAll(',', ''));
    String removeLeftBracket = removeCommas.replaceAll('(', '');
    String removeRightBracket = removeLeftBracket.replaceAll(')', '');
    return removeRightBracket;
  }
}

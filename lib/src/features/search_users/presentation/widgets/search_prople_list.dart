import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';

class PeopleSearchListView extends StatelessWidget {
  const PeopleSearchListView({super.key});

  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return ListView.builder(
      itemCount: 22,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.red,
          ),
          title: Text('Person $index'),
          trailing: GestureDetector(
            onTap: () {},
            child: Container(
              width: _width * 25,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: index % 2 == 0
                    ? Pellete.kSecondary
                    : Pellete.kDark.withOpacity(0.5),
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
    );
  }
}

import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';

class SignoutButton extends StatelessWidget {
  const SignoutButton({
    super.key,
    required this.username,
    required this.onTap,
  });

  final String username;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Pellet.kDark,
      ),
      child: ListTile(
        leading: Icon(
          Icons.logout,
          color: Colors.red,
        ),
        title: Text('Sign Out', style: TextStyle(color: Colors.red)),
        onTap: onTap,
        trailing: Text(
          username,
          style: TextStyle(color: Pellet.kGrey),
        ),
      ),
    );
  }
}

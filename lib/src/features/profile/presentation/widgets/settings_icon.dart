import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({
    super.key,
    required this.name,
    required this.username,
  });
  final String name, username;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/account-settings', arguments: {
            "username": name.isEmpty ? username : name,
          });
        },
        icon: Icon(
          IconlyLight.setting,
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class SettingsIconButton extends StatelessWidget {
  const SettingsIconButton({
    super.key,
    required this.name,
    required this.username,
    required this.emailVisibility,
  });
  final String name, username;
  final bool emailVisibility;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/account-settings', arguments: {
            "username": name.isEmpty ? username : name,
            "emailVisibility": emailVisibility,
          });
        },
        icon: Icon(
          IconlyLight.setting,
        ));
  }
}

import 'package:connectopia/src/common/messages/error_snakbar.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/profile/application/profile_settings/profile_settings_bloc.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return BlocConsumer<AccountSettings, AccountSettingssState>(
      listener: (context, state) {
        if (state is SignoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnack(state.error),
          );
        } else if (state is SignoutSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/signin',
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: Pellete.kBackgroundGradient,
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: Text('SETTINGS'),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Pellete.kDark,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                          title: Text('Sign Out',
                              style: TextStyle(color: Colors.red)),
                          onTap: () {
                            context
                                .read<AccountSettings>()
                                .add(const SignOutButtonPressedEvent());
                          },
                          trailing: Text(
                            username,
                            style: TextStyle(color: Pellete.kGrey),
                          ),
                        ),
                      ),
                      SizedBox(height: _height * 5),
                    ],
                  ),
                ),
              ),
            ),
            if (state is AccountSettingsLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}

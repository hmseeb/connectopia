import '../../../../common/messages/error_snackbar.dart';
import '../../../../constants/sizing.dart';
import '../../application/profile_settings/profile_settings_bloc.dart';
import '../widgets/signout_button.dart';
import '../../../../theme/colors.dart';
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
                gradient: Pellet.kBackgroundGradient,
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
                      SignoutButton(
                        username: username,
                        onTap: () {
                          context
                              .read<AccountSettings>()
                              .add(const SignOutButtonPressedEvent());
                        },
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

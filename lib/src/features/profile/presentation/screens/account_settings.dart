import 'package:connectopia/src/constants/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/messages/error_snackbar.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../../application/profile_settings/profile_settings_bloc.dart';
import '../widgets/signout_button.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage(
      {super.key, required this.username, required this.emailVisibility});
  final String username;
  final bool emailVisibility;

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  late bool emailVisibility;
  @override
  void initState() {
    super.initState();
    emailVisibility = widget.emailVisibility;
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return BlocConsumer<AccountSettings, AccountSettingsState>(
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
        } else if (state is TogglePrivacySuccess) {
          emailVisibility = state.togglePrivacy;
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Pellet.kDark,
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Pellet.kWhite,
                          ),
                          enableFeedback: false,
                          title: Text('Account Privacy'),
                          onTap: () {
                            context.read<AccountSettings>().add(
                                  ToggleAccountPrivacyEvent(
                                    emailVisibility,
                                  ),
                                );
                          },
                          trailing: state is TogglePrivacyLoading
                              ? Lottie.asset(Assets.progressIndicator)
                              : state is TogglePrivacySuccess
                                  ? state.togglePrivacy
                                      ? AccountPrivacyBlueText('Public')
                                      : AccountPrivacyBlueText('Private')
                                  : emailVisibility
                                      ? AccountPrivacyBlueText('Public')
                                      : AccountPrivacyBlueText('Private'),
                        ),
                      ),
                      Spacer(),
                      SignoutButton(
                        username: widget.username,
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

class AccountPrivacyBlueText extends StatelessWidget {
  const AccountPrivacyBlueText(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Pellet.kBlue,
      ),
    );
  }
}

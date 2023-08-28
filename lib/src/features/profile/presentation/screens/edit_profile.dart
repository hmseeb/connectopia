import 'package:connectopia/src/features/profile/application/personal_profile_bloc/personal_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/messages/error_snackbar.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';
import '../../../authentication/presentation/widgets/field_title.dart';
import '../../application/edit_profile_bloc/edit_profile_bloc.dart';
import '../../domain/models/user.dart';
import '../widgets/edit_text_field.dart';
import '../widgets/profile_banner.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});

  final User user;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late User user = widget.user;
  XFile? avatar, banner;
  late TextEditingController _usernameController;
  late TextEditingController _displayNameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: user.username,
    );
    _displayNameController = TextEditingController(
      text: user.name,
    );
    _bioController = TextEditingController(
      text: user.bio,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _displayNameController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is AvatarUpdateSuccess) {
          context.read<ProfileBloc>().add(LoadPersonalProfile());
          Navigator.pop(context);
        } else if (state is BannerUpdateSuccess) {
          context.read<ProfileBloc>().add(LoadPersonalProfile());
          Navigator.pop(context);
        } else if (state is EditProfileSuccess) {
          Navigator.pop(context);
          context.read<ProfileBloc>().add(LoadPersonalProfile());
        } else if (state is EditProfileLoading) {
          context.read<ProfileBloc>().add(LoadPersonalProfile());
        } else if (state is EditProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(errorSnack(
            state.error,
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: _height * 100,
                decoration: BoxDecoration(
                  gradient: Pellet.kBackgroundGradient,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PictureBanner(
                        avatarUrl: user.avatar,
                        bannerUrl: user.banner,
                        userId: user.id,
                        enableEditMode: true,
                        isOwnProfile: true,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<EditProfileBloc>().add(
                                AvatarPickerButtonPressed(),
                              );
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Pellet.kDark.withOpacity(0),
                            width: _width * 22,
                            height: _height * 5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFieldTitle(title: 'Username'),
                            SizedBox(height: _height * 1),
                            EditProfileTextField(
                              hintText: 'Username',
                              controller: _usernameController,
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileUsernameChangedEvent(
                                        value,
                                      ),
                                    );
                              },
                            ),
                            SizedBox(height: _height * 4),
                            TextFieldTitle(title: 'Dislpay Name'),
                            SizedBox(height: _height * 1),
                            EditProfileTextField(
                              hintText: 'Display Name',
                              controller: _displayNameController,
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileDisplayNameChangedEvent(
                                        value,
                                      ),
                                    );
                              },
                            ),
                            SizedBox(height: _height * 4),
                            TextFieldTitle(title: 'Bio'),
                            SizedBox(height: _height * 1),
                            EditProfileTextField(
                              hintText: 'Bio',
                              isBio: true,
                              controller: _bioController,
                              onChanged: (value) {
                                context.read<EditProfileBloc>().add(
                                      EditProfileBioChangedEvent(
                                        value,
                                      ),
                                    );
                              },
                            ),
                            SizedBox(height: _height * 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: _width * 5,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Pellet.kDark,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('ID VERIFICATION'),
                                  user.verified
                                      ? Text(
                                          'VERIFIED',
                                          style: TextStyle(
                                            color: Pellet.kBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            context.read<EditProfileBloc>().add(
                                                  RequestEmailVerification(
                                                    'user.email',
                                                  ),
                                                );
                                          },
                                          child: Text(
                                            state is EmailVerificationSent
                                                ? 'Email Sent'
                                                : state is EmailVerificationSending
                                                    ? 'Sending...'
                                                    : 'Request Verification',
                                            style: TextStyle(
                                              color: state
                                                          is EmailVerificationSent ||
                                                      state
                                                          is EmailVerificationSending
                                                  ? Pellet.kGrey
                                                  : Pellet.kBlue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.viewInsetsOf(context).bottom,
                      ),
                    ],
                  ),
                ),
              ),
              if (state is EditProfileLoading)
                Center(
                  child: Lottie.asset(Assets.progressIndicator),
                ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (state is EditCanSubmit) {
                context.read<EditProfileBloc>().add(
                      SubmitButtonPressedEvent(
                        username: _usernameController.text,
                        displayName: _displayNameController.text,
                        bio: _bioController.text,
                      ),
                    );
              }
            },
            child: Icon(Icons.check),
            backgroundColor:
                state is EditCanSubmit || state is ProfileImageState
                    ? Pellet.kBlue
                    : Pellet.kGrey,
          ),
        );
      },
    );
  }
}

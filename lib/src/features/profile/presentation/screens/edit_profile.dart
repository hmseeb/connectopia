import '../../../../common/messages/error_snakbar.dart';
import '../../../../constants/assets.dart';
import '../../../authentication/presentation/widgets/field_title.dart';
import '../../application/edit_profile_bloc/edit_profile_bloc.dart';
import '../../application/profile_bloc/profile_bloc.dart';
import '../../domain/models/user.dart';
import '../widgets/profile_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});

  final User user;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  XFile? avatar, banner;
  late TextEditingController _usernameController;
  late TextEditingController _displayNameController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(
      text: widget.user.username,
    );
    _displayNameController = TextEditingController(
      text: widget.user.name,
    );
    _bioController = TextEditingController(
      text: widget.user.bio,
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
        if (state is EditProfileSuccess) {
          context.read<ProfileBloc>().add(LoadProfileEvent());
          Navigator.pop(context);
        }
        if (state is EditProfileFailure) {
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
                  gradient: Pellete.kBackgroundGradient,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PictureBanner(
                        avatarUrl: widget.user.avatar,
                        bannerUrl: widget.user.banner,
                        userId: widget.user.id,
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
                            color: Pellete.kDark.withOpacity(0),
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
                                color: Pellete.kDark,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('ID VERIFICATION'),
                                  widget.user.verified
                                      ? Text(
                                          'VERIFIED',
                                          style: TextStyle(
                                            color: Pellete.kBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            context.read<EditProfileBloc>().add(
                                                  RequestEmailVerification(
                                                    widget.user.email,
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
                                                  ? Pellete.kGrey
                                                  : Pellete.kBlue,
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
                    ? Pellete.kBlue
                    : Pellete.kGrey,
          ),
        );
      },
    );
  }
}

class EditProfileTextField extends StatelessWidget {
  const EditProfileTextField({
    super.key,
    required this.hintText,
    this.isBio = false,
    required this.controller,
    required this.onChanged,
  });

  final String hintText;
  final bool isBio;
  final TextEditingController controller;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _width * 5,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Pellete.kDark,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTapOutside: ((event) => FocusScope.of(context).unfocus()),
        maxLines: isBio ? 3 : 1,
        maxLength: isBio ? 420 : null,
        scrollPadding:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

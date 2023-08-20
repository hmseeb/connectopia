import 'package:connectopia/src/features/authentication/presentation/widgets/field_title.dart';
import 'package:connectopia/src/features/profile/application/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:connectopia/src/features/profile/presentation/widgets/profile_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/sizing.dart';
import '../../../../theme/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final _usernameController;
  late final _displayNameController;
  late final _bioController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _displayNameController = TextEditingController();
    _bioController = TextEditingController();
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
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: _height * 100,
            decoration: BoxDecoration(
              gradient: Pellete.kBackgroundGradient,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PictureBanner(
                    isOwnProfile: true,
                    enableEditMode: true,
                  ),
                  SizedBox(height: _height * 7),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('ID Verification'),
                              Text(
                                'Send Verification Email',
                                style: TextStyle(
                                  color: Pellete.kBlue,
                                  fontWeight: FontWeight.bold,
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.check,
            ),
            backgroundColor:
                state is EditCanSubmit ? Pellete.kBlue : Pellete.kGrey,
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

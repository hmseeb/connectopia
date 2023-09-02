import 'package:connectopia/src/common/messages/error_snackbar.dart';
import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/messaging/application/create_chat_bloc/create_chat_bloc.dart';
import 'package:connectopia/src/features/messaging/presentation/screens/chats.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CreateDM extends StatefulWidget {
  const CreateDM({super.key});

  @override
  State<CreateDM> createState() => _CreateChatsState();
}

class _CreateChatsState extends State<CreateDM> {
  late final TextEditingController _searchController;
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  String selectedUser = '';

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return BlocConsumer<CreateChatBloc, CreateChatState>(
      listener: (context, state) {
        if (state is SearchedUsers) {
          users = state.users;
        } else if (state is SearchingUsersFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnack('An error occurred while searching users.'),
          );
        } else if (state is ChatCreated) {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: Pellet.kBackgroundGradient,
          ),
          child: Scaffold(
            appBar: AppBar(
              title: Text('New Message'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'To',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: _height * 1),
                  DmsTextField(
                      controller: _searchController,
                      hintText: 'Search',
                      onChanged: (value) {
                        context
                            .read<CreateChatBloc>()
                            .add(CreateChatTextChanged(value));
                      }),
                  SizedBox(height: _height * 1),
                  state is SearchedUsers
                      ? SizedBox(
                          height: _height * 60,
                          child: users.isNotEmpty
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(users[index].username),
                                      subtitle: Text(users[index].email),
                                      trailing: Radio(
                                        value: users[index].id,
                                        groupValue: selectedUser,
                                        fillColor: MaterialStateProperty.all(
                                            Pellet.kSecondary),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedUser = value!;
                                          });
                                        },
                                      ),
                                      leading: users[index].avatar.isNotEmpty
                                          ? CircleAvatar(
                                              backgroundImage: MemoryImage(
                                                  ProfileRepo.decodeBase64(
                                              users[index].avatar,
                                            )))
                                          : CircleAvatar(
                                              backgroundImage: AssetImage(
                                                Assets.avatarPlaceholder,
                                              ),
                                            ),
                                      onTap: () {
                                        setState(() {
                                          selectedUser = users[index].id;
                                        });
                                        // Navigator.pushReplacementNamed(
                                        //   context,
                                        //   '/messages',
                                        //   arguments: {
                                        //     'isCreator': true,
                                        //     'chatId': '',
                                        //   },
                                        // );
                                      },
                                    );
                                  },
                                  itemCount: users.length,
                                )
                              : Center(
                                  child: state is NoUsersFound
                                      ? Text('No users found')
                                      : Text('Search for users')),
                        )
                      : state is SearchingUsers
                          ? Skeletonizer(
                              enabled: true,
                              child: SizedBox(
                                child: FakeListView(),
                                height: _height * 60,
                              ),
                            )
                          : Container(),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: SizedBox(
              width: ScreenSize.width(context) * 90,
              height: ScreenSize.height(context) * 6,
              child: ElevatedButton(
                onPressed: selectedUser.isNotEmpty
                    ? () {
                        context
                            .read<CreateChatBloc>()
                            .add(CreateChatButtonPressed(
                              selectedUser,
                            ));
                      }
                    : null,
                child: Text('Create Chat'),
              ),
            ),
          ),
        );
      },
    );
  }
}

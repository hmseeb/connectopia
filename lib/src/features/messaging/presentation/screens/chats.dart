import 'package:connectopia/src/common/messages/error_snackbar.dart';
import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/features/messaging/application/chats_bloc/chats_bloc.dart';
import 'package:connectopia/src/features/messaging/domain/models/chat.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DmsView extends StatefulWidget {
  const DmsView({super.key});

  @override
  State<DmsView> createState() => _DmsViewState();
}

class _DmsViewState extends State<DmsView> {
  late List<Chat> chats;
  late String userId;
  late final TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    chats = context.read<ChatsBloc>().chats;
    userId = context.read<ChatsBloc>().userId;
    if (chats.isEmpty) {
      context.read<ChatsBloc>().add(LoadChats());
    }
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<ChatsBloc, ChatsState>(
        listener: (context, state) {
          if (state is LoadedChats) {
            chats = context.read<ChatsBloc>().chats;
            userId = state.userId;
          } else if (state is LoadingChatsFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              errorSnack(state.message),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(height: _height * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: _width * ScreenSize.kSpaceXL,
                      fontWeight: FontWeight.bold,
                      color: Pellet.kWhite,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/create-dm');
                    },
                    child: Icon(
                      IconlyLight.add_user,
                      color: Pellet.kWhite,
                    ),
                  )
                ],
              ),
              SizedBox(height: _height * 2),
              DmsTextField(
                controller: _searchController,
                hintText: 'Search for a person or message',
                onChanged: (value) {},
              ),
              SizedBox(height: _height * 2),
              CustomRefreshIndicator(
                builder: MaterialIndicatorDelegate(
                  builder: (context, controller) {
                    return Lottie.asset(Assets.progressIndicator);
                  },
                ),
                onRefresh: () async {
                  context.read<ChatsBloc>().add(LoadChats());
                },
                child: Skeletonizer(
                  enabled: state is LoadingChats,
                  child: SizedBox(
                    child: state is LoadedChats
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              bool isCreator =
                                  chats[index].expand.createdBy.id == userId;
                              String time = chats[index]
                                  .updated
                                  .toString()
                                  .substring(11, 16);
                              return ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/messages',
                                    arguments: {
                                      'isCreator': isCreator,
                                      'chatId': chats[index].id,
                                      'username': isCreator
                                          ? chats[index]
                                              .expand
                                              .createdWith
                                              .username
                                          : chats[index]
                                              .expand
                                              .createdBy
                                              .username,
                                      'avatar': isCreator
                                          ? chats[index]
                                              .expand
                                              .createdWith
                                              .avatar
                                          : chats[index]
                                              .expand
                                              .createdBy
                                              .avatar,
                                      'receiverId': isCreator
                                          ? chats[index].expand.createdWith.id
                                          : chats[index].expand.createdBy.id,
                                    },
                                  );
                                },
                                leading: isCreator
                                    ? chats[index]
                                            .expand
                                            .createdWith
                                            .avatar
                                            .isNotEmpty
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(
                                              ProfileRepo.decodeBase64(isCreator
                                                  ? chats[index]
                                                      .expand
                                                      .createdWith
                                                      .avatar
                                                  : chats[index]
                                                      .expand
                                                      .createdBy
                                                      .avatar),
                                            ),
                                          )
                                        : chats[index]
                                                .expand
                                                .createdBy
                                                .avatar
                                                .isNotEmpty
                                            ? CircleAvatar(
                                                backgroundImage: MemoryImage(
                                                  ProfileRepo.decodeBase64(
                                                      isCreator
                                                          ? chats[index]
                                                              .expand
                                                              .createdWith
                                                              .avatar
                                                          : chats[index]
                                                              .expand
                                                              .createdBy
                                                              .avatar),
                                                ),
                                              )
                                            : CircleAvatar(
                                                backgroundImage: AssetImage(
                                                  Assets.avatarPlaceholder,
                                                ),
                                              )
                                    : chats[index]
                                            .expand
                                            .createdBy
                                            .avatar
                                            .isNotEmpty
                                        ? CircleAvatar(
                                            backgroundImage: MemoryImage(
                                              ProfileRepo.decodeBase64(isCreator
                                                  ? chats[index]
                                                      .expand
                                                      .createdWith
                                                      .avatar
                                                  : chats[index]
                                                      .expand
                                                      .createdBy
                                                      .avatar),
                                            ),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: AssetImage(
                                              Assets.avatarPlaceholder,
                                            ),
                                          ),
                                title: Text(
                                  isCreator
                                      ? chats[index].expand.createdWith.username
                                      : chats[index].expand.createdBy.username,
                                ),
                                subtitle: Text(
                                  'Message content goes here',
                                ),
                                trailing: Text(
                                  time,
                                ),
                              );
                            },
                          )
                        : SizedBox(
                            child: FakeListView(),
                            height: _height * 80,
                          ),
                    height: _height * 80,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DmsTextField extends StatelessWidget {
  const DmsTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });
  final TextEditingController controller;
  final String hintText;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: _height * 5,
      decoration: BoxDecoration(
          color: Pellet.kDark, borderRadius: BorderRadius.circular(32)),
      child: TextField(
        controller: controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class FakeListView extends StatelessWidget {
  const FakeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(
            Assets.avatarPlaceholder,
          ),
        ),
        title: Text('John Doe'),
        subtitle: Text('Message content goes here'),
        trailing: Text('12:00'),
      ),
    );
  }
}

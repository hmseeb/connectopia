import 'package:connectopia/src/common/messages/error_snackbar.dart';
import 'package:connectopia/src/constants/assets.dart';
import 'package:connectopia/src/constants/sizing.dart';
import 'package:connectopia/src/db/encryption.dart';
import 'package:connectopia/src/features/messaging/application/messages_bloc/messages_bloc.dart';
import 'package:connectopia/src/features/messaging/models/message.dart';
import 'package:connectopia/src/features/messaging/presentation/screens/chats.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:connectopia/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';

class Messages extends StatefulWidget {
  const Messages(
      {super.key,
      required this.chatId,
      required this.username,
      required this.avatar,
      required this.receiverId});
  final String avatar;
  final String username;
  final String chatId;
  final String receiverId;

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String userId = '';
  late List<Message> messages = [];
  late final _messageController;
  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    context.read<MessagesBloc>().add(LoadMessages(chatId: widget.chatId));
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _height = ScreenSize.height(context);
    final _width = ScreenSize.width(context);
    return Container(
      decoration: BoxDecoration(
        gradient: Pellet.kBackgroundGradient,
      ),
      child: BlocConsumer<MessagesBloc, MessagesState>(
        listener: (context, state) {
          print(state);
          if (state is LoadedMessages) {
            messages = state.messages;
            if (userId.isEmpty) {
              userId = state.userId;
            }
          } else if (state is FailedLoadingMessages) {
            ScaffoldMessenger.of(context).showSnackBar(
              errorSnack(state.message),
            );
          } else if (state is MessageSendingFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              errorSnack(state.message),
            );
          } else if (state is MessageSent) {
            _messageController.clear();
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: widget.avatar.isNotEmpty
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(
                                  ProfileRepo.decodeBase64(widget.avatar)),
                            )
                          : CircleAvatar(
                              backgroundImage: AssetImage(
                                Assets.avatarPlaceholder,
                              ),
                            ),
                    ),
                    SizedBox(width: _width * 3),
                    Text(widget.username),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyBold.call,
                      color: Pellet.kBlue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyBold.video,
                      color: Pellet.kBlue,
                    ),
                  ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                      height: _height * 80,
                      child: messages.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return state is LoadingMessages
                                    ? SizedBox()
                                    : Align(
                                        child: Container(
                                          child: Text(
                                            Encryption.decryptAES(
                                              messages[index].content,
                                            ),
                                            style: TextStyle(
                                              color: messages[index].sender ==
                                                      userId
                                                  ? Pellet.kWhite
                                                  : Pellet.kWhite,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                messages[index].sender == userId
                                                    ? Pellet.kSecondary
                                                    : Pellet.kDark,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        alignment:
                                            messages[index].sender == userId
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                      );
                              },
                            )
                          : state is LoadingMessages && messages.isEmpty
                              ? Center(
                                  child: Lottie.asset(
                                    Assets.progressIndicator,
                                  ),
                                )
                              : SizedBox()),
                  Center(
                    child: MessagesTextField(
                      messageController: _messageController,
                      userId: userId,
                      widget: widget,
                      messages: messages,
                      state: state,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.viewInsetsOf(context).bottom,
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class MessagesTextField extends StatelessWidget {
  const MessagesTextField({
    super.key,
    required this.messageController,
    required this.userId,
    required this.widget,
    required this.messages,
    required this.state,
  });

  final TextEditingController messageController;
  final String userId;
  final Messages widget;
  final List<Message> messages;
  final MessagesState state;

  @override
  Widget build(BuildContext context) {
    final _width = ScreenSize.width(context);
    return Container(
      width: _width * 90,
      child: Row(
        children: [
          Expanded(
            child: DmsTextField(
              controller: messageController,
              hintText: 'Send a message',
              onChanged: (value) {
                context
                    .read<MessagesBloc>()
                    .add(MessageTextChanged(message: value));
              },
            ),
          ),
          IconButton(
            onPressed: () {
              if (state is CanSendMessage) {
                context.read<MessagesBloc>().add(SendMessage(
                      message: Encryption.encryptAES(
                        messageController.text,
                      ),
                      senderId: userId,
                      receiverId: widget.receiverId,
                      chatId: widget.chatId,
                    ));
              }
            },
            icon: state is MessageSending
                ? Lottie.asset(Assets.progressIndicator)
                : Icon(
                    IconlyBold.send,
                    color:
                        state is CanSendMessage ? Pellet.kBlue : Pellet.kGrey,
                  ),
          )
        ],
      ),
    );
  }
}

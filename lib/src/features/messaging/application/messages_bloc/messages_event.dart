part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

final class LoadMessages extends MessagesEvent {
  final String chatId;

  const LoadMessages({
    required this.chatId,
  });

  @override
  List<Object> get props => [chatId];
}

final class MessageTextChanged extends MessagesEvent {
  final String message;

  const MessageTextChanged({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class SendMessage extends MessagesEvent {
  final String chatId;
  final String senderId;
  final String receiverId;
  final String message;

  const SendMessage({
    required this.senderId,
    required this.receiverId,
    required this.chatId,
    required this.message,
  });

  @override
  List<Object> get props => [chatId, message];
}

final class NewMessages extends MessagesEvent {
  final List<Message> messages;
  const NewMessages(this.messages);
}

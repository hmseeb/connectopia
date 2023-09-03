part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

final class MessagesInitial extends MessagesState {}

final class LoadingMessages extends MessagesState {}

final class LoadedMessages extends MessagesState {
  final String userId;
  final List<Message> messages;

  LoadedMessages({required this.userId, required this.messages});
}

final class FailedLoadingMessages extends MessagesState {
  final String message;

  const FailedLoadingMessages({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class CanSendMessage extends MessagesState {}

final class MessageSending extends MessagesState {}

final class MessageSent extends MessagesState {}

final class MessageSendingFailed extends MessagesState {
  final String message;

  const MessageSendingFailed(this.message);

  @override
  List<Object> get props => [message];
}

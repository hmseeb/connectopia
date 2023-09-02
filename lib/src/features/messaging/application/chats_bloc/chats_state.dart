part of 'chats_bloc.dart';

sealed class ChatsState extends Equatable {
  const ChatsState();

  @override
  List<Object> get props => [];
}

final class ChatsInitial extends ChatsState {}

final class LoadingChats extends ChatsState {}

final class LoadingChatsFailed extends ChatsState {
  final String message;
  LoadingChatsFailed(this.message);
}

final class LoadedChats extends ChatsState {
  final String userId;
  LoadedChats(this.userId);
}

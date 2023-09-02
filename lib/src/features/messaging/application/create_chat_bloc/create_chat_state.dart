part of 'create_chat_bloc.dart';

sealed class CreateChatState extends Equatable {
  const CreateChatState();

  @override
  List<Object> get props => [];
}

final class CreateChatInitial extends CreateChatState {}

final class SearchingUsers extends CreateChatState {}

final class SearchingUsersFailed extends CreateChatState {}

final class NoUsersFound extends CreateChatState {}

final class CreatingChat extends CreateChatState {}

final class ChatCreated extends CreateChatState {}

final class ChatCreationFailed extends CreateChatState {
  final String message;
  ChatCreationFailed(this.message);
}

final class SearchedUsers extends CreateChatState {
  SearchedUsers(this.users);
  final List<User> users;
}

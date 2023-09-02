part of 'create_chat_bloc.dart';

sealed class CreateChatEvent extends Equatable {
  const CreateChatEvent();

  @override
  List<Object> get props => [];
}

final class CreateChatTextChanged extends CreateChatEvent {
  final String text;

  const CreateChatTextChanged(
    this.text,
  );

  @override
  List<Object> get props => [text];
}

final class CreateChatButtonPressed extends CreateChatEvent {
  final String createdWith;

  CreateChatButtonPressed(this.createdWith);

  @override
  List<Object> get props => [createdWith];
}

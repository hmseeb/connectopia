import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/messaging/data/repository/messaging.repo.dart';
import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:equatable/equatable.dart';

part 'create_chat_event.dart';
part 'create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  CreateChatBloc() : super(CreateChatInitial()) {
    on<CreateChatTextChanged>((event, emit) async {
      try {
        emit(SearchingUsers());
        MessagingRepository msgRepo = MessagingRepository();
        final record = await msgRepo.searchUsers(event.text);
        List<User> users =
            record.map((e) => User.fromJson(e.toJson())).toList();
        if (users.isEmpty)
          emit(NoUsersFound());
        else
          emit(SearchedUsers(users));
      } catch (e) {
        emit(SearchingUsersFailed());
      }
    });
    on<CreateChatButtonPressed>((event, emit) async {
      emit(CreatingChat());
      MessagingRepository msgRepo = MessagingRepository();
      try {
        await msgRepo.createChat(event.createdWith);
        emit(ChatCreated());
      } catch (e) {
        emit(ChatCreationFailed('Failed to create chat.'));
      }
    });
  }
}

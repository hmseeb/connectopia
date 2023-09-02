import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/db/pocketbase.dart';
import 'package:connectopia/src/features/messaging/data/repository/messaging.repo.dart';
import 'package:connectopia/src/features/messaging/domain/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:pocketbase/pocketbase.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  List<Message> messages = [];
  String userId = '';
  MessagesBloc() : super(MessagesInitial()) {
    on<LoadMessages>((event, emit) async {
      emit(LoadingMessages());
      try {
        MessagingRepository msgRepo = MessagingRepository();
        final record = await msgRepo.loadMessages(event.chatId);
        messages = record.map((msg) => Message.fromJson(msg.toJson())).toList();
        PocketBase pb = await PocketBaseSingleton.instance;
        emit(LoadedMessages(pb.authStore.model.id));
      } catch (e) {
        ErrorHandlerRepo handlerRepo = ErrorHandlerRepo();
        emit(FailedLoadingMessages(message: handlerRepo.handleError(e)));
      }
    });
    on<MessageTextChanged>((event, emit) {
      if (event.message.isNotEmpty)
        emit(CanSendMessage());
      else
        emit(MessagesInitial());
    });
    on<SendMessage>((event, emit) async {
      try {
        emit(MessageSending());
        MessagingRepository msgRepo = MessagingRepository();
        await msgRepo.sendMessage(
          event.senderId,
          event.receiverId,
          event.chatId,
          event.message,
        );
        emit(MessageSent());
      } catch (e) {
        ErrorHandlerRepo handlerRepo = ErrorHandlerRepo();
        emit(MessageSendingFailed(handlerRepo.handleError(e)));
      }
    });
  }
}

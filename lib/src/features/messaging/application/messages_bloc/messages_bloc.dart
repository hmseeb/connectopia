import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/db/pocketbase.dart';
import 'package:connectopia/src/features/messaging/data/repository/messaging.repo.dart';
import 'package:connectopia/src/features/messaging/models/message.dart';
import 'package:equatable/equatable.dart';
import 'package:pocketbase/pocketbase.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  String userId = '';
  String chatId = '';
  MessagingRepository msgRepo = MessagingRepository();
  MessagesBloc() : super(MessagesInitial()) {
    subscribeToMessages() async {
      PocketBase pb = await PocketBaseSingleton.instance;
      return pb.collection('messages').subscribe('*', (e) async {
        final record = await msgRepo.loadMessages(chatId);
        List<Message> messages =
            record.map((msg) => Message.fromJson(msg.toJson())).toList();
        this.add(NewMessages(messages));
      });
    }

    subscribeToMessages();

    on<NewMessages>((event, emit) async {
      emit(LoadingMessages());

      PocketBase pb = await PocketBaseSingleton.instance;

      emit(LoadedMessages(
          messages: event.messages, userId: pb.authStore.model.id));
    });

    on<LoadMessages>((event, emit) async {
      chatId = event.chatId;
      emit(LoadingMessages());
      try {
        final record = await msgRepo.loadMessages(chatId);
        List<Message> messages =
            record.map((msg) => Message.fromJson(msg.toJson())).toList();
        PocketBase pb = await PocketBaseSingleton.instance;
        emit(LoadedMessages(userId: pb.authStore.model.id, messages: messages));
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

    unubscribeToMessages() async {
      PocketBase pb = await PocketBaseSingleton.instance;
      return pb.collection('messages').unsubscribe();
    }
  }
}

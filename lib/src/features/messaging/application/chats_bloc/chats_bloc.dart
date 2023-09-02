import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/features/messaging/data/repository/messaging.repo.dart';
import 'package:connectopia/src/features/messaging/domain/models/chat.dart';
import 'package:connectopia/src/features/profile/data/repository/profile_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'chats_event.dart';
part 'chats_state.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  List<Chat> chats = [];
  String userId = '';
  ChatsBloc() : super(ChatsInitial()) {
    on<LoadChats>((event, emit) async {
      emit(LoadingChats());
      try {
        MessagingRepository msgRepository = MessagingRepository();
        final record = await msgRepository.loadChats();
        chats = record.map((e) => Chat.fromRecord(e)).toList();
        userId = await ProfileRepo.id;
        emit(LoadedChats(userId));
      } catch (e) {
        Logger logger = Logger();
        logger.e(e.toString());
        ErrorHandlerRepo errorHandler = ErrorHandlerRepo();
        String errorMsg = errorHandler.handleError(e);
        emit(LoadingChatsFailed(errorMsg));
      }
    });
  }
}

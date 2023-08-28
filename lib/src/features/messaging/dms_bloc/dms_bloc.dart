import 'package:bloc/bloc.dart';
import 'package:connectopia/src/common/data/errors_repo.dart';
import 'package:connectopia/src/features/messaging/data/repository/dms.repo.dart';
import 'package:connectopia/src/features/messaging/domain/models/expanded_message.dart';
import 'package:equatable/equatable.dart';

part 'dms_event.dart';
part 'dms_state.dart';

class DmsBloc extends Bloc<DmsEvent, DmsState> {
  late List<Message> dms = [];
  DmsBloc() : super(DmsInitial()) {
    on<LoadDms>((event, emit) async {
      emit(LoadingDms());
      DmsRepository dmsRepo = DmsRepository();
      try {
        final record = await dmsRepo.loadDms();
        final List<Message> messages =
            record.map((message) => Message.fromRecord(message)).toList();
        dms = messages;
        emit(LoadedDms(messages));
      } catch (e) {
        print(e);
        ErrorHandlerRepo errorHandlerRepo = ErrorHandlerRepo();
        String errorMsg = errorHandlerRepo.handleError(e);
        emit(LoadingFailedDms(errorMsg));
      }
    });
    // on<SubscribeMessages>((event, emit) async {
    //   pb = await PocketBaseSingleton.instance;
    //   emit(Subscribed());
    //   final record = pb.collection('messages').subscribe('*', (e) {
    //     print(e.action);
    //     print(e.record);
    //     Message message = Message.fromRecord(e.record!);
    //     print(message.content);
    //   });
    // });
  }
}

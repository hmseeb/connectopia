import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dm_event.dart';
part 'dm_state.dart';

class DmBloc extends Bloc<DmEvent, DmState> {
  DmBloc() : super(DmInitial()) {
    on<DmEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

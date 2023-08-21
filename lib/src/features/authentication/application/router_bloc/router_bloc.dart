import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'router_event.dart';
part 'router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc() : super(RouterInitial()) {
    on<RouterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}

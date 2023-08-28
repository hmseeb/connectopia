part of 'dms_bloc.dart';

sealed class DmsState extends Equatable {
  const DmsState();

  @override
  List<Object> get props => [];
}

final class DmsInitial extends DmsState {}

final class LoadingDms extends DmsState {}

final class LoadedDms extends DmsState {
  const LoadedDms(this.messages);
  final List<Message> messages;
}

final class LoadingFailedDms extends DmsState {
  final String error;
  const LoadingFailedDms(this.error);
}

final class Subscribed extends DmsState {}

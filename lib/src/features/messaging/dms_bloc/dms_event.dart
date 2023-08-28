part of 'dms_bloc.dart';

sealed class DmsEvent extends Equatable {
  const DmsEvent();

  @override
  List<Object> get props => [];
}

final class LoadDms extends DmsEvent {}
final class SubscribeMessages extends DmsEvent {}

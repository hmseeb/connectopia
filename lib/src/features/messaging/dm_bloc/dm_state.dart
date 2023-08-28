part of 'dm_bloc.dart';

sealed class DmState extends Equatable {
  const DmState();
  
  @override
  List<Object> get props => [];
}

final class DmInitial extends DmState {}

part of 'router_bloc.dart';

sealed class RouterState extends Equatable {
  const RouterState();
  
  @override
  List<Object> get props => [];
}

final class RouterInitial extends RouterState {}

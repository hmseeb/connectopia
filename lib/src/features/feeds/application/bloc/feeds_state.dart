part of 'feeds_bloc.dart';

sealed class FeedsState extends Equatable {
  const FeedsState();
  
  @override
  List<Object> get props => [];
}

final class FeedsInitial extends FeedsState {}

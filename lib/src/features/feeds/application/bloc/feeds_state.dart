part of 'feeds_bloc.dart';

sealed class FeedsState extends Equatable {
  const FeedsState();

  @override
  List<Object> get props => [];
}

final class FeedsInitial extends FeedsState {}

final class FeedsLoadedState extends FeedsState {
  FeedsLoadedState(this.user, this.posts);
  final User user;
  final List<Post> posts;
}

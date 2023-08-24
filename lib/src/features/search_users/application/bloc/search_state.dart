part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoadedState extends SearchState {
  final List<User> users;
  final List<Post> posts;

  const SearchLoadedState(this.users, this.posts);

  @override
  List<Object> get props => [users];
}

final class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState(this.message);

  @override
  List<Object> get props => [message];
}

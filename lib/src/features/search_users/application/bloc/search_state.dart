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
  final List<Post> media;

  const SearchLoadedState(this.users, this.media);

  @override
  List<Object> get props => [users];
}

final class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState(this.message);

  @override
  List<Object> get props => [message];
}

final class LoadingUserPosts extends SearchState {}

final class UserPostsLoadedState extends SearchState {
  final List<Post> posts;
  final int index;

  UserPostsLoadedState(this.posts, this.index);
}

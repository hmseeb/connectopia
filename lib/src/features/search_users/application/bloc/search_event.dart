part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

final class SearchUsersEvent extends SearchEvent {
  final String query;

  const SearchUsersEvent(this.query);

  @override
  List<Object> get props => [query];
}

final class GetUserPosts extends SearchEvent {
  final String id;
  final int index;

  GetUserPosts(this.id, this.index);
}

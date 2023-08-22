part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  ProfileLoadedState(this.user, this.posts);
  final User user;
  final List<Post> posts;
}

final class ProfileLoadingFailedState extends ProfileState {
  ProfileLoadingFailedState(this.error);
  final String error;
}

final class ProfilePostDeletionFailure extends ProfileState {
  ProfilePostDeletionFailure(this.error);
  final String error;
}

final class ProfilePostDeletedState extends ProfileState {
  ProfilePostDeletedState();
}

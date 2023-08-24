part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  ProfileLoadedState(this.posts, this.user);
  final List<Post> posts;
  final User user;
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

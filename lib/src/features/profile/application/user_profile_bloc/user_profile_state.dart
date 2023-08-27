part of 'user_profile_bloc.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();
  
  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}


final class UserProfileLoadingState extends UserProfileState {}

final class UserProfileLoadedState extends UserProfileState {
  UserProfileLoadedState(this.isFollowing);
  final bool? isFollowing;
}

final class UserProfileLoadingFailedState extends UserProfileState {
  UserProfileLoadingFailedState(this.error);
  final String error;
}
final class FollowingLoadingState extends UserProfileState {}

final class FollowedSuccessfulState extends UserProfileState {}

final class FollowedFailedState extends UserProfileState {
  FollowedFailedState(this.error);
  final String error;
}



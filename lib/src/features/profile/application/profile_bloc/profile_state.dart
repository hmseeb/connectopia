part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  ProfileLoadedState(this.user);
  final User user;
}

final class ProfileLoadingFailedState extends ProfileState {
  ProfileLoadingFailedState(this.error);
  final String error;
}

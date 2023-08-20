part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {}

final class EditCanSubmit extends EditProfileState {}

final class EditProfileFailure extends EditProfileState {
  const EditProfileFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

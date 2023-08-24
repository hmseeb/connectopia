part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
  const EditProfileSuccess(this.user);
  final User user;
}

final class BannerUpdateSuccess extends EditProfileState {}

final class AvatarUpdateSuccess extends EditProfileState {}

final class EditCanSubmit extends EditProfileState {}

final class EditProfileFailure extends EditProfileState {
  const EditProfileFailure(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class EmailVerificationSending extends EditProfileState {}

final class EmailVerificationSent extends EditProfileState {}

class ProfileImageState extends EditProfileState {
  ProfileImageState();
}

final class PickerError extends EditProfileState {
  const PickerError(this.error);
  final String error;
}

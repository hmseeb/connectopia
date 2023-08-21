part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class EditProfileUsernameChangedEvent extends EditProfileEvent {
  const EditProfileUsernameChangedEvent(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class EditProfileDisplayNameChangedEvent extends EditProfileEvent {
  const EditProfileDisplayNameChangedEvent(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class EditProfileBioChangedEvent extends EditProfileEvent {
  const EditProfileBioChangedEvent(this.bio);

  final String bio;

  @override
  List<Object> get props => [bio];
}

final class SubmitButtonPressedEvent extends EditProfileEvent {
  const SubmitButtonPressedEvent({this.username, this.displayName, this.bio});
  final String? username;
  final String? displayName;
  final String? bio;
}

final class RequestEmailVerification extends EditProfileEvent {
  const RequestEmailVerification(this.email);
  final String email;
}

final class AvatarPickerButtonPressed extends EditProfileEvent {
  const AvatarPickerButtonPressed();
}

final class BannerPickerButtonPressed extends EditProfileEvent {
  const BannerPickerButtonPressed();
}

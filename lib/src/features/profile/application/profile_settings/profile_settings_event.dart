part of 'profile_settings_bloc.dart';

sealed class AccountSettingsEvent extends Equatable {
  const AccountSettingsEvent();

  @override
  List<Object> get props => [];
}

final class SignOutButtonPressedEvent extends AccountSettingsEvent {
  const SignOutButtonPressedEvent();
}

final class ToggleAccountPrivacyEvent extends AccountSettingsEvent {
  const ToggleAccountPrivacyEvent(this.toggle);
  final bool toggle;
}

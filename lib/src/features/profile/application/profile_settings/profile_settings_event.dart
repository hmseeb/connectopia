part of 'profile_settings_bloc.dart';

sealed class AccountSettingssEvent extends Equatable {
  const AccountSettingssEvent();

  @override
  List<Object> get props => [];
}

final class SignOutButtonPressedEvent extends AccountSettingssEvent {
  const SignOutButtonPressedEvent();
}

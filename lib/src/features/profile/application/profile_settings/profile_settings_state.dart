part of 'profile_settings_bloc.dart';

sealed class AccountSettingsState extends Equatable {
  const AccountSettingsState();

  @override
  List<Object> get props => [];
}

final class AccountSettingsInitial extends AccountSettingsState {}

final class TogglePrivacySuccess extends AccountSettingsState {
  const TogglePrivacySuccess(this.togglePrivacy);
  final bool togglePrivacy;
}

final class TogglePrivacyLoading extends AccountSettingsState {}

final class TogglePrivacyError extends AccountSettingsState {
  const TogglePrivacyError(this.error);
  final String error;
}

final class SignoutError extends AccountSettingsState {
  const SignoutError(this.error);
  final String error;
}

final class SignoutSuccess extends AccountSettingsState {}

final class AccountSettingsLoading extends AccountSettingsState {}

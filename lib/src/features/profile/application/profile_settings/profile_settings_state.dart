part of 'profile_settings_bloc.dart';

sealed class AccountSettingssState extends Equatable {
  const AccountSettingssState();

  @override
  List<Object> get props => [];
}

final class AccountSettingssInitial extends AccountSettingssState {}

final class SignoutError extends AccountSettingssState {
  const SignoutError(this.error);
  final String error;
}

final class SignoutSuccess extends AccountSettingssState {}

final class AccountSettingsLoading extends AccountSettingssState {}

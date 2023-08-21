part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object> get props => [];
}

final class GallaryButtonClickedEvent extends CreatePostEvent {}

final class CameraButtonClickedEvent extends CreatePostEvent {}

final class LocationButtonClickedEvent extends CreatePostEvent {}

final class ToggleStoryButtonClickedEvent extends CreatePostEvent {}

final class CreatePostButtonClickedEvent extends CreatePostEvent {
  final String caption;
  final bool toggleStory;
  final bool enableLocation;

  const CreatePostButtonClickedEvent({
    required this.caption,
    required this.toggleStory,
    required this.enableLocation,
  });
}

final class CaptionChangedEvent extends CreatePostEvent {
  const CaptionChangedEvent(this.caption);
  final String caption;
}

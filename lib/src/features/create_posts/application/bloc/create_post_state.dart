part of 'create_post_bloc.dart';

sealed class CreatePosttate extends Equatable {
  const CreatePosttate();

  @override
  List<Object> get props => [];
}

final class CreatePostInitial extends CreatePosttate {}

final class PickedImageFromGallery extends CreatePosttate {
  const PickedImageFromGallery({
    required this.pickedFile,
  });

  final List<XFile?> pickedFile;

  @override
  List<Object> get props => [pickedFile];
}

final class CapturedPhoto extends CreatePosttate {
  const CapturedPhoto({
    required this.capturedPhoto,
  });

  final XFile? capturedPhoto;

  @override
  List<Object> get props => [capturedPhoto!];
}

final class CreatingPost extends CreatePosttate {}

final class PostCreationFailure extends CreatePosttate {
  final String error;

  const PostCreationFailure(
    this.error,
  );

  @override
  List<Object> get props => [error];
}

final class CreatedPost extends CreatePosttate {}

final class ValidCaptionState extends CreatePosttate {}

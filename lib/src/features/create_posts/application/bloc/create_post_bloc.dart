import 'package:bloc/bloc.dart';
import 'package:connectopia/src/features/create_posts/data/create_posts_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  XFile? pickedFile;
  List<XFile?> pickedFiles = [];

  CreatePostBloc() : super(CreatePostInitial()) {
    on<GallaryButtonClickedEvent>((event, emit) async {
      final picker = ImagePicker();
      pickedFiles = await picker.pickMultiImage();
      emit(PickedImageFromGallery(pickedFile: pickedFiles));
    });
    on<CameraButtonClickedEvent>((event, emit) async {
      final picker = ImagePicker();
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
      emit(CapturedPhoto(capturedPhoto: pickedFile));
    });
    on<LocationButtonClickedEvent>((event, emit) async {
      CreatePostsRepo repo = CreatePostsRepo();
      Position location = await repo.determinePosition();
      debugPrint('Location: ${location.altitude}');
    });
  }
}

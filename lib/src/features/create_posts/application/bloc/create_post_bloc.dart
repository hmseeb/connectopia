import 'package:bloc/bloc.dart';
import '../../../../common/data/errors_repo.dart';
import '../../data/create_posts_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePosttate> {
  XFile? pickedFile;
  List<XFile?> pickedFiles = [];
  String? userLocation;
  ErrorHandlerRepo handleError = ErrorHandlerRepo();

  CreatePostBloc() : super(CreatePostInitial()) {
    on<GallaryButtonClickedEvent>((event, emit) async {
      pickedFiles = [];
      pickedFile = null;
      final picker = ImagePicker();
      pickedFiles = await picker.pickMultiImage();
      if (pickedFiles.isEmpty) return;
      emit(PickedImageFromGallery(pickedFile: pickedFiles));
    });
    on<CameraButtonClickedEvent>((event, emit) async {
      pickedFiles = [];
      pickedFile = null;
      final picker = ImagePicker();
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile == null) return;
      emit(CapturedPhoto(capturedPhoto: pickedFile));
    });

    on<LocationButtonClickedEvent>((event, emit) async {
      CreatePostRepo repo = CreatePostRepo();

      try {
        final location = await repo.determineLocation();
        userLocation = '${location.locality}, ${location.country}';
      } catch (err) {
        String errorMsg = handleError.handleError(err);
        emit(PostCreationFailure(errorMsg));
      }
    });

    on<CreatePostButtonClickedEvent>((event, emit) async {
      emit(CreatingPost());
      CreatePostRepo repo = CreatePostRepo();
      if (!event.enableLocation) userLocation = null;
      if (pickedFile != null) pickedFiles.add(pickedFile!);

      try {
        await repo.createPost(
            event.caption, userLocation, event.toggleStory, pickedFiles);
        emit(CreatedPost());
        pickedFile = null;
        pickedFiles = [];
        userLocation = null;
      } catch (err) {
        String errorMsg = handleError.handleError(err);
        emit(PostCreationFailure(errorMsg));
        pickedFile = null;
        pickedFiles = [];
        userLocation = null;
      }
    });

    on<CaptionChangedEvent>((event, emit) {
      if (event.caption.isNotEmpty)
        emit(ValidCaptionState());
      else
        emit(CreatePostInitial());
    });
  }
}

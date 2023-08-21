import 'package:connectopia/src/db/pocketbase.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';

class ProfileRepo {
  Future<RecordModel> get user async {
    PocketBase pb = await PocketBaseSingleton.instance;
    try {
      final id = pb.authStore.model.id;
      RecordModel record = await pb.collection('users').getOne(
            id,
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  Future<RecordModel> updateProfile(
    String? username,
    String? name,
    String? bio,
  ) async {
    PocketBase pb = await PocketBaseSingleton.instance;
    final body = <String, dynamic>{
      "id": pb.authStore.model.id,
      if (username != null) "username": username,
      if (name != null) "name": name,
      if (bio != null) "bio": bio,
    };

    try {
      final id = pb.authStore.model.id;
      RecordModel record = await pb.collection('users').update(
            id,
            body: body,
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  Future requestVerification(String email) async {
    PocketBase pb = await PocketBaseSingleton.instance;
    try {
      return await pb.collection('users').requestVerification(email);
    } catch (e) {
      throw e;
    }
  }

  Future<RecordModel> updateAvatarOrBanner(
      XFile? pickedImage, String field) async {
    PocketBase pb = await PocketBaseSingleton.instance;
    try {
      final id = pb.authStore.model.id;
      final record = await pb.collection('users').update(
        id,
        files: [
          await http.MultipartFile.fromPath(
            field,
            pickedImage!.path,
          ),
        ],
      );
      return record;
    } catch (e) {
      throw e;
    }
  }
}

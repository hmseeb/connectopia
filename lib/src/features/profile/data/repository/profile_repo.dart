import 'package:connectopia/src/db/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class ProfileRepo {
  PocketBase pb = PocketBaseSingleton().pb;

  Future<RecordModel> get user async {
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

  Future<RecordModel> updateProfile(String username, String name, String bio,
      String avatar, String bannner) async {
    final body = <String, dynamic>{
      if (avatar.isNotEmpty) "avatar": "test_avatar_update",
      if (bannner.isNotEmpty) "banner": "test_banner_update",
      if (username.isNotEmpty) "username": username,
      if (name.isNotEmpty) "name": name,
      if (bio.isNotEmpty) "bio": bio,
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
}

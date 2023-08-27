import 'package:connectopia/src/db/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class SearchRepo {
  Future<ResultList<RecordModel>> searchUsers(String query) async {
    PocketBase pb = await PocketBaseSingleton.instance;

    try {
      final record = pb.collection('users').getList(
            filter:
                'id != "${pb.authStore.model.id}" && name = "$query" || username = "$query"',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  Future<List<RecordModel>> searchPosts(String query) async {
    PocketBase pb = await PocketBaseSingleton.instance;

    try {
      List<RecordModel> record = await pb.collection('posts').getFullList(
            sort: '-updated',
            filter: 'caption = "$query"',
            expand: 'user',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }
}

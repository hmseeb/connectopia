import 'package:connectopia/src/db/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class SearchRepo {
  Future<ResultList<RecordModel>> searchUsers(String query) async {
    PocketBase pb = await PocketBaseSingleton.instance;

    try {
      final record = pb.collection('users').getList(
            filter: 'name = "$query"',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  Future<ResultList<RecordModel>> searchPosts(String query) async {
    PocketBase pb = await PocketBaseSingleton.instance;

    try {
      final record =
          pb.collection('posts').getList(filter: 'caption = "$query"');

      return record;
    } catch (e) {
      throw e;
    }
  }
}

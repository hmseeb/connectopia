import 'package:connectopia/src/db/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class FeedsRepo {
  static String getGreeting() {
    var currentTime = DateTime.now();
    var hour = currentTime.hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    } else if (hour >= 17 && hour < 20) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  Future<List<RecordModel>> get followingPosts async {
    PocketBase pb = await PocketBaseSingleton.instance;
    String filtered = '';
    try {
      List<RecordModel> followings =
          await pb.collection('followers').getFullList(
                filter: 'follower = "${pb.authStore.model.id}"',
                expand: 'follower, following',
              );
      if (followings.isNotEmpty) {
        String ids = followings
            .map((item) => "user = \"${item.data['following']}\" ||")
            .toString();
        String noCommas = ids.replaceAll(',', '');
        String noClosingBracket = noCommas.replaceAll('||)', '');
        filtered = noClosingBracket.replaceAll('(', '');
      } else {
        return [];
      }
    } catch (e) {
      throw e;
    }
    try {
      List<RecordModel> postsRecord = await pb.collection('posts').getFullList(
            sort: '-updated',
            filter: filtered.isNotEmpty ? '$filtered' : '',
            expand: 'user',
          );
      return postsRecord;
    } catch (e) {
      throw e;
    }
  }
}

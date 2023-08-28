import 'dart:async';

import 'package:connectopia/src/db/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class DmsRepository {
  Future<List<RecordModel>> loadDms() async {
    final pb = await PocketBaseSingleton.instance;
    try {
      final record = await pb.collection('messages').getFullList(
            filter: 'receiver = "${pb.authStore.model.id}"',
            sort: '-updated',
            expand: 'sender, receiver',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }
}

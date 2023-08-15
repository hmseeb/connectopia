import 'package:pocketbase/pocketbase.dart';

class PocketBaseSingleton {
  static final PocketBaseSingleton _instance = PocketBaseSingleton._internal();

  final PocketBase pb;

  factory PocketBaseSingleton() {
    return _instance;
  }

  PocketBaseSingleton._internal() : pb = PocketBase('http://127.0.0.1:8090');
}

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketbase/pocketbase.dart';

class PocketBaseSingleton {
  static final PocketBaseSingleton _instance = PocketBaseSingleton._internal();

  final PocketBase pb;

  factory PocketBaseSingleton() {
    return _instance;
  }
  PocketBaseSingleton._internal()
      : pb = PocketBase(dotenv.env['POCKETBASE_URL']!);
}

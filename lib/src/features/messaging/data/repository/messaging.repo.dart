import 'dart:async';

import 'package:connectopia/src/db/pocketbase.dart';
import 'package:pocketbase/pocketbase.dart';

class MessagingRepository {
  Future<List<RecordModel>> loadChats() async {
    final pb = await PocketBaseSingleton.instance;
    String userId = pb.authStore.model.id;
    try {
      final record = await pb.collection('chats').getFullList(
            filter: 'users ~ "$userId"',
            sort: '-updated',
            expand: 'users',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  Future<List<RecordModel>> loadMessages(String chatId) async {
    final pb = await PocketBaseSingleton.instance;
    try {
      final record = await pb.collection('messages').getFullList(
            filter: 'chat = "$chatId"',
            sort: '-created',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  Future<void> sendMessage(
      String sender, String receiver, String chatId, String message) async {
    final pb = await PocketBaseSingleton.instance;
    try {
      await pb.collection('messages').create(body: {
        'sender': sender,
        'receiver': receiver,
        'chat': chatId,
        'content': message,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<RecordModel>> searchUsers(String query) async {
    final pb = await PocketBaseSingleton.instance;
    try {
      final record = await pb.collection('users').getFullList(
            filter: 'username = "$query" || name = "$query"',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  Future<void> createChat(String createdWith) async {
    try {
      final pb = await PocketBaseSingleton.instance;
      String userId = pb.authStore.model.id;
      await pb.collection('chats').create(body: {
        "users": [userId, createdWith]
      });
    } catch (e) {
      throw e;
    }
  }
}

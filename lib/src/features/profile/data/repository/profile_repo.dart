import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../../db/pocketbase.dart';

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

  Future<String> encodeBase64(XFile? file) async {
    if (file == null) {
      return '';
    }
    Uint8List imagebytes = await file.readAsBytes();
    String base64string = base64.encode(imagebytes);
    return base64string;
  }

  // decode base64 string to image
  static Uint8List decodeBase64(String base64string) {
    if (base64string.isEmpty) {
      return Uint8List(0);
    }

    Uint8List decodedByte = base64.decode(base64string);

    return decodedByte;
  }

  Future<List<RecordModel>> get posts async {
    PocketBase pb = await PocketBaseSingleton.instance;

    try {
      final id = pb.authStore.model.id;
      final field = await pb.collection('users').getOne(
            id,
          );
      final username = field.getStringValue('username');

      List<RecordModel> record = await pb.collection('posts').getFullList(
            sort: '-updated',
            filter: 'username = "$username"',
          );
      return record;
    } catch (e) {
      throw e;
    }
  }

  void deletePost(String postId) async {
    PocketBase pb = await PocketBaseSingleton.instance;
    try {
      await pb.collection('posts').delete(postId);
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

  Future<bool> updateProfilePrivacy(bool togglePrivacy) async {
    togglePrivacy = !togglePrivacy;
    PocketBase pb = await PocketBaseSingleton.instance;
    final body = <String, dynamic>{
      "id": pb.authStore.model.id,
      "emailVisibility": togglePrivacy,
    };

    try {
      final id = pb.authStore.model.id;
      await pb.collection('users').update(
            id,
            body: body,
          );
      return togglePrivacy;
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
        body: {
          field: await encodeBase64(pickedImage),
        },
      );
      return record;
    } catch (e) {
      throw e;
    }
  }
}

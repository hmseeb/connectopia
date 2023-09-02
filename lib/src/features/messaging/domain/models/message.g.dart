// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      chat: json['chat'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      content: json['content'] as String,
      created: DateTime.parse(json['created'] as String),
      expand: Expand.fromJson(json['expand'] as Map<String, dynamic>),
      id: json['id'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'chat': instance.chat,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'content': instance.content,
      'created': instance.created.toIso8601String(),
      'expand': instance.expand,
      'id': instance.id,
      'receiver': instance.receiver,
      'sender': instance.sender,
      'updated': instance.updated.toIso8601String(),
    };

Expand _$ExpandFromJson(Map<String, dynamic> json) => Expand(
      chat: Chat.fromJson(json['chat'] as Map<String, dynamic>),
      receiver: Receiver.fromJson(json['receiver'] as Map<String, dynamic>),
      sender: Receiver.fromJson(json['sender'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpandToJson(Expand instance) => <String, dynamic>{
      'chat': instance.chat,
      'receiver': instance.receiver,
      'sender': instance.sender,
    };

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: DateTime.parse(json['created'] as String),
      createdBy: json['createdBy'] as String,
      createdWith: json['createdWith'] as String,
      id: json['id'] as String,
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'created': instance.created.toIso8601String(),
      'createdBy': instance.createdBy,
      'createdWith': instance.createdWith,
      'id': instance.id,
      'updated': instance.updated.toIso8601String(),
    };

Receiver _$ReceiverFromJson(Map<String, dynamic> json) => Receiver(
      avatar: json['avatar'] as String,
      banner: json['banner'] as String,
      bio: json['bio'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: DateTime.parse(json['created'] as String),
      email: json['email'] as String,
      emailVisibility: json['emailVisibility'] as bool,
      id: json['id'] as String,
      name: json['name'] as String,
      updated: DateTime.parse(json['updated'] as String),
      username: json['username'] as String,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$ReceiverToJson(Receiver instance) => <String, dynamic>{
      'avatar': instance.avatar,
      'banner': instance.banner,
      'bio': instance.bio,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'created': instance.created.toIso8601String(),
      'email': instance.email,
      'emailVisibility': instance.emailVisibility,
      'id': instance.id,
      'name': instance.name,
      'updated': instance.updated.toIso8601String(),
      'username': instance.username,
      'verified': instance.verified,
    };

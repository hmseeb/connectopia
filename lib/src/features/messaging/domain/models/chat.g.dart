// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: DateTime.parse(json['created'] as String),
      createdBy: json['createdBy'] as String,
      createdWith: json['createdWith'] as String,
      expand: Expand.fromJson(json['expand'] as Map<String, dynamic>),
      id: json['id'] as String,
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'created': instance.created.toIso8601String(),
      'createdBy': instance.createdBy,
      'createdWith': instance.createdWith,
      'expand': instance.expand,
      'id': instance.id,
      'updated': instance.updated.toIso8601String(),
    };

Expand _$ExpandFromJson(Map<String, dynamic> json) => Expand(
      createdBy: Created.fromJson(json['createdBy'] as Map<String, dynamic>),
      createdWith:
          Created.fromJson(json['createdWith'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpandToJson(Expand instance) => <String, dynamic>{
      'createdBy': instance.createdBy,
      'createdWith': instance.createdWith,
    };

Created _$CreatedFromJson(Map<String, dynamic> json) => Created(
      avatar: json['avatar'] as String,
      banner: json['banner'] as String,
      bio: json['bio'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: DateTime.parse(json['created'] as String),
      email: json['email'] as String?,
      emailVisibility: json['emailVisibility'] as bool,
      id: json['id'] as String,
      name: json['name'] as String,
      updated: DateTime.parse(json['updated'] as String),
      username: json['username'] as String,
      verified: json['verified'] as bool,
    );

Map<String, dynamic> _$CreatedToJson(Created instance) => <String, dynamic>{
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

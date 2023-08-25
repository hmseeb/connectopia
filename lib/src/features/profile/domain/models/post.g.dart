// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      caption: json['caption'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: DateTime.parse(json['created'] as String),
      expand: Expand.fromJson(json['expand'] as Map<String, dynamic>),
      id: json['id'] as String,
      image: (json['image'] as List<dynamic>).map((e) => e as String).toList(),
      location: json['location'] as String,
      story: json['story'] as bool,
      updated: DateTime.parse(json['updated'] as String),
      user: json['user'] as String,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'caption': instance.caption,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'created': instance.created.toIso8601String(),
      'expand': instance.expand,
      'id': instance.id,
      'image': instance.image,
      'location': instance.location,
      'story': instance.story,
      'updated': instance.updated.toIso8601String(),
      'user': instance.user,
    };

Expand _$ExpandFromJson(Map<String, dynamic> json) => Expand(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpandToJson(Expand instance) => <String, dynamic>{
      'user': instance.user,
    };

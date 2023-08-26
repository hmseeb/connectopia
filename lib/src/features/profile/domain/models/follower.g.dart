// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follower _$FollowerFromJson(Map<String, dynamic> json) => Follower(
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: DateTime.parse(json['created'] as String),
      expand: Expand.fromJson(json['expand'] as Map<String, dynamic>),
      follower: json['follower'] as String,
      following: json['following'] as String,
      id: json['id'] as String,
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$FollowerToJson(Follower instance) => <String, dynamic>{
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'created': instance.created.toIso8601String(),
      'expand': instance.expand,
      'follower': instance.follower,
      'following': instance.following,
      'id': instance.id,
      'updated': instance.updated.toIso8601String(),
    };

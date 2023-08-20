// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      username: json['username'] as String? ?? '',
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      name: json['name'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      location: json['location'] as String? ?? '',
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'username': instance.username,
      'image': instance.image,
      'name': instance.name,
      'caption': instance.caption,
      'location': instance.location,
    };

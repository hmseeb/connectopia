import 'package:connectopia/src/features/profile/domain/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: "caption")
  String caption;
  @JsonKey(name: "collectionId")
  String collectionId;
  @JsonKey(name: "collectionName")
  String collectionName;
  @JsonKey(name: "created")
  DateTime created;
  @JsonKey(name: "expand")
  Expand expand;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "image")
  List<String> image;
  @JsonKey(name: "location")
  String location;
  @JsonKey(name: "story")
  bool story;
  @JsonKey(name: "updated")
  DateTime updated;
  @JsonKey(name: "user")
  String user;

  Post({
    required this.caption,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.expand,
    required this.id,
    required this.image,
    required this.location,
    required this.story,
    required this.updated,
    required this.user,
  });

  factory Post.fromRecord(RecordModel record) => Post.fromJson(record.toJson());

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable()
class Expand {
  @JsonKey(name: "user")
  User user;

  Expand({
    required this.user,
  });
  factory Expand.fromRecord(RecordModel record) => Expand.fromJson(record.toJson());

  factory Expand.fromJson(Map<String, dynamic> json) => _$ExpandFromJson(json);

  Map<String, dynamic> toJson() => _$ExpandToJson(this);
}

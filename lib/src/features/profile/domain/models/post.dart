import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "created")
  DateTime created;
  @JsonKey(name: "updated")
  DateTime updated;
  @JsonKey(name: "collectionId")
  String collectionId;
  @JsonKey(name: "collectionName")
  String collectionName;
  @JsonKey(name: "caption")
  String caption;
  @JsonKey(name: "image")
  List<String> image;
  @JsonKey(name: "location")
  String location;
  @JsonKey(name: "story")
  bool story;
  @JsonKey(name: "username")
  String username;

  Post({
    required this.id,
    required this.created,
    required this.updated,
    required this.collectionId,
    required this.collectionName,
    required this.caption,
    required this.image,
    required this.location,
    required this.story,
    required this.username,
  });

  factory Post.fromRecord(RecordModel record) =>
      Post.fromJson(record.toJson());

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

import 'package:connectopia/src/features/profile/domain/models/post.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'follower.g.dart';

@JsonSerializable()
class Follower {
  @JsonKey(name: "collectionId")
  String collectionId;
  @JsonKey(name: "collectionName")
  String collectionName;
  @JsonKey(name: "created")
  DateTime created;
  @JsonKey(name: "expand")
  Expand expand;
  @JsonKey(name: "follower")
  String follower;
  @JsonKey(name: "following")
  String following;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "updated")
  DateTime updated;

  Follower({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.expand,
    required this.follower,
    required this.following,
    required this.id,
    required this.updated,
  });
  factory Follower.fromRecord(RecordModel record) =>
      Follower.fromJson(record.toJson());

  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerToJson(this);
}

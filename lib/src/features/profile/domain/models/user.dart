import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
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
  @JsonKey(name: "avatar")
  String avatar;
  @JsonKey(name: "banner")
  String banner;
  @JsonKey(name: "bio")
  String bio;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "emailVisibility")
  bool emailVisibility;
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "username")
  String username;
  @JsonKey(name: "verified")
  bool verified;

  User({
    required this.id,
    required this.created,
    required this.updated,
    required this.collectionId,
    required this.collectionName,
    required this.avatar,
    required this.banner,
    required this.bio,
    required this.email,
    required this.emailVisibility,
    required this.name,
    required this.username,
    required this.verified,
  });

  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

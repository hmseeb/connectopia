import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  @JsonKey(name: "collectionId")
  String collectionId;
  @JsonKey(name: "collectionName")
  String collectionName;
  @JsonKey(name: "created")
  DateTime created;
  @JsonKey(name: "expand")
  Expand? expand;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "updated")
  DateTime updated;
  @JsonKey(name: "users")
  List<String> users;

  Chat({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    this.expand,
    required this.id,
    required this.updated,
    required this.users,
  });

  Chat copyWith({
    String? collectionId,
    String? collectionName,
    DateTime? created,
    Expand? expand,
    String? id,
    DateTime? updated,
    List<String>? users,
  }) =>
      Chat(
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        created: created ?? this.created,
        expand: expand ?? this.expand,
        id: id ?? this.id,
        updated: updated ?? this.updated,
        users: users ?? this.users,
      );

  factory Chat.fromRecord(RecordModel record) => Chat.fromJson(record.toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class Expand {
  @JsonKey(name: "users")
  List<User>? users;

  Expand({
    this.users,
  });

  Expand copyWith({
    List<User>? users,
  }) =>
      Expand(
        users: users ?? this.users,
      );
  factory Expand.fromRecord(RecordModel record) =>
      Expand.fromJson(record.toJson());

  factory Expand.fromJson(Map<String, dynamic> json) => _$ExpandFromJson(json);

  Map<String, dynamic> toJson() => _$ExpandToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "avatar")
  String? avatar;
  @JsonKey(name: "banner")
  String? banner;
  @JsonKey(name: "bio")
  String? bio;
  @JsonKey(name: "collectionId")
  String? collectionId;
  @JsonKey(name: "collectionName")
  String? collectionName;
  @JsonKey(name: "created")
  DateTime? created;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "emailVisibility")
  bool? emailVisibility;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "updated")
  DateTime? updated;
  @JsonKey(name: "username")
  String? username;
  @JsonKey(name: "verified")
  bool? verified;

  User({
    this.avatar,
    this.banner,
    this.bio,
    this.collectionId,
    this.collectionName,
    this.created,
    this.email,
    this.emailVisibility,
    this.id,
    this.name,
    this.updated,
    this.username,
    this.verified,
  });

  User copyWith({
    String? avatar,
    String? banner,
    String? bio,
    String? collectionId,
    String? collectionName,
    DateTime? created,
    String? email,
    bool? emailVisibility,
    String? id,
    String? name,
    DateTime? updated,
    String? username,
    bool? verified,
  }) =>
      User(
        avatar: avatar ?? this.avatar,
        banner: banner ?? this.banner,
        bio: bio ?? this.bio,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        created: created ?? this.created,
        email: email ?? this.email,
        emailVisibility: emailVisibility ?? this.emailVisibility,
        id: id ?? this.id,
        name: name ?? this.name,
        updated: updated ?? this.updated,
        username: username ?? this.username,
        verified: verified ?? this.verified,
      );
  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

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
    @JsonKey(name: "createdBy")
    String createdBy;
    @JsonKey(name: "createdWith")
    String createdWith;
    @JsonKey(name: "expand")
    Expand expand;
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "updated")
    DateTime updated;

    Chat({
        required this.collectionId,
        required this.collectionName,
        required this.created,
        required this.createdBy,
        required this.createdWith,
        required this.expand,
        required this.id,
        required this.updated,
    });

  factory Chat.fromRecord(RecordModel record) =>
      Chat.fromJson(record.toJson());
    factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

    Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class Expand {
    @JsonKey(name: "createdBy")
    Created createdBy;
    @JsonKey(name: "createdWith")
    Created createdWith;

    Expand({
        required this.createdBy,
        required this.createdWith,
    });

  factory Expand.fromRecord(RecordModel record) =>
      Expand.fromJson(record.toJson());
    factory Expand.fromJson(Map<String, dynamic> json) => _$ExpandFromJson(json);

    Map<String, dynamic> toJson() => _$ExpandToJson(this);
}

@JsonSerializable()
class Created {
    @JsonKey(name: "avatar")
    String avatar;
    @JsonKey(name: "banner")
    String banner;
    @JsonKey(name: "bio")
    String bio;
    @JsonKey(name: "collectionId")
    String collectionId;
    @JsonKey(name: "collectionName")
    String collectionName;
    @JsonKey(name: "created")
    DateTime created;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "emailVisibility")
    bool emailVisibility;
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "name")
    String name;
    @JsonKey(name: "updated")
    DateTime updated;
    @JsonKey(name: "username")
    String username;
    @JsonKey(name: "verified")
    bool verified;

    Created({
        required this.avatar,
        required this.banner,
        required this.bio,
        required this.collectionId,
        required this.collectionName,
        required this.created,
        this.email,
        required this.emailVisibility,
        required this.id,
        required this.name,
        required this.updated,
        required this.username,
        required this.verified,
    });

  factory Created.fromRecord(RecordModel record) =>
      Created.fromJson(record.toJson());
    factory Created.fromJson(Map<String, dynamic> json) => _$CreatedFromJson(json);

    Map<String, dynamic> toJson() => _$CreatedToJson(this);
}

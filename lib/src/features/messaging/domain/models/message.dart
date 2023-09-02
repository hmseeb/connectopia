import 'package:json_annotation/json_annotation.dart';
import 'package:pocketbase/pocketbase.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  @JsonKey(name: "chat")
  String chat;
  @JsonKey(name: "collectionId")
  String collectionId;
  @JsonKey(name: "collectionName")
  String collectionName;
  @JsonKey(name: "content")
  String content;
  @JsonKey(name: "created")
  DateTime created;
  @JsonKey(name: "expand")
  Expand expand;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "receiver")
  String receiver;
  @JsonKey(name: "sender")
  String sender;
  @JsonKey(name: "updated")
  DateTime updated;

  Message({
    required this.chat,
    required this.collectionId,
    required this.collectionName,
    required this.content,
    required this.created,
    required this.expand,
    required this.id,
    required this.receiver,
    required this.sender,
    required this.updated,
  });
  factory Message.fromRecord(RecordModel record) =>
      Message.fromJson(record.toJson());

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Expand {
  @JsonKey(name: "chat")
  Chat chat;
  @JsonKey(name: "receiver")
  Receiver receiver;
  @JsonKey(name: "sender")
  Receiver sender;

  Expand({
    required this.chat,
    required this.receiver,
    required this.sender,
  });
    factory Expand.fromRecord(RecordModel record) =>
      Expand.fromJson(record.toJson());

  factory Expand.fromJson(Map<String, dynamic> json) => _$ExpandFromJson(json);

  Map<String, dynamic> toJson() => _$ExpandToJson(this);
}

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
    required this.id,
    required this.updated,
  });
    factory Chat.fromRecord(RecordModel record) =>
      Chat.fromJson(record.toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class Receiver {
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
  String email;
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

  Receiver({
    required this.avatar,
    required this.banner,
    required this.bio,
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.email,
    required this.emailVisibility,
    required this.id,
    required this.name,
    required this.updated,
    required this.username,
    required this.verified,
  });
    factory Receiver.fromRecord(RecordModel record) =>
      Receiver.fromJson(record.toJson());

  factory Receiver.fromJson(Map<String, dynamic> json) =>
      _$ReceiverFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiverToJson(this);
}

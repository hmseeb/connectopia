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
  Expand? expand;
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
    this.expand,
    required this.id,
    required this.receiver,
    required this.sender,
    required this.updated,
  });

  Message copyWith({
    String? chat,
    String? collectionId,
    String? collectionName,
    String? content,
    DateTime? created,
    Expand? expand,
    String? id,
    String? receiver,
    String? sender,
    DateTime? updated,
  }) =>
      Message(
        chat: chat ?? this.chat,
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        content: content ?? this.content,
        created: created ?? this.created,
        expand: expand ?? this.expand,
        id: id ?? this.id,
        receiver: receiver ?? this.receiver,
        sender: sender ?? this.sender,
        updated: updated ?? this.updated,
      );

  factory Message.fromRecord(RecordModel record) =>
      Message.fromJson(record.toJson());

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class Expand {
  @JsonKey(name: "chat")
  Chat? chat;
  @JsonKey(name: "receiver")
  Receiver? receiver;
  @JsonKey(name: "sender")
  Receiver? sender;

  Expand({
    this.chat,
    this.receiver,
    this.sender,
  });

  Expand copyWith({
    Chat? chat,
    Receiver? receiver,
    Receiver? sender,
  }) =>
      Expand(
        chat: chat ?? this.chat,
        receiver: receiver ?? this.receiver,
        sender: sender ?? this.sender,
      );

  factory Expand.fromRecord(RecordModel record) =>
      Expand.fromJson(record.toJson());

  factory Expand.fromJson(Map<String, dynamic> json) => _$ExpandFromJson(json);

  Map<String, dynamic> toJson() => _$ExpandToJson(this);
}

@JsonSerializable()
class Chat {
  @JsonKey(name: "collectionId")
  String? collectionId;
  @JsonKey(name: "collectionName")
  String? collectionName;
  @JsonKey(name: "created")
  DateTime? created;
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "updated")
  DateTime? updated;
  @JsonKey(name: "users")
  List<String>? users;

  Chat({
    this.collectionId,
    this.collectionName,
    this.created,
    this.id,
    this.updated,
    this.users,
  });

  Chat copyWith({
    String? collectionId,
    String? collectionName,
    DateTime? created,
    String? id,
    DateTime? updated,
    List<String>? users,
  }) =>
      Chat(
        collectionId: collectionId ?? this.collectionId,
        collectionName: collectionName ?? this.collectionName,
        created: created ?? this.created,
        id: id ?? this.id,
        updated: updated ?? this.updated,
        users: users ?? this.users,
      );

  factory Chat.fromRecord(RecordModel record) => Chat.fromJson(record.toJson());

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  Map<String, dynamic> toJson() => _$ChatToJson(this);
}

@JsonSerializable()
class Receiver {
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

  Receiver({
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

  Receiver copyWith({
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
      Receiver(
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

  factory Receiver.fromRecord(RecordModel record) =>
      Receiver.fromJson(record.toJson());

  factory Receiver.fromJson(Map<String, dynamic> json) =>
      _$ReceiverFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiverToJson(this);
}

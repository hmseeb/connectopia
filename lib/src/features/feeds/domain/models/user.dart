import 'package:json_annotation/json_annotation.dart';
import "package:pocketbase/pocketbase.dart";

part 'user.g.dart';

@JsonSerializable()
class User {
  User(
      {this.id = '',
      this.username = '',
      this.email = '',
      this.name = '',
      this.avatar = ''});

  // type the collection fields you want to use...
  final String id;
  final String username;
  final String email;
  final String name;
  final String avatar;

  /// Creates a new User instance form the provided RecordModel.
  factory User.fromRecord(RecordModel record) => User.fromJson(record.toJson());

  /// Connect the generated [_$User] function to the `fromJson` factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$User] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

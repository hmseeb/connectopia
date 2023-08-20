import 'package:json_annotation/json_annotation.dart';
import "package:pocketbase/pocketbase.dart";

part 'post.g.dart';

@JsonSerializable()
class Post {
  Post({
    this.username = '',
    this.image = const [],
    this.name = '',
    this.caption = '',
    this.location = '',
  });

  // type the collection fields you want to use...
  final String username;
  final List<String> image;
  final String name;
  final String caption;
  final String location;

  /// Creates a new Post instance form the provided RecordModel.
  factory Post.fromRecord(RecordModel record) => Post.fromJson(record.toJson());

  /// Connect the generated [_$Post] function to the `fromJson` factory.
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// Connect the generated [_$Post] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostToJson(this);
}

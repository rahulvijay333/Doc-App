import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  String? user;
  String? comment;
  @JsonKey(name: '_id')
  String? id;

  Comment({this.user, this.comment, this.id});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return _$CommentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

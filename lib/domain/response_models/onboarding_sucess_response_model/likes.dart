import 'package:json_annotation/json_annotation.dart';

part 'likes.g.dart';

@JsonSerializable()
class Likes {
  int? number;
  List<String>? user;

  Likes({this.number, this.user});

  factory Likes.fromJson(Map<String, dynamic> json) => _$LikesFromJson(json);

  Map<String, dynamic> toJson() => _$LikesToJson(this);
}

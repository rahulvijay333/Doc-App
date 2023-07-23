import 'package:json_annotation/json_annotation.dart';

part 'ratings.g.dart';

@JsonSerializable()
class Ratings {
  int? number;
  List<String>? user;

  Ratings({this.number, this.user});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return _$RatingsFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RatingsToJson(this);
}

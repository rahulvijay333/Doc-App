import 'package:json_annotation/json_annotation.dart';

part 'profile_picture.g.dart';

@JsonSerializable()
class ProfilePicture {
  @JsonKey(name: 'public_id')
  String? publicId;
  @JsonKey(name: 'secure_url')
  String? secureUrl;

  ProfilePicture({this.publicId, this.secureUrl});

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return _$ProfilePictureFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfilePictureToJson(this);
}

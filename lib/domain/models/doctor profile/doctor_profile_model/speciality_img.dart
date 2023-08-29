import 'package:json_annotation/json_annotation.dart';

part 'speciality_img.g.dart';

@JsonSerializable()
class SpecialityImg {
  @JsonKey(name: 'public_id')
  String? publicId;
  @JsonKey(name: 'secure_url')
  String? secureUrl;

  SpecialityImg({this.publicId, this.secureUrl});

  factory SpecialityImg.fromJson(Map<String, dynamic> json) {
    return _$SpecialityImgFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SpecialityImgToJson(this);
}

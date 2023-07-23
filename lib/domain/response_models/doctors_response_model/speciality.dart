import 'package:json_annotation/json_annotation.dart';

import 'speciality_img.dart';

part 'speciality.g.dart';

@JsonSerializable()
class Speciality {
  SpecialityImg? specialityImg;
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? fees;
  bool? isAdminVerified;
  @JsonKey(name: '__v')
  int? v;

  Speciality({
    this.specialityImg,
    this.id,
    this.name,
    this.fees,
    this.isAdminVerified,
    this.v,
  });

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return _$SpecialityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SpecialityToJson(this);
}

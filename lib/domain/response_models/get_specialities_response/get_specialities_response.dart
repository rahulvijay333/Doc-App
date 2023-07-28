import 'package:json_annotation/json_annotation.dart';

import 'speciality.dart';

part 'get_specialities_response.g.dart';

@JsonSerializable()
class GetSpecialitiesResponse {
  bool? success;
  List<Speciality>? specialities;

  GetSpecialitiesResponse({this.success, this.specialities});

  factory GetSpecialitiesResponse.fromJson(Map<String, dynamic> json) {
    return _$GetSpecialitiesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetSpecialitiesResponseToJson(this);
}

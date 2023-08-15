import 'package:json_annotation/json_annotation.dart';

part 'certificate.g.dart';

@JsonSerializable()
class Certificate {
  @JsonKey(name: 'public_id')
  String? publicId;
  @JsonKey(name: 'secure_url')
  String? secureUrl;

  Certificate({this.publicId, this.secureUrl});

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return _$CertificateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CertificateToJson(this);
}

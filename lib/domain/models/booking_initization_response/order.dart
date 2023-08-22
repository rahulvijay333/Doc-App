import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  String? id;
  String? entity;
  int? amount;
  @JsonKey(name: 'amount_paid')
  int? amountPaid;
  @JsonKey(name: 'amount_due')
  int? amountDue;
  String? currency;
  String? receipt;
  @JsonKey(name: 'offer_id')
  dynamic offerId;
  String? status;
  int? attempts;
  List<dynamic>? notes;
  @JsonKey(name: 'created_at')
  int? createdAt;

  Order({
    this.id,
    this.entity,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.receipt,
    this.offerId,
    this.status,
    this.attempts,
    this.notes,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

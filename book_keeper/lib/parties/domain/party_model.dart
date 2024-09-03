import 'package:json_annotation/json_annotation.dart';

part 'party_model.g.dart';

@JsonSerializable()
class PartyModel {
  final int? id;
  final String? type;
  final String? name;
  final String? phone;
  final int? balance;
  @JsonKey(name: "business")
  final int? businessId;

  PartyModel({
    this.id,
    this.type,
    this.name,
    this.phone,
    this.balance,
    this.businessId,
  });

  factory PartyModel.fromJson(Map<String, dynamic> json) =>
      _$PartyModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartyModelToJson(this);
}

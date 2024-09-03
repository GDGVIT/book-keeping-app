import 'package:json_annotation/json_annotation.dart';

part 'business_model.g.dart';

@JsonSerializable()
class BusinessModel {
  final int? id;
  final String? name;
  final String? address;
  final String? phone;
  final String? email;
  final String? website;
  final String? description;

  BusinessModel({
    this.id,
    this.name,
    this.address,
    this.phone,
    this.email,
    this.website,
    this.description,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) =>
        _$BusinessModelFromJson(json);

  Map<String?, dynamic> toJson() => _$BusinessModelToJson(this);
}

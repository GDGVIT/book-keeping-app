import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String businessName;
  final String businessId;
  final String businessEmail;
  final String businessPhone;
  final String businessAddress;
  final String businessGstNumber;
  final String businessPanNumber;
  final double closingBalance;

  ProfileModel({
    required this.businessName,
    required this.businessId,
    required this.businessEmail,
    required this.businessPhone,
    required this.businessAddress,
    required this.businessGstNumber,
    required this.businessPanNumber,
    required this.closingBalance,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
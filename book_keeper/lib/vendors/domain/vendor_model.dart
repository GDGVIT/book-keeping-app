import 'package:json_annotation/json_annotation.dart';

part 'vendor_model.g.dart';

@JsonSerializable()
class VendorModel {
  // vendor name
  // vendor id
  // vendor email
  // vendor phone
  // vendor address
  // vendor_gst_number
  // vendor_pan_number
  // closing_balance

  final String vendorName;
  final String vendorId;
  final String vendorEmail;
  final String vendorPhone;
  final String vendorAddress;
  final String vendorGstNumber;
  final String vendorPanNumber;
  final double closingBalance;

  VendorModel({
    required this.vendorName,
    required this.vendorId,
    required this.vendorEmail,
    required this.vendorPhone,
    required this.vendorAddress,
    required this.vendorGstNumber,
    required this.vendorPanNumber,
    required this.closingBalance,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) =>
      _$VendorModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$VendorModelToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorModel _$VendorModelFromJson(Map<String, dynamic> json) => VendorModel(
      vendorName: json['vendorName'] as String,
      vendorId: json['vendorId'] as String,
      vendorEmail: json['vendorEmail'] as String,
      vendorPhone: json['vendorPhone'] as String,
      vendorAddress: json['vendorAddress'] as String,
      vendorGstNumber: json['vendorGstNumber'] as String,
      vendorPanNumber: json['vendorPanNumber'] as String,
      closingBalance: (json['closingBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$VendorModelToJson(VendorModel instance) =>
    <String, dynamic>{
      'vendorName': instance.vendorName,
      'vendorId': instance.vendorId,
      'vendorEmail': instance.vendorEmail,
      'vendorPhone': instance.vendorPhone,
      'vendorAddress': instance.vendorAddress,
      'vendorGstNumber': instance.vendorGstNumber,
      'vendorPanNumber': instance.vendorPanNumber,
      'closingBalance': instance.closingBalance,
    };

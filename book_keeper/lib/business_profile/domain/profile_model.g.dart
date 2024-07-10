// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
      businessName: json['businessName'] as String,
      businessId: json['businessId'] as String,
      businessEmail: json['businessEmail'] as String,
      businessPhone: json['businessPhone'] as String,
      businessAddress: json['businessAddress'] as String,
      businessGstNumber: json['businessGstNumber'] as String,
      businessPanNumber: json['businessPanNumber'] as String,
      closingBalance: (json['closingBalance'] as num).toDouble(),
    );

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'businessName': instance.businessName,
      'businessId': instance.businessId,
      'businessEmail': instance.businessEmail,
      'businessPhone': instance.businessPhone,
      'businessAddress': instance.businessAddress,
      'businessGstNumber': instance.businessGstNumber,
      'businessPanNumber': instance.businessPanNumber,
      'closingBalance': instance.closingBalance,
    };
